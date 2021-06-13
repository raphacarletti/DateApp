import UIKit

final class WellnessPillarDetailViewController: UIViewController {
    @IBOutlet weak var backButton: UIView! {
        didSet {
            backButton.isUserInteractionEnabled = true
            backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBackButton)))
            backButton.applyDefaultShadow(with: 25)
        }
    }
    @IBOutlet weak var backIcon: UIImageView! {
        didSet {
            backIcon.tintColor = .mediumGray
        }
    }
    @IBOutlet weak var wellnessPillarImageView: UIImageView! {
        didSet {
            wellnessPillarImageView.contentMode = .scaleAspectFill
            wellnessPillarImageView.image = .cafeteria
            ShapeLayerUtils.eventDetailCurvePath(in: wellnessPillarImageView)
        }
    }
    @IBOutlet weak var aboutHeaderLabel: UILabel! {
        didSet {
            aboutHeaderLabel.textColor = .mediumGray
        }
    }
    @IBOutlet weak var aboutLabel: UILabel! {
        didSet {
            aboutLabel.textColor = .mediumGray
        }
    }
    @IBOutlet weak var readMoreButton: UIButton! {
        didSet {
            readMoreButton.tintColor = .mediumGray
            readMoreButton.setTitleColor(.mediumGray, for: .normal)
            readMoreButton.applyDefaultShadow(with: 15)
            readMoreButton.backgroundColor = .offWhite
            readMoreButton.addTarget(self, action: #selector(didTapReadMoreButton), for: .touchUpInside)
        }
    }
    @IBOutlet weak var quoteLabel: UILabel! {
        didSet {
            quoteLabel.textColor = .mediumGray
        }
    }
    @IBOutlet weak var quoteAuthorLabel: UILabel! {
        didSet {
            quoteAuthorLabel.textColor = .mediumGray
        }
    }
    @IBOutlet weak var socialPillarEventView: SocialPillarEventsView! {
        didSet {
            socialPillarEventView.delegate = self
            socialPillarEventView.set(type: .events)
        }
    }
    @IBOutlet weak var socialPillarBenefitsView: SocialPillarEventsView! {
        didSet {
            socialPillarBenefitsView.delegate = self
            socialPillarBenefitsView.set(type: .benefits)
        }
    }
    @IBOutlet weak var socialPillarContentView: SocialPillarEventsView! {
        didSet {
            socialPillarContentView.delegate = self
            socialPillarContentView.set(type: .content)
        }
    }

    private let viewModel = WellnessPillarDetailsViewModel()
    private var isReadMoreActivated = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setReadMoreButtonState(isActivated: false)
        viewModel.getEvents()
        viewModel.getBenefits()
        viewModel.getContent()
    }

    @objc
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    func didTapReadMoreButton() {
        isReadMoreActivated.toggle()
        setReadMoreButtonState(isActivated: isReadMoreActivated)
    }

    private func setReadMoreButtonState(isActivated: Bool) {
        let transform = isActivated ? CGAffineTransform(rotationAngle: .pi / 2) : CGAffineTransform(rotationAngle: 3 * .pi / 2)
        let title = isActivated ? "Read Less" : "Read More"
        let numberOfLines = isActivated ? 0 : 5

        readMoreButton.imageView?.transform = transform
        readMoreButton.setTitle(title, for: .normal)
        aboutLabel.numberOfLines = numberOfLines
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EventDetailViewController else { return }
        destination.set(event: viewModel.selectedEvent)
    }
}

extension WellnessPillarDetailViewController: SocialPillarEventsViewDelegate {
    func goToEvent(for type: SocialPillarEventsView.EventType, indexPath: IndexPath) {
        let event = viewModel.getEvent(for: type, indexPath: indexPath)
        viewModel.setSelectedEvent(event)
        performSegue(withIdentifier: Segue.wellnessPillarDetailsToEventDetailsSegue, sender: nil)
    }
    
    func numberOfItems(for type: SocialPillarEventsView.EventType) -> Int {
        return viewModel.numberOfItems(for: type)
    }

    func cellForItem(for type: SocialPillarEventsView.EventType, collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        return viewModel.cellForItem(for: type, collectionView: collectionView, indexPath: indexPath)
    }
}
