import UIKit
import BetterSegmentedControl

final class MySavedViewController: UIViewController {
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
            let text = NSAttributedString(string: "SAVED", attributes: [.foregroundColor: UIColor.primaryColor, .kern: 2, .font: UIFont.systemFont(ofSize: 18)])
            titleLabel.attributedText = text
        }
    }
    @IBOutlet weak var segmentControl: BetterSegmentedControl! {
        didSet {
            segmentControl.backgroundColor = .clear
            segmentControl.segments = LabelSegment.segments(withTitles: ["EVENTS", "BENEFITS", "CONTENTS"], normalBackgroundColor: .clear,normalFont: .systemFont(ofSize: 16, weight: .semibold), normalTextColor: .gray, selectedBackgroundColor: .clear, selectedFont: .systemFont(ofSize: 16, weight: .semibold), selectedTextColor: .primaryColor, kerning: true)
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
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(UINib(nibName: String(describing: EventTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: EventTableViewCell.self))
        }
    }

    private let viewModel = MySavedViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getEvents()
        viewModel.reloadRow = { [weak self] row in
            guard let self = self else { return }
            self.tableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
        }
    }

    @objc
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EventDetailViewController else {
            return
        }

        destination.set(event: viewModel.selectedEvent)
    }
}

extension MySavedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectEvent(indexPath: indexPath)
        performSegue(withIdentifier: Segue.eventListToEventDetailScreen, sender: self)
    }
}

extension MySavedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRow(tableView: tableView, indexPath: indexPath)
    }
}
