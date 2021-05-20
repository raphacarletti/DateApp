import UIKit

final class EventsListViewModel {
    private var events: [Event] = [Event(image: .yogaClass, title: "Yoga Class", location: "Yoga class center", date: Date()), Event(image: .cafeteria, title: "Cafeteria", location: "Chelsea", date: Date()), Event(image: .veganCafeteria, title: "Vegan Cafeteira Opening", location: "Shoreditch", date: Date())]

    func numberOfRows() -> Int {
        return events.count
    }

    func cellForRow(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventTableViewCell.self), for: indexPath) as? EventTableViewCell,
            let event = events[safe: indexPath.row] else {
            return UITableViewCell()
        }
        cell.set(event: event)
        return cell
    }
}
