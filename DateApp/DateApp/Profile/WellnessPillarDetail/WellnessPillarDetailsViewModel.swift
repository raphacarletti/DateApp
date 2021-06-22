import UIKit

final class WellnessPillarDetailsViewModel {
    private let worker = WellnessPillarDetailsWorker()
    private var events: [Event] = []
    private var benefits: [Event] = []
    private var content: [Event] = []
    private(set) var selectedEvent: Event?

    func getEvents() {
        events = worker.getEvents()
    }

    func getBenefits() {
        benefits = worker.getBenefits()
    }

    func getContent() {
        content = worker.getContent()
    }

    func setSelectedEvent(_ event: Event) {
        selectedEvent = event
    }

    func numberOfItems(for type: CollectionEventsView.EventType) -> Int {
        switch type {
        case .events:
            return events.count
        case .benefits:
            return benefits.count
        case .content:
            return content.count
        default:
            return 0
        }
    }

    func cellForItem(for type: CollectionEventsView.EventType, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EventCollectionViewCell.self), for: indexPath) as? EventCollectionViewCell, let event = getEvent(for: type, indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        
        cell.set(event: event)

        return cell
    }

    func getEvent(for type: CollectionEventsView.EventType, indexPath: IndexPath) -> Event? {
        switch type {
        case .events:
            return events[indexPath.row]
        case .benefits:
            return benefits[indexPath.row]
        case .content:
            return content[indexPath.row]
        default:
            return nil
        }
    }
}
