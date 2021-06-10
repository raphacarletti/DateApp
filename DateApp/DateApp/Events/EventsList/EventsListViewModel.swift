import UIKit

final class EventsListViewModel {
    private var events: [Event] = []
    private(set) var selectedEvent: Event?
    private let worker = EventsListWorker()
    private var expandedCells: [Int] = []
    var reloadRow: ((Int) -> Void)?

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
        cell.set(event: event, isExpanded: expandedCells.contains(event.id), delegate: self)
        return cell
    }

    func selectEvent(indexPath: IndexPath) {
        selectedEvent = events[safe: indexPath.row]
    }
}

extension EventsListViewModel: EventSummaryViewDelegate {
    func didTapDetailButton(id: Int) {
        guard let row = events.firstIndex(where: { $0.id == id }) else { return }
        if let index = expandedCells.firstIndex(of: id) {
            expandedCells.remove(at: index)
        } else {
            expandedCells.append(id)
        }
        reloadRow?(row)
    }
}
