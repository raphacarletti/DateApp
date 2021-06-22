import UIKit

protocol CollectionEventsViewDelegate: AnyObject {
    func numberOfItems(for type: CollectionEventsView.EventType) -> Int
    func cellForItem(for type: CollectionEventsView.EventType, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func goToEvent(for type: CollectionEventsView.EventType, indexPath: IndexPath)
}

class CollectionEventsView: CustomView {
    enum EventType: CaseIterable {
        case events
        case benefits
        case content
        case recommendedEvents
        case recommendedPodcasts
        case spiritualWellness
        case physicalWellness
        case socialWellness

        var title: String {
            switch self {
            case .events:
                return "Social Pillar Events"
            case .benefits:
                return "Social Pillar Benefits"
            case .content:
                return "Social Pillar Content"
            case .recommendedEvents:
                return "Recommended Events"
            case .recommendedPodcasts:
                return "Recommended Podcasts"
            case .spiritualWellness:
                return "Spiritual Wellness"
            case .physicalWellness:
                return "Physical Wellness"
            case .socialWellness:
                return "Social Wellness"
            }
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .mediumGray
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.scrollDirection = .horizontal
            collectionView.collectionViewLayout = flowLayout
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.showsVerticalScrollIndicator = false
            collectionView.register(UINib(nibName: String(describing: EventCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: String(describing: EventCollectionViewCell.self))
        }
    }

    weak var delegate: CollectionEventsViewDelegate?
    private var type: EventType?


    func set(type: EventType) {
        self.type = type
        titleLabel.text = type.title
    }
}

extension CollectionEventsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let type = type else { return }
        delegate?.goToEvent(for: type, indexPath: indexPath)
    }
}

extension CollectionEventsView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let type = type, let delegate = delegate else { return 0 }
        return delegate.numberOfItems(for: type)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let type = type, let delegate = delegate else { return UICollectionViewCell() }
        return delegate.cellForItem(for: type, collectionView: collectionView, indexPath: indexPath)
    }
}

extension CollectionEventsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 343, height: 264.5)
    }
}
