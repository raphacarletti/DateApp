import UIKit
import BetterSegmentedControl

final class NotificationCenterViewController: UIViewController {
    @IBOutlet weak var quitIconImageView: UIImageView! {
        didSet {
            quitButton.tintColor = .mediumGray
        }
    }
    @IBOutlet weak var quitButton: UIView! {
        didSet {
            quitButton.layer.shadowColor = UIColor.mediumGray.cgColor
            quitButton.layer.shadowOpacity = 0.5
            quitButton.layer.shadowOffset = CGSize(width: 0, height: 2)
            quitButton.layer.shadowRadius = 2
            quitButton.layer.cornerRadius = 25
            quitButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapQuitButton)))
        }
    }
    @IBOutlet weak var segmentControl: BetterSegmentedControl! {
        didSet {
            segmentControl.backgroundColor = .clear
            segmentControl.segments = LabelSegment.segments(withTitles: ["NOTIFICATIONS", "YOUR ACTIVITY"], normalBackgroundColor: .clear,normalFont: .systemFont(ofSize: 14, weight: .semibold), normalTextColor: .gray, selectedBackgroundColor: .clear, selectedFont: .systemFont(ofSize: 14, weight: .semibold), selectedTextColor: .primaryColor, kerning: true)
        }
    }
    @IBOutlet weak var separatorView: UIView! {
        didSet {
            separatorView.backgroundColor = .primaryColor
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.separatorStyle = .none
            tableView.register(UINib(nibName: String(describing: NotificationTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: NotificationTableViewCell.self))
        }
    }

    let viewModel = NotificationCenterViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel.getNotifications()
    }

    @objc
    func didTapQuitButton() {
        dismiss(animated: true, completion: nil)
    }
}

extension NotificationCenterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        view.set(text: viewModel.getName(for: section))
        return view
    }
}

extension NotificationCenterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRow(tableView: tableView, indexPath: indexPath)
    }
}
