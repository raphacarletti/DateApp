import UIKit

final class EventDetailViewModel {
    private let worker = EventDetailWorker()
    private(set) var event: Event?
    private(set) var relatedEvents: [Event] = []

    func getRelatedEvents() {
        relatedEvents = worker.getRelatedEvents()
    }

    func set(event: Event?) {
        self.event = event
    }

    func getEvent(with indexPath: IndexPath) -> Event? {
        return relatedEvents[safe: indexPath.row]
    }

    func numberOfItems() -> Int {
        return relatedEvents.count
    }

    func cellForItem(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EventCollectionViewCell.self), for: indexPath) as? EventCollectionViewCell,
            let event = relatedEvents[safe: indexPath.row]
        else {
            return UICollectionViewCell()
        }
        cell.set(event: event)
        return cell
    }
}
