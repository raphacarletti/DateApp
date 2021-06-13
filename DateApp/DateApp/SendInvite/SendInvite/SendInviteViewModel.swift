import UIKit

final class SendInviteViewModel {
    private let worker = SendInviteWorker()
    private var profiles: [[Profile]] = []
    private var selectedCells: [Int] = [] {
        didSet {
            shouldShowSendInviteButton?(!selectedCells.isEmpty)
        }
    }
    var reloadRow: ((IndexPath) -> Void)?
    var shouldShowSendInviteButton: ((Bool) -> Void)?

    func getProfiles() {
        profiles = worker.getProfiles()
    }
    
    func getHeaderText(section: Int) -> String {
        return section == 0 ? "Pinned" : "Others"
    }

    func numberOfSection() -> Int {
        return profiles.count
    }

    func numberOfRows(in section: Int) -> Int {
        return profiles[safe: section]?.count ?? 0
    }

    func cellForRow(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SendInviteProfileTableViewCell.self), for: indexPath) as? SendInviteProfileTableViewCell, let profile = profiles[safe: indexPath.section]?[safe: indexPath.row] else {
            return UITableViewCell()
        }

        cell.set(profile: profile, isSendInviteTapped: selectedCells.contains(profile.id), delegate: self)

        return cell
    }
}

extension SendInviteViewModel: SendInviteProfileTableViewCellDelegate {
    func didTapSendInviteButton(id: Int) {
        guard let section = profiles.firstIndex(where: { $0.contains(where: { $0.id == id })}), let row = profiles[section].firstIndex(where: { $0.id == id }) else { return }
        if let index = selectedCells.firstIndex(of: id) {
            selectedCells.remove(at: index)
        } else {
            selectedCells.append(id)
        }
        reloadRow?(IndexPath(row: row, section: section))
    }
}
