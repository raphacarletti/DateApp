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
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
