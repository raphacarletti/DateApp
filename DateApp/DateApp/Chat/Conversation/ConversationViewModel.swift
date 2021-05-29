import UIKit
import StreamChat

final class ConversationViewModel {
    let controller: ConversationController

    init(controller: ConversationController) {
        self.controller = controller
    }

    func getChannelName() -> String {
        controller.getChannelName()
    }

    func getPhotoImageUrl() -> URL? {
        controller.getPhotoImageUrl()
    }

    func getMessages(completion: @escaping (Error?) -> Void) {
        controller.getMessages(completion: completion)
    }

    func getHeaderText(for section: Int) -> String {
        guard let date = controller.orderedChatMessages[safe: section]?.first?.createdAt else { return "" }
        if Calendar.current.isDateInToday(date) {
            return "TODAY"
        } else if Calendar.current.isDateInYesterday(date) {
            return "YESTERDAY"
        } else {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            return dateFormatter.string(from: date)
        }
    }

    func sendMessage(text: String) {
        controller.sendMessage(text: text)
    }
    
    func numberOfSections() -> Int {
        return controller.orderedChatMessages.count
    }

    func numberOfRows(in section: Int) -> Int {
        return controller.orderedChatMessages[section].count
    }

    func cellForRow(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ChatTextTableViewCell.self), for: indexPath) as? ChatTextTableViewCell,
            let message = controller.orderedChatMessages[safe: indexPath.section]?[safe: indexPath.row]
        else {
            return UITableViewCell()
        }
        cell.transform = CGAffineTransform(rotationAngle: .pi)
        cell.delegate = self
        cell.set(message: message)
        return cell
    }
}

extension ConversationViewModel: ChatTextTableViewCellDelegate {
    func likeMessage(messageId: MessageId) {
        controller.likeMessage(messageId: messageId)
    }

    func unlikeMessage(messageId: MessageId) {
        controller.unlikeMessage(messageId: messageId)
    }
}
