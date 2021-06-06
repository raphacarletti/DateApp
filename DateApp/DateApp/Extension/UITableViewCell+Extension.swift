import UIKit

extension UITableViewCell {
    var cellActionButtonLabel: [UILabel]? {
        superview?.subviews
            .filter { String(describing: $0).range(of: "UISwipeActionPullView") != nil }
            .flatMap { $0.subviews }
            .filter { String(describing: $0).range(of: "UISwipeActionStandardButton") != nil }
            .flatMap { $0.subviews }
            .compactMap { $0 as? UILabel }
    }

    func setActions(color: UIColor) {
        cellActionButtonLabel?.forEach { label in
            label.textColor = color
        }
    }
}
