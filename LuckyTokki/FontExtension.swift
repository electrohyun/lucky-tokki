import UIKit

extension UIViewController {
    func applyCustomFont(to labels: [UILabel], fontName: String, size: CGFloat) {
        labels.forEach {
            $0.font = UIFont(name: fontName, size: size)
        }
    }
}
