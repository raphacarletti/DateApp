import Foundation
import StreamChat

final class InboxViewModel {
    private var channels: LazyCachedMapCollection<_ChatChannel<NoExtraData>> = []
    private var pinnedChatIds = UserDefaultUtils().getPinnedMessages()
    private var pinnedChats: LazyCachedMapCollection<_ChatChannel<NoExtraData>> {
        return channels.filter {
            return pinnedChatIds.contains($0.cid.id)
        }.lazyCachedMap { channel in
            return channel
        }
    }
    private var otherChats: LazyCachedMapCollection<_ChatChannel<NoExtraData>> {
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
        Chat.shared.getChannels { [weak self] channelsResponse in
            guard let self = self else { return }
            self.channels = channelsResponse
            self.reloadTable?()
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: InboxChatTableViewCell.self), for: indexPath) as? InboxChatTableViewCell, let channel = channels[safe: indexPath.row] else {
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
}
