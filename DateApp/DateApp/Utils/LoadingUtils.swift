import UIKit
import JGProgressHUD

final class LoadingUtils {
    static let loadingView: JGProgressHUD = {
        let hud = JGProgressHUD()
        hud.textLabel.text = "Loading..."
        return hud
    }()

    static func startLoading(in view: UIView) {
        loadingView.show(in: view)
    }

    static func stopLoading() {
        loadingView.dismiss()
    }
}
