import Foundation
import StreamChat
import Starscream

protocol ConversationControllerDelegate {
    func didUpdateRow(at indexPath: IndexPath)
    func didInsertRow(at indexPath: IndexPath)
}

final class ConversationController {
    private let channelId: ChannelId
    private let chatClient = Chat.shared.client
    private let channelController: ChatChannelController?
    lazy var delegate: ConversationControllerDelegate? = nil

    var orderedChatMessages: [[ChatMessage]] {
        guard let messages = channelController?.messages else { return [] }
        var orderedMessages: [[ChatMessage]] = []
        var auxMessages: [ChatMessage] = []
        var actualDate = messages.first?.createdAt ?? Date()
        for message in messages {
            if Calendar.current.isDate(actualDate, inSameDayAs: message.createdAt) {
                auxMessages.append(message)
            } else {
                orderedMessages.append(auxMessages)
                actualDate = message.createdAt
                auxMessages = [message]
            }
        }
        orderedMessages.append(auxMessages)
        return orderedMessages
    }

    init(channelId: ChannelId) {
        self.channelId = channelId
        self.channelController = chatClient?.channelController(for: channelId)
    }

    func getChannelName() -> String {
        let member = channelController?.channel?.cachedMembers.first(where: { member in
            return member.name != Chat.shared.currentUserName
        })
        return member?.name ?? ""
    }

    func getPhotoImageUrl() -> URL? {
        let member = channelController?.channel?.cachedMembers.first(where: { member in
            return member.name != Chat.shared.currentUserName
        })
        return member?.imageURL
    }

    func getMessages(completion: @escaping (Error?) -> Void) {
        channelController?.loadPreviousMessages(before: channelController?.messages.first?.id) { [weak self] error in
            guard let self = self else { return }
            if error == nil {
                self.channelController?.markRead()
                self.channelController?.delegate = self
            }
            completion(error)
        }
    }

    func sendMessage(text: String) {
        channelController?.createNewMessage(text: text)
    }

    func sendEventMessage() {
        let dateFormatter = ISO8601DateFormatter()
        let event = Event(name: "Cafeteria", startTime: dateFormatter.string(from: Date()), url: "", venue: "Chelsea", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. In eu commodo enim, dignissim fringilla lectus. Phasellus condimentum euismod justo, in sodales nulla efficitur quis. In enim metus, euismod tincidunt tortor vel, dignissim tempus odio. Quisque vestibulum lacus nunc, sit amet iaculis nulla placerat vel. Vivamus a egestas dolor. Curabitur vulputate.", imgUrl: "https://colunadogilson.com.br/cac/wp-content/uploads/cafeteria.jpg", endTime: "", id: 1, status: "")
        let attachment = EventAttachment(event: event)
        channelController?.createNewMessage(text: "", attachments: [attachment])
    }

    func likeMessage(messageId: MessageId) {
        chatClient?.messageController(cid: channelId, messageId: messageId).addReaction("like")
    }

    func unlikeMessage(messageId: MessageId) {
        chatClient?.messageController(cid: channelId, messageId: messageId).deleteReaction("like")
    }

    func getOtherPersonLastReadAt() -> Date {
        return channelController?.channel?.reads.filter({
            $0.user.name != Chat.shared.currentUserName
        }).first?.lastReadAt ?? Date()
    }
}

extension ConversationController: ChatChannelControllerDelegate {
    func channelController(_ channelController: ChatChannelController, didUpdateMessages changes: [ListChange<ChatMessage>]) {
        let messages = orderedChatMessages
        for change in changes {
            switch change {
            case let .insert(message, index: _):
                var section: Int = 0
                var row: Int = 0
                for i in 0..<messages.count {
                    if messages[i].contains(message) {
                        section = i
                        row = messages[i].firstIndex(of: message) ?? 0
                    }
                }
                let indexPath = IndexPath(row: row, section: section)
                delegate?.didInsertRow(at: indexPath)
                channelController.markRead()
            case let .update(message, index: _):
                var section: Int = 0
                var row: Int = 0
                for i in 0..<messages.count {
                    if messages[i].contains(message) {
                        section = i
                        row = messages[i].firstIndex(of: message) ?? 0
                    }
                }
                let indexPath = IndexPath(row: row, section: section)
                delegate?.didUpdateRow(at: indexPath)
            default:
                break
            }
        }
    }
}
