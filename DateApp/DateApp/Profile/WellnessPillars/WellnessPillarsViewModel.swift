import UIKit

final class WellnessPillarsViewModel {
    private let wellnessPillars: WellnessPillars.AllCases = WellnessPillars.allCases

    func numberOfRows() -> Int {
        return wellnessPillars.count
    }

    func cellForRow(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WellnessPillarTableViewCell.self), for: indexPath) as? WellnessPillarTableViewCell, let wellnessPillar = wellnessPillars[safe: indexPath.row] else {
            return UITableViewCell()
        }

        cell.set(for: wellnessPillar)
        return cell
    }
}
