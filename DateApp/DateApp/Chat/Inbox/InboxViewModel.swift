import UIKit
import StreamChat

final class InboxViewModel {
    private var pinnedChatIds = UserDefaultUtils().getPinnedMessages()
    private var pinnedChats: LazyCachedMapCollection<_ChatChannel<NoExtraData>> {
        guard let channels = Chat.shared.channelListController?.channels else { return [] }
        return channels.filter {
            return pinnedChatIds.contains($0.cid.id)
        }.lazyCachedMap { channel in
            return channel
        }
    }
    private var otherChats: LazyCachedMapCollection<_ChatChannel<NoExtraData>> {
        guard let channels = Chat.shared.channelListController?.channels else { return [] }
        return channels.filter {
            return !pinnedChatIds.contains($0.cid.id)
        }.lazyCachedMap { channel in
            return channel
        }
    }

    private(set) var selectedChannelId: ChannelId?

    var reloadTable: (() -> ())?

    func setSelectedChannelId(for indexPath: IndexPath) {
        let channelId: ChannelId
        if indexPath.section == 0 {
            guard let chat = pinnedChats[safe: indexPath.row] else { return }
            channelId = chat.cid
        } else {
            guard let chat = otherChats[safe: indexPath.row] else { return }
            channelId = chat.cid
        }
        selectedChannelId = channelId
    }


    func getChannels(completion: @escaping () -> Void) {
        Chat.shared.getChannels { [weak self] error in
            guard let self = self else { return }
            if error == nil {
                self.reloadTable?()
            }
            completion()
        }
    }

    func numberOfSections() -> Int {
        return 2
    }

    func numberOfRows(in section: Int) -> Int {
        return section == 0 ? pinnedChats.count : otherChats.count
    }

    func cellForRow(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let channel: ChatChannel
        if indexPath.section == 0 {
            channel = pinnedChats[indexPath.row]
        } else {
            channel = otherChats[indexPath.row]
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InboxChatTableViewCell.self), for: indexPath) as? InboxChatTableViewCell else {
            return UITableViewCell()
        }
        cell.set(with: channel)
        return cell
    }

    func pinAction(indexPath: IndexPath) {
        if indexPath.section == 0 {
            guard let chat = pinnedChats[safe: indexPath.row],
                  let index = pinnedChatIds.firstIndex(where: { $0 == chat.cid.id })
            else { return }
            pinnedChatIds.remove(at: index)
            UserDefaultUtils().save(object: pinnedChatIds)
        } else {
            guard let chat = otherChats[safe: indexPath.row] else { return }
            pinnedChatIds.append(chat.cid.id)
            UserDefaultUtils().save(object: pinnedChatIds)
        }
        reloadTable?()
    }

    func pinSwipeAction(indexPath: IndexPath) -> UIContextualAction {
        let title = indexPath.section == 0 ? "Unpin" : "Pin"
        let pinButton = UIContextualAction(style: .normal, title: title, handler: { [weak self] action, view, completion in
            guard let self = self else { return }
            self.pinAction(indexPath: indexPath)
            completion(true)
        })
        pinButton.backgroundColor = .white
        pinButton.image = UIGraphicsImageRenderer(size: CGSize(width: 20, height: 20)).image(actions: { _ in
            UIImage.pinIcon?.draw(in: CGRect(x: 0, y: 0, width: 20, height: 20))
        })

        return pinButton
    }

    func unmatchSwipeAction() -> UIContextualAction {
        let unmatchButton = UIContextualAction(style: .normal, title: "Unmatch", handler: { [weak self] action, view, completion in
            guard let self = self else { return }
            completion(true)
        })
        unmatchButton.backgroundColor = .white
        unmatchButton.image = UIGraphicsImageRenderer(size: CGSize(width: 20, height: 20)).image(actions: { _ in
            UIImage.trashIcon?.draw(in: CGRect(x: 0, y: 0, width: 20, height: 20))
        })

        return unmatchButton
    }

    func reportSwipeAction() -> UIContextualAction {
        let reportButton =  UIContextualAction(style: .normal, title: "Report", handler: { [weak self] action, view, completion in
            guard let self = self else { return }
            completion(true)
        })
        reportButton.backgroundColor = .white
        reportButton.image = UIGraphicsImageRenderer(size: CGSize(width: 25, height: 25)).image(actions: { _ in
            UIImage.flagIcon?.draw(in: CGRect(x: 0, y: 0, width: 25, height: 25))
        })

        return reportButton
    }
}
