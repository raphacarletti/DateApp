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
        self.channelController?.delegate = self
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
        channelController?.loadPreviousMessages(before: channelController?.messages.first?.id) {error in
            completion(error)
        }
    }

    func sendMessage(text: String) {
        channelController?.createNewMessage(text: text)
    }

    func likeMessage(messageId: MessageId) {
        chatClient?.messageController(cid: channelId, messageId: messageId).addReaction("like")
    }

    func unlikeMessage(messageId: MessageId) {
        chatClient?.messageController(cid: channelId, messageId: messageId).deleteReaction("like")
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
