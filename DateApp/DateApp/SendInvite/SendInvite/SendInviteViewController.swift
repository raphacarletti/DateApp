import UIKit

final class SendInviteViewController: UIViewController {
    @IBOutlet weak var backButton: UIView! {
        didSet {
            backButton.layer.cornerRadius = 25
            backButton.clipsToBounds = true
            backButton.isUserInteractionEnabled = true
            backButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapBackButton)))
        }
    }
    @IBOutlet weak var backIcon: UIImageView! {
        didSet {
            backIcon.tintColor = .mediumGray
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            let text = NSAttributedString(string: "SEND INVITE", attributes: [.foregroundColor: UIColor.primaryColor, .kern: 2, .font: UIFont.systemFont(ofSize: 18)])
            titleLabel.attributedText = text
            titleLabel.textColor = .primaryColor
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.backgroundColor = .offWhite
            tableView.separatorStyle = .none
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: String(describing: SendInviteProfileTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: SendInviteProfileTableViewCell.self))
        }
    }
    @IBOutlet weak var sendInviteButton: UIButton! {
        didSet {
            sendInviteButton.setTitle("Send Invite", for: .normal)
            sendInviteButton.setTitleColor(.mediumGray, for: .normal)
            sendInviteButton.backgroundColor = .offWhite
            sendInviteButton.applyDefaultShadow(with: 12)
            sendInviteButton.addTarget(self, action: #selector(didTapSendInviteButton), for: .touchUpInside)
        }
    }
    @IBOutlet weak var sendInviteButtonViewHeightConstraint: NSLayoutConstraint!

    private let viewModel = SendInviteViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .offWhite
        sendInviteButtonViewHeightConstraint.constant = 0
        viewModel.getProfiles()
        viewModel.reloadRow = { [weak self] indexPath in
            guard let self = self else { return }
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        viewModel.shouldShowSendInviteButton = { [weak self] shouldShow in
            guard let self = self else { return }
            self.changeSendInviteViewState(show: shouldShow)
        }
    }

    @objc
    func didTapBackButton() {

    }

    @objc
    func didTapSendInviteButton() {
        sendInviteButton.setTitle("Sent!", for: .normal)
        sendInviteButton.setTitleColor(.primaryColor, for: .normal)
        sendInviteButton.isUserInteractionEnabled = false
    }

    func changeSendInviteViewState(show: Bool) {
        if show {
            sendInviteButtonViewHeightConstraint.constant = 100
        } else {
            sendInviteButtonViewHeightConstraint.constant = 0
        }
        UIView.animate(withDuration: 0.2) {
            self.view.layoutIfNeeded()
        }
    }
}

extension SendInviteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100))
        view.set(text: viewModel.getHeaderText(section: section))
        view.setBackgroundColor(color: .offWhite)
        return view
    }
}
extension SendInviteViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSection()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRow(tableView: tableView, indexPath: indexPath)
    }
}
