import UIKit

final class EventsListViewModel {
    private var events: [Event] = []
    private(set) var selectedEvent: Event?
    private let worker = EventsListWorker()

    func getEvents() {
        events = worker.getEvents()
    }

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

    func selectEvent(indexPath: IndexPath) {
        selectedEvent = events[safe: indexPath.row]
    }
}
