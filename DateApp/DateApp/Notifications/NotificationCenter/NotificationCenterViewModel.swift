import UIKit

final class NotificationCenterViewModel {
    private let worker = NotificationCenterWorker()
    private var notifications: [[AppNotification]] = []

    func getName(for section: Int) -> String {
        guard let notificationDate = notifications[section].first?.date else { return "" }
        let calendar = Calendar.current
        if calendar.isDateInToday(notificationDate) {
            return "Today"
        } else if calendar.isDateInYesterday(notificationDate) {
            return "Yesterday"
        } else {
            return notificationDate.notificationHeaderFormat
        }
    }

    func getNotifications() {
        notifications = worker.getNotifications()
    }

    func numberOfSections() -> Int {
        return notifications.count
    }

    func numberOfRows(in section: Int) -> Int {
        return notifications[section].count
    }

    func cellForRow(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NotificationTableViewCell.self), for: indexPath) as? NotificationTableViewCell, let notification = notifications[safe: indexPath.section]?[safe: indexPath.row] else {
            return UITableViewCell()
        }

        cell.customize(with: notification)

        return cell
    }
}
