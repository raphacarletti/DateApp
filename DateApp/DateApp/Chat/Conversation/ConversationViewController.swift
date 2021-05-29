import UIKit
import StreamChat

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
            messageTextView.returnKeyType = .send
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
    @IBOutlet weak var conversationTableView: UITableView! {
        didSet {
            conversationTableView.delegate = self
            conversationTableView.dataSource = self
            conversationTableView.transform = CGAffineTransform(rotationAngle: .pi)
            conversationTableView.register(UINib(nibName: String(describing: ChatTextTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: ChatTextTableViewCell.self))
            conversationTableView.separatorStyle = .none
            conversationTableView.backgroundColor = .offWhite
        }
    }
    @IBOutlet weak var moreButtonsStackView: UIStackView!
    @IBOutlet weak var shareButton: UIStackView!
    @IBOutlet weak var spinButton: UIStackView!
    @IBOutlet weak var moreButtonLeadingToLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var moreButtonTrailingToLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageViewToBottomConstraint: NSLayoutConstraint!

    private var isMoreOptionsActive: Bool = false

    private var viewModel: ConversationViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        setMessageViewLayout()
        setHeaderView()
        backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBackButton)))
        LoadingUtils.startLoading(in: view)
        viewModel?.getMessages(completion: { [weak self] error in
            guard let self = self else { return }
            if error != nil {
                self.showErrorToLoadMessagesAlert()
            } else {
                self.conversationTableView.reloadData()
            }
            LoadingUtils.stopLoading()
        })
        
    }

    func setHeaderView() {
        nameLabel.text = viewModel?.getChannelName()
        photoImageView.kf.setImage(with: viewModel?.getPhotoImageUrl())
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func set(channelId: ChannelId) {
        let controller = ConversationController(channelId: channelId)
        controller.delegate = self
        viewModel = ConversationViewModel(controller: controller)
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

    func showErrorToLoadMessagesAlert() {
        let alert = UIAlertController(title: "Failed to Load Messages", message: "Try again later...", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default) { [weak self] action in
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}

extension ConversationViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            viewModel?.sendMessage(text: textView.text)
            return false
        }

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

extension ConversationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = ChatSectionHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        view.backgroundColor = .offWhite
        view.set(text: viewModel?.getHeaderText(for: section) ?? "")
        view.transform = CGAffineTransform(rotationAngle: .pi)
        return view
    }
}

extension ConversationViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.numberOfSections() ?? 0
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows(in: section) ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel?.cellForRow(tableView: tableView, indexPath: indexPath) ?? UITableViewCell()
    }
}

extension ConversationViewController: ConversationControllerDelegate {
    func didUpdateRow(at indexPath: IndexPath) {
        conversationTableView.beginUpdates()
        conversationTableView.reloadRows(at: [indexPath], with: .automatic)
        conversationTableView.endUpdates()
    }

    func didInsertRow(at indexPath: IndexPath) {
        conversationTableView.beginUpdates()
        conversationTableView.insertRows(at: [indexPath], with: .automatic)
        conversationTableView.scrollToRow(at: indexPath, at: .bottom, animated: false)
        conversationTableView.endUpdates()
    }
}
