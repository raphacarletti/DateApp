import UIKit
import StreamChat

protocol ChatTextTableViewCellDelegate {
    func likeMessage(messageId: MessageId)
    func unlikeMessage(messageId: MessageId)
}

class ChatTextTableViewCell: UITableViewCell {
    @IBOutlet weak var roundedView: UIView! {
        didSet {
            roundedView.layer.cornerRadius = 20
            roundedView.clipsToBounds = true
        }
    }
    @IBOutlet weak var likeMessageButton: UIButton! {
        didSet {
            likeMessageButton.tintColor = .primaryColor
        }
    }
    @IBOutlet weak var checkmarkAndDateMessageStackView: UIStackView!
    @IBOutlet weak var dateMessageLabel: UILabel!
    @IBOutlet weak var checkmarkImageView: UIImageView!
    @IBOutlet weak var textMessageLabel: UILabel!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackViewToLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackViewToTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var roundedViewToTrailingEqualConstraint: NSLayoutConstraint!
    @IBOutlet weak var roundedViewToTrailingGreaterThanConstraint: NSLayoutConstraint!
    @IBOutlet weak var roundedViewToLeadingEqualConstraint: NSLayoutConstraint!
    @IBOutlet weak var roundedViewToLeadingGreaterThanConstraint: NSLayoutConstraint!

    private var message: ChatMessage?
    lazy var delegate: ChatTextTableViewCellDelegate? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func set(message: ChatMessage, isLastMessage: Bool, lastReadAt: Date) {
        contentView.backgroundColor = .offWhite
        self.message = message
        let isSentByCurrentUser = message.isSentByCurrentUser
        textMessageLabel.text = message.text
        textMessageLabel.textColor = isSentByCurrentUser ? .white : .black
        roundedView.backgroundColor = isSentByCurrentUser ? .primaryColor : .lighterGray
        likeMessageButton.isHidden = isSentByCurrentUser
        let image = message.currentUserReactions.isEmpty ? UIImage.heartIcon : UIImage.heartFulfilledIcon 
        likeMessageButton.setImage(image, for: .normal)
        likeMessageButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        checkmarkAndDateMessageStackView.isHidden = !isLastMessage

        if isLastMessage {
            dateMessageLabel.text = message.createdAt.hourAndMinutes
            checkmarkImageView.tintColor = isSentByCurrentUser ? Calendar.current.compare(message.createdAt, to: lastReadAt, toGranularity: .nanosecond) == .orderedAscending ? .primaryColor : .mediumGray : .primaryColor
            stackViewHeightConstraint.constant = 12
        } else {
            stackViewHeightConstraint.constant = 0
        }

        setConstraints(isSentByCurrentUser: isSentByCurrentUser)
    }

    func setConstraints(isSentByCurrentUser: Bool) {
        if isSentByCurrentUser {
            roundedViewToTrailingEqualConstraint.priority = .defaultHigh
            roundedViewToTrailingGreaterThanConstraint.priority = .defaultLow
            roundedViewToLeadingEqualConstraint.priority = .defaultLow
            roundedViewToLeadingGreaterThanConstraint.priority = .defaultHigh
            stackViewToLeadingConstraint.priority = .defaultLow
            stackViewToTrailingConstraint.priority = .required
        } else {
            roundedViewToTrailingEqualConstraint.priority = .defaultLow
            roundedViewToTrailingGreaterThanConstraint.priority = .defaultHigh
            roundedViewToLeadingEqualConstraint.priority = .defaultHigh
            roundedViewToLeadingGreaterThanConstraint.priority = .defaultLow
            stackViewToLeadingConstraint.priority = .required
            stackViewToTrailingConstraint.priority = .defaultLow
        }
    }

    @objc
    func didTapLikeButton() {
        guard let messageId = message?.id else { return }
        if message?.reactionScores["like"] == 1 {
            delegate?.unlikeMessage(messageId: messageId)
        } else {
            delegate?.likeMessage(messageId: messageId)
        }
    }
    
}
