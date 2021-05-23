import UIKit

final class EventDetailViewModel {
    private(set) var event: Event?

    func set(event: Event?) {
        self.event = event
    }

    func numberOfItems() -> Int {
        return 3
    }

    func cellForItem(collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: EventCollectionViewCell.self), for: indexPath) as? EventCollectionViewCell,
            let event = event
        else {
            return UICollectionViewCell()
        }
        cell.set(event: event)
        return cell
    }
}
