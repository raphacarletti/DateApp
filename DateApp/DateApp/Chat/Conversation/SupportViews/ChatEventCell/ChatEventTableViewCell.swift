import UIKit
import StreamChat

protocol ChatEventTableViewCellDelegate: AnyObject {
    func didTapEventCell(event: Event)
}

class ChatEventTableViewCell: UITableViewCell {
    @IBOutlet weak var roundedView: UIView! {
        didSet {
            roundedView.layer.cornerRadius = 20
            roundedView.clipsToBounds = true
        }
    }
    @IBOutlet weak var eventSummaryView: EventSummaryView!
    @IBOutlet weak var roundedViewTrailingEqualConstraint: NSLayoutConstraint!
    @IBOutlet weak var roundedViewTrailingGreaterThanConstraint: NSLayoutConstraint!
    @IBOutlet weak var roundedViewLeadingEqualConstraint: NSLayoutConstraint!
    @IBOutlet weak var roundedViewLeadingGreaterThanConstraint: NSLayoutConstraint!

    var message: ChatMessage?
    var event: Event?
    weak var delegate: ChatEventTableViewCellDelegate? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(message: ChatMessage) {
        contentView.backgroundColor = .offWhite
        self.message = message
        let isSentByCurrentUser = message.isSentByCurrentUser
        roundedView.backgroundColor = .clear
        setConstraints(isSentByCurrentUser: isSentByCurrentUser)
        guard let eventData = message.attachments.first as? ChatMessageRawAttachment, let eventAttachment = try? JSONDecoder().decode(EventAttachment.self, from: eventData.data ?? Data()) else {
            return
        }
        self.event = eventAttachment.event
        eventSummaryView.set(event: eventAttachment.event, isExpanded: false, isCell: false)
        eventSummaryView.isUserInteractionEnabled = true
        eventSummaryView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapEventCell)))
    }

    func setConstraints(isSentByCurrentUser: Bool) {
        if isSentByCurrentUser {
            roundedViewTrailingEqualConstraint.priority = .defaultHigh
            roundedViewTrailingGreaterThanConstraint.priority = .defaultLow
            roundedViewLeadingEqualConstraint.priority = .defaultLow
            roundedViewLeadingGreaterThanConstraint.priority = .defaultHigh
        } else {
            roundedViewTrailingEqualConstraint.priority = .defaultLow
            roundedViewTrailingGreaterThanConstraint.priority = .defaultHigh
            roundedViewLeadingEqualConstraint.priority = .defaultHigh
            roundedViewLeadingGreaterThanConstraint.priority = .defaultLow
        }
    }

    @objc
    func didTapEventCell() {
        guard let event = self.event else { return }
        delegate?.didTapEventCell(event: event)
    }
    
}
