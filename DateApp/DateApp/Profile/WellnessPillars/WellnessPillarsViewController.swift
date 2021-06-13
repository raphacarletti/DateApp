import UIKit

final class WellnessPillarsViewController: UIViewController {
    @IBOutlet weak var backButton: UIView! {
        didSet {
            backButton.applyDefaultShadow(with: 25)
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
            let text = NSAttributedString(string: "WELLNESS PILLARS", attributes: [.foregroundColor: UIColor.primaryColor, .kern: 2, .font: UIFont.systemFont(ofSize: 18)])
            titleLabel.attributedText = text
            titleLabel.textColor = .primaryColor
        }
    }
    @IBOutlet weak var infoButton: UIImageView! {
        didSet {
            infoButton.tintColor = .primaryColor
        }
    }
    @IBOutlet weak var separatorView: UIView! {
        didSet {
            separatorView.backgroundColor = .primaryColor
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.separatorStyle = .none
            tableView.register(UINib(nibName: String(describing: WellnessPillarTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: WellnessPillarTableViewCell.self))
            tableView.delegate = self
            tableView.dataSource = self
        }
    }

    private let viewModel = WellnessPillarsViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @objc
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

extension WellnessPillarsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Segue.wellnessPillarsToDetailSegue, sender: nil)
    }
}

extension WellnessPillarsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRow(tableView: tableView, indexPath: indexPath)
    }
}
