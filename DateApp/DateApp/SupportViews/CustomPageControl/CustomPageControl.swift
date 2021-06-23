import UIKit

class CustomPageControl: CustomView {
    private(set) var selectedIndex = 0 {
        didSet {
            updateDots()
        }
    }
    @IBOutlet weak var stackView: UIStackView!

    private func updateDots() {
        for (index, subview) in stackView.arrangedSubviews.enumerated() {
            guard let imageView = subview as? UIImageView else { return }
            imageView.image = index == selectedIndex ? .selectedPageControl : .notSelectedPageControl
        }
    }

    func setSelected(index: Int) {
        selectedIndex = index
    }

}
