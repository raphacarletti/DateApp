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
    @IBOutlet weak var textMessageLabel: UILabel!
    @IBOutlet weak var roundedViewToTrailingEqualConstraint: NSLayoutConstraint!
    @IBOutlet weak var roundedViewToTrailingGreaterThanConstraint: NSLayoutConstraint!
    @IBOutlet weak var roundedViewToLeadingEqualConstraint: NSLayoutConstraint!
    @IBOutlet weak var roundedViewToLeadingGreaterThenConstraint: NSLayoutConstraint!

    private var message: ChatMessage?
    lazy var delegate: ChatTextTableViewCellDelegate? = nil

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
        textMessageLabel.text = message.text
        textMessageLabel.textColor = isSentByCurrentUser ? .white : .black
        roundedView.backgroundColor = isSentByCurrentUser ? .primaryColor : .lighterGray
        likeMessageButton.isHidden = isSentByCurrentUser
        let image = message.reactionScores["like"] == 1 ? UIImage.heartFulfilledIcon : UIImage.heartIcon
        likeMessageButton.setImage(image, for: .normal)
        likeMessageButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchUpInside)
        setConstraints(isSentByCurrentUser: isSentByCurrentUser)
    }

    func setConstraints(isSentByCurrentUser: Bool) {
        if isSentByCurrentUser {
            roundedViewToTrailingEqualConstraint.priority = .defaultHigh
            roundedViewToTrailingGreaterThanConstraint.priority = .defaultLow
            roundedViewToLeadingEqualConstraint.priority = .defaultLow
            roundedViewToLeadingGreaterThenConstraint.priority = .defaultHigh
        } else {
            roundedViewToTrailingEqualConstraint.priority = .defaultLow
            roundedViewToTrailingGreaterThanConstraint.priority = .defaultHigh
            roundedViewToLeadingEqualConstraint.priority = .defaultHigh
            roundedViewToLeadingGreaterThenConstraint.priority = .defaultLow
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
