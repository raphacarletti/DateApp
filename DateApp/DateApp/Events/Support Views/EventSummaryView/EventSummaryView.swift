import UIKit

protocol EventSummaryViewDelegate: AnyObject {
    func didTapDetailButton(id: Int)
}

class EventSummaryView: CustomView {
    @IBOutlet weak var roundedView: UIView! {
        didSet {
            roundedView.backgroundColor = .offWhite
            roundedView.layer.shadowColor = UIColor.mediumGray.cgColor
            roundedView.layer.shadowOpacity = 0.5
            roundedView.layer.shadowOffset = CGSize(width: 0, height: 2)
            roundedView.layer.shadowRadius = 2
            roundedView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var eventImage: UIImageView! {
        didSet {
            eventImage.clipsToBounds = true
            eventImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            eventImage.layer.cornerRadius = 20
            eventImage.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var eventTitleLabel: UILabel! {
        didSet {
            eventTitleLabel.font = .systemFont(ofSize: 20)
            eventTitleLabel.textColor = .mediumGray
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
            favoriteButton.addTarget(self, action: #selector(didTapFavoriteButton), for: .touchUpInside)
        }
    }
    @IBOutlet weak var locationLabel: UILabel! {
        didSet {
            locationLabel.font = .systemFont(ofSize: 13)
            locationLabel.textColor = .mediumGray
        }
    }
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.font = .systemFont(ofSize: 16)
            dateLabel.textColor = .mediumGray
        }
    }
    @IBOutlet weak var pinIconImageView: UIImageView! {
        didSet {
            pinIconImageView.image = .pinIcon
            pinIconImageView.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var detailButton: UIButton! {
        didSet {
            detailButton.tintColor = .mediumGray
            detailButton.layer.cornerRadius = 16
            detailButton.clipsToBounds = true
            detailButton.setTitleColor(.mediumGray, for: .normal)
            detailButton.backgroundColor = .white
            detailButton.imageView?.transform = CGAffineTransform(rotationAngle: .pi / 2)
            detailButton.addTarget(self, action: #selector(didTapDetailButton), for: .touchUpInside)
        }
    }
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var detailsTextViewHeight: NSLayoutConstraint!

    weak var delegate: EventSummaryViewDelegate? = nil
    var event: Event?

    func set(event: Event, isExpanded: Bool, isCell: Bool, delegate: EventSummaryViewDelegate? = nil) {
        if !isCell {
            detailButton.isHidden = true
        }
        self.delegate = delegate
        self.event = event
        eventImage.kf.setImage(with: URL(string: event.imgUrl))
        eventTitleLabel.text = event.name
        locationLabel.text = event.venue
        dateLabel.text = event.formattedDate
        detailsTextView.text = event.description
        expandCell(isExpanded: isExpanded)
        reloadFavoriteButton()
    }

    @objc
    func didTapDetailButton() {
        delegate?.didTapDetailButton(id: event?.id ?? 0)
    }

    @objc
    func didTapFavoriteButton() {
        guard let event = event else { return }
        let userDefaults = UserDefaultUtils()
        var events = userDefaults.getSavedEvents()
        if !events.isEmpty {
            if let index = events.firstIndex(where: { $0.id == event.id }) {
                events.remove(at: index)
            } else {
                events.append(event)
            }
            userDefaults.save(events: events)
        } else {
            userDefaults.save(events: [event])
        }
        reloadFavoriteButton()
    }

    func isFavorite(eventId: Int) -> Bool {
        let userDefaults = UserDefaultUtils()
        let events = userDefaults.getSavedEvents()
        return events.contains(where: { $0.id == eventId })
    }

    func reloadFavoriteButton() {
        guard let event = event else { return }
        favoriteButton.setImage(isFavorite(eventId: event.id) ? .bookmarkFillIcon : .bookmarkIcon, for: .normal)
    }

    func expandCell(isExpanded: Bool) {
        let transform: CGAffineTransform
        let textViewHeight: Int
        if isExpanded {
            transform = CGAffineTransform(rotationAngle: 3 * .pi / 2)
            textViewHeight = 100
        } else {
            transform = CGAffineTransform(rotationAngle: .pi / 2)
            textViewHeight = 0
        }

        detailButton.imageView?.transform = transform
        detailsTextViewHeight.constant = CGFloat(textViewHeight)
    }
}
