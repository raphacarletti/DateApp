import UIKit

class SectionHeaderView: CustomView {
    @IBOutlet weak var sectionTitleLabel: UILabel! {
        didSet {
            sectionTitleLabel.textColor = .mediumGray
            sectionTitleLabel.font = .systemFont(ofSize: 18, weight: .light)
        }
    }

    func set(text: String) {
        sectionTitleLabel.text = text
    }

    func setBackgroundColor(color: UIColor) {
        backgroundColor = color
        sectionTitleLabel.backgroundColor = color
    }
}
