import UIKit

final class ConversationViewController: UIViewController {
    @IBOutlet weak var headerView: UIView! {
        didSet {
            headerView.backgroundColor = .offWhite
        }
    }
    @IBOutlet weak var backButton: UIView! {
        didSet {
            backButton.layer.cornerRadius = 25
            backButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var conversationOptionsButton: UIView! {
        didSet {
            conversationOptionsButton.layer.cornerRadius = 25
            conversationOptionsButton.clipsToBounds = true
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.textColor = .mediumGray
            nameLabel.font = .systemFont(ofSize: 18, weight: .semibold)
            nameLabel.text = "Jess"
        }
    }
    @IBOutlet weak var roundedView: UIView! {
        didSet {
            roundedView.layer.shadowColor = UIColor.mediumGray.cgColor
            roundedView.layer.shadowOpacity = 0.5
            roundedView.layer.shadowOffset = .zero
            roundedView.layer.shadowRadius = 4
            roundedView.layer.cornerRadius = 30
        }
    }
    @IBOutlet weak var photoImageView: UIImageView! {
        didSet {
            photoImageView.layer.cornerRadius = 25
            photoImageView.image = .cafeteria
            photoImageView.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var messageView: UIView! {
        didSet {
            messageView.backgroundColor = .offWhite
        }
    }
    @IBOutlet weak var messageTextView: UITextView! {
        didSet {
            messageTextView.delegate = self
            messageTextView.text = "Send message..."
            messageTextView.textColor = .lightGray
            messageTextView.layer.cornerRadius = 15
            messageTextView.clipsToBounds = true
        }
    }
    @IBOutlet weak var moreOptionsButton: UIButton! {
        didSet {
            moreOptionsButton.backgroundColor = .primaryColor
            moreOptionsButton.setTitleColor(.white, for: .normal)
            moreOptionsButton.layer.cornerRadius = 15
            moreOptionsButton.clipsToBounds = true
            moreOptionsButton.addTarget(self, action: #selector(didTapMoreOptionsButton), for: .touchUpInside)
        }
    }
    @IBOutlet weak var moreButtonsStackView: UIStackView!
    @IBOutlet weak var shareButton: UIStackView!
    @IBOutlet weak var spinButton: UIStackView!
    @IBOutlet weak var moreButtonLeadingToLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var moreButtonTrailingToLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageViewToBottomConstraint: NSLayoutConstraint!

    private var isMoreOptionsActive: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setMessageViewLayout()
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBackButton)))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @objc
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    @objc
    func didTapMoreOptionsButton() {
        isMoreOptionsActive.toggle()
        setMessageViewLayout()
    }

    @objc
    func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            messageViewToBottomConstraint.constant = keyboardFrame.cgRectValue.height
        }
    }

    @objc
    func keyboardWillHide(_ notification: Notification) {
        messageViewToBottomConstraint.constant = 0
    }

    func setMessageViewLayout() {
        let transform = isMoreOptionsActive ? CGAffineTransform(rotationAngle: .pi/4) : CGAffineTransform(rotationAngle: 0)
        moreOptionsButton.transform = transform
        if isMoreOptionsActive {
            moreButtonLeadingToLeadingConstraint.priority = .defaultLow
            moreButtonTrailingToLeadingConstraint.priority = .defaultHigh
            moreButtonsStackView.isHidden = false
        } else {
            moreButtonLeadingToLeadingConstraint.priority = .defaultHigh
            moreButtonTrailingToLeadingConstraint.priority = .defaultLow
            moreButtonsStackView.isHidden = true
        }
    }
}

extension ConversationViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if textView.text == "Send message..." {
            textView.text = text
            textView.textColor = .black
            return false
        }

        let finalText = NSString(string: textView.text).replacingCharacters(in: range, with: text)
        if finalText == "" {
            textView.text = "Send message..."
            textView.textColor = .lightGray
        } else {
            textView.text = finalText
            textView.textColor = .black
        }

        return false
    }
}
