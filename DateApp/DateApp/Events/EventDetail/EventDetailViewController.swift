import UIKit

class EventDetailViewController: UIViewController {
    @IBOutlet weak var eventImageView: UIImageView! {
        didSet {
            eventImageView.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var eventNameLabel: UILabel! {
        didSet {
            eventNameLabel.textColor = .mediumGray
            eventNameLabel.font = .systemFont(ofSize: 20)
        }
    }
    @IBOutlet weak var clockIconImageView: UIImageView! {
        didSet {
            clockIconImageView.contentMode = .scaleAspectFit
            clockIconImageView.image = .clockIcon
        }
    }
    @IBOutlet weak var startTimeLabel: UILabel! {
        didSet {
            startTimeLabel.textColor = .mediumGray
            startTimeLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        }
    }
    @IBOutlet weak var pinIconImageView: UIImageView! {
        didSet {
            pinIconImageView.contentMode = .scaleAspectFit
            pinIconImageView.image = .pinIcon
        }
    }
    @IBOutlet weak var locationLabel: UILabel! {
        didSet {
            locationLabel.textColor = .mediumGray
            locationLabel.font = .systemFont(ofSize: 14)
        }
    }
    @IBOutlet weak var shareButton: UIButton! {
        didSet {
            shareButton.setTitle("", for: .normal)
            shareButton.setImage(.shareIcon, for: .normal)
            shareButton.tintColor = .mediumGray
        }
    }
    @IBOutlet weak var favoriteButton: UIButton! {
        didSet {
            favoriteButton.setTitle("", for: .normal)
            favoriteButton.setImage(.bookmarkIcon, for: .normal)
            favoriteButton.tintColor = .mediumGray
        }
    }
    @IBOutlet weak var descriptionTextView: UITextView! {
        didSet {
            descriptionTextView.isEditable = false
            descriptionTextView.textColor = .mediumGray
            descriptionTextView.font = .systemFont(ofSize: 16, weight: .light)
        }
    }
    @IBOutlet weak var backButton: UIView! {
        didSet {
            backButton.layer.cornerRadius = 25
            backButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var separatorView: UIView! {
        didSet {
            separatorView.backgroundColor = .primaryColor
        }
    }
    @IBOutlet weak var directionButton: UIStackView! {
        didSet {
            directionButton.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var callVenueButton: UIStackView! {
        didSet {
            callVenueButton.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var visitWebsiteButton: UIStackView! {
        didSet {
            visitWebsiteButton.isUserInteractionEnabled = true
        }
    }
    @IBOutlet weak var rsvpButton: UIButton!
    @IBOutlet weak var sendInviteButton: UIButton!

    var event: Event?

    override func viewDidLoad() {
        super.viewDidLoad()

        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(back)))
        directionButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapDirectionsButton)))
        callVenueButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapCallVenueButton)))
        visitWebsiteButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapVisitWebsiteButton)))
        setCustomization(button: rsvpButton)
        setCustomization(button: sendInviteButton)

        setEventInfo()
    }

    func setEventInfo() {
        guard let event = event else {
            return
        }

        eventImageView.image = event.image
        eventNameLabel.text = event.name
        startTimeLabel.text = event.formattedDate
        locationLabel.text = event.venue
        descriptionTextView.text = event.description
    }

    func setCustomization(button: UIButton) {
        button.layer.cornerRadius = 15
        button.backgroundColor = .offWhite
        button.setTitleColor(.mediumGray, for: .normal)

        button.layer.shadowColor = UIColor.mediumGray.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowRadius = 1
        button.layer.cornerRadius = 15
    }

    @objc
    func back() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    func didTapDirectionsButton() {
        ExternalLinksUtils.openGoogleMaps(with: event?.venue ?? "")
    }

    @objc
    func didTapCallVenueButton() {
        print("call")
    }

    @objc
    func didTapVisitWebsiteButton() {
        print("visit")
    }
}
