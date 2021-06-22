import UIKit

final class ForYouViewModel {
    private let worker = ForYouWorker()
    private var recommendedEvents: [Event] = []
    private var recommendedPodcasts: [Event] = []
    private var spiritualWellness: [Event] = []
    private var physicalWellness: [Event] = []
    private var socialWellness: [Event] = []
    private(set) var selectedEvent: Event?
    var setSpotlightEvent: ((Event) -> Void)?

    func getEvents() {
        let events = worker.getEvents()
        recommendedEvents = events
        recommendedPodcasts = events
        spiritualWellness = events
        physicalWellness = events
        socialWellness = events
        guard let event = events.first else { return }
        setSpotlightEvent?(event)
    }

    func setSelectedEvent(_ event: Event) {
        selectedEvent = event
    }

    func numberOfItems(for type: CollectionEventsView.EventType) -> Int {
        switch type {
        case .recommendedEvents:
            return recommendedEvents.count
        case .recommendedPodcasts:
            return recommendedPodcasts.count
        case .spiritualWellness:
            return spiritualWellness.count
        case .physicalWellness:
            return physicalWellness.count
        case .socialWellness:
            return socialWellness.count
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
        case .recommendedEvents:
            return recommendedEvents[indexPath.row]
        case .recommendedPodcasts:
            return recommendedPodcasts[indexPath.row]
        case .spiritualWellness:
            return spiritualWellness[indexPath.row]
        case .physicalWellness:
            return physicalWellness[indexPath.row]
        case .socialWellness:
            return socialWellness[indexPath.row]
        default:
            return nil
        }
    }
}
