import UIKit

protocol SearchFilterViewDelegate: AnyObject {
    func showPillarFilterOptions()
}

class SearchFilterView: CustomView {
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.placeholder = "Search events"
        }
    }
    @IBOutlet weak var filterButton: UIButton! {
        didSet {
            filterButton.setTitle("", for: .normal)
            filterButton.setImage(.filterIcon, for: .normal)
            filterButton.tintColor = .primaryColor
            filterButton.addTarget(self, action: #selector(didTapFilterButton), for: .touchUpInside)
        }
    }
    @IBOutlet weak var dateFilterButton: UIButton! {
        didSet {
            dateFilterButton.setTitleColor(.mediumGray, for: .normal)
            dateFilterButton.applyDefaultShadow(with: 16)
            dateFilterButton.backgroundColor = .offWhite
        }
    }
    @IBOutlet weak var nearbyFilterButton: UIButton! {
        didSet {
            nearbyFilterButton.setTitleColor(.mediumGray, for: .normal)
            nearbyFilterButton.tintColor = .mediumGray
            nearbyFilterButton.imageView?.transform = CGAffineTransform(rotationAngle: 3 * .pi / 2)
            nearbyFilterButton.applyDefaultShadow(with: 16)
            nearbyFilterButton.backgroundColor = .offWhite
        }
    }
    @IBOutlet weak var pillarFilterButton: UIButton! {
        didSet {
            pillarFilterButton.setTitleColor(.mediumGray, for: .normal)
            pillarFilterButton.tintColor = .mediumGray
            pillarFilterButton.imageView?.transform = CGAffineTransform(rotationAngle: 3 * .pi / 2)
            pillarFilterButton.applyDefaultShadow(with: 16)
            pillarFilterButton.backgroundColor = .offWhite
            pillarFilterButton.addTarget(self, action: #selector(didTapPillarFilterButton), for: .touchUpInside)
        }
    }
    @IBOutlet weak var closeButton: UIButton! {
        didSet {
            closeButton.tintColor = .primaryColor
            closeButton.addTarget(self, action: #selector(didTapCloseButton), for: .touchUpInside)
        }
    }
    @IBOutlet weak var filterOptionViewLeadingToTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var filterOptionViewLeadingToLeadingConstraint: NSLayoutConstraint!
    weak var delegate: SearchFilterViewDelegate?
    private var isShowingFilterOptions = false

    @objc
    func didTapFilterButton() {
        changeFilterOptionsState()
    }

    @objc
    func didTapCloseButton() {
        changeFilterOptionsState()
    }

    @objc
    func didTapPillarFilterButton() {
        delegate?.showPillarFilterOptions()
    }

    func changeFilterOptionsState() {
        isShowingFilterOptions.toggle()
        filterOptionViewLeadingToLeadingConstraint.priority = isShowingFilterOptions ? .defaultHigh : .defaultLow
        filterOptionViewLeadingToTrailingConstraint.priority = isShowingFilterOptions ? .defaultLow : .defaultHigh
    }
}
