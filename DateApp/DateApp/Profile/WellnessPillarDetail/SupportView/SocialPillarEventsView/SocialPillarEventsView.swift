import UIKit

protocol SocialPillarEventsViewDelegate: AnyObject {
    func numberOfItems(for type: SocialPillarEventsView.EventType) -> Int
    func cellForItem(for type: SocialPillarEventsView.EventType, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell
    func goToEvent(for type: SocialPillarEventsView.EventType, indexPath: IndexPath)
}

class SocialPillarEventsView: CustomView {
    enum EventType: CaseIterable {
        case events
        case benefits
        case content

        var title: String {
            switch self {
            case .events:
                return "Social Pillar Events"
            case .benefits:
                return "Social Pillar Benefits"
            case .content:
                return "Social Pillar Content"
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

    weak var delegate: SocialPillarEventsViewDelegate?
    private var type: EventType?


    func set(type: EventType) {
        self.type = type
        titleLabel.text = type.title
    }
}

extension SocialPillarEventsView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let type = type else { return }
        delegate?.goToEvent(for: type, indexPath: indexPath)
    }
}

extension SocialPillarEventsView: UICollectionViewDataSource {
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

extension SocialPillarEventsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 343, height: 264.5)
    }
}
