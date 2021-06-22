import UIKit

final class ForYouViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.textColor = .mediumGray
        }
    }
    @IBOutlet weak var alertButton: UIView! {
        didSet {
            alertButton.applyDefaultShadow(with: 25)
        }
    }
    @IBOutlet weak var alertIcon: UIImageView! {
        didSet {
            alertIcon.tintColor = .mediumGray
        }
    }
    @IBOutlet weak var recommendedEvents: CollectionEventsView! {
        didSet {
            recommendedEvents.delegate = self
            recommendedEvents.set(type: .recommendedEvents)
        }
    }
    @IBOutlet weak var recommendedPodcasts: CollectionEventsView! {
        didSet {
            recommendedPodcasts.delegate = self
            recommendedPodcasts.set(type: .recommendedPodcasts)
        }
    }
    @IBOutlet weak var spiritualWellness: CollectionEventsView! {
        didSet {
            spiritualWellness.delegate = self
            spiritualWellness.set(type: .spiritualWellness)
        }
    }
    @IBOutlet weak var physicalWellness: CollectionEventsView! {
        didSet {
            physicalWellness.delegate = self
            physicalWellness.set(type: .physicalWellness)
        }
    }
    @IBOutlet weak var socialWellness: CollectionEventsView! {
        didSet {
            socialWellness.delegate = self
            socialWellness.set(type: .socialWellness)
        }
    }
    @IBOutlet weak var spotlightEventTitleLabel: UILabel! {
        didSet {
            spotlightEventTitleLabel.textColor = .mediumGray
        }
    }
    @IBOutlet weak var spotlightEvent: EventSummaryView! {
        didSet {
            spotlightEvent.isUserInteractionEnabled = true
            spotlightEvent.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapSpotlightEvent)))
        }
    }

    private let viewModel = ForYouViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel.setSpotlightEvent = { [weak self] event in
            guard let self = self else { return }
            self.spotlightEvent.set(event: event, isExpanded: false, isCell: false)
        }
        viewModel.getEvents()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EventDetailViewController else { return }
        destination.set(event: viewModel.selectedEvent)
    }

    func goToEventDetail(event: Event) {
        viewModel.setSelectedEvent(event)
        performSegue(withIdentifier: Segue.forYouToEventDetailSegue, sender: nil)
    }

    @objc
    func didTapSpotlightEvent() {
        guard let event = spotlightEvent.event else { return }
        goToEventDetail(event: event)
    }
}

extension ForYouViewController: CollectionEventsViewDelegate {
    func goToEvent(for type: CollectionEventsView.EventType, indexPath: IndexPath) {
        guard let event = viewModel.getEvent(for: type, indexPath: indexPath) else { return }
        goToEventDetail(event: event)
    }

    func numberOfItems(for type: CollectionEventsView.EventType) -> Int {
        return viewModel.numberOfItems(for: type)
    }

    func cellForItem(for type: CollectionEventsView.EventType, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.cellForItem(for: type, collectionView: collectionView, indexPath: indexPath)
    }
}
