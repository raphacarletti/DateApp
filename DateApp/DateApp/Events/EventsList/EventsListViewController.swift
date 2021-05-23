import UIKit
import BetterSegmentedControl

final class EventListViewController: UIViewController {
    @IBOutlet weak var eventsSegmentControl: BetterSegmentedControl! {
        didSet {
            eventsSegmentControl.backgroundColor = .clear
            eventsSegmentControl.segments = LabelSegment.segments(withTitles: ["EVENTS", "BENEFITS"], normalBackgroundColor: .clear,normalFont: .systemFont(ofSize: 16, weight: .semibold), normalTextColor: .gray, selectedBackgroundColor: .clear, selectedFont: .systemFont(ofSize: 16, weight: .semibold), selectedTextColor: .primaryColor, kerning: true)
        }
    }
    @IBOutlet weak var separatorViewSegmentedControl: UIView! {
        didSet {
            separatorViewSegmentedControl.backgroundColor = .primaryColor
        }
    }
    @IBOutlet weak var eventSearchBar: UISearchBar! {
        didSet {
            eventSearchBar.placeholder = "Search events"
        }
    }
    @IBOutlet weak var filterIconButton: UIButton! {
        didSet {
            filterIconButton.setTitle("", for: .normal)
            filterIconButton.setImage(.filterIcon, for: .normal)
            filterIconButton.tintColor = .primaryColor
        }
    }
    @IBOutlet weak var allAttendingSegmentedControl: BetterSegmentedControl! {
        didSet {
            allAttendingSegmentedControl.cornerRadius = 15
            allAttendingSegmentedControl.backgroundColor = .offWhite
            allAttendingSegmentedControl.segments = LabelSegment.segments(withTitles: ["ALL", "ATTENDING"], normalBackgroundColor: .clear, normalFont: .systemFont(ofSize: 13, weight: .semibold), normalTextColor: .primaryColor, selectedBackgroundColor: .primaryColor, selectedFont: .systemFont(ofSize: 13, weight: .semibold), selectedTextColor: .white)
        }
    }
    @IBOutlet weak var eventsTableView: UITableView! {
        didSet {
            eventsTableView.delegate = self
            eventsTableView.dataSource = self
            eventsTableView.separatorStyle = .none
            eventsTableView.register(UINib(nibName: String(describing: EventTableViewCell.self), bundle: nil), forCellReuseIdentifier: String(describing: EventTableViewCell.self))
        }
    }

    private let viewModel = EventsListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        viewModel.getEvents()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EventDetailViewController else {
            return
        }

        destination.set(event: viewModel.selectedEvent)
    }
}

extension EventListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectEvent(indexPath: indexPath)
        performSegue(withIdentifier: Segue.eventListToEventDetailScreen, sender: self)
    }
}

extension EventListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.cellForRow(tableView: tableView, indexPath: indexPath)
    }
}
