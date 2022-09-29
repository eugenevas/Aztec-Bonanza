import UIKit

extension UIResponder {
    func stack(_ views: UIView..., spacing: CGFloat = 0, axis: NSLayoutConstraint.Axis = .horizontal, alignment: UIStackView.Alignment = .fill, distribution: UIStackView.Distribution = .fill) -> UIStackView {
        let stack =  UIStackView(arrangedSubviews: views)
        stack.spacing = spacing
        stack.axis = axis
        stack.alignment = alignment
        stack.distribution = distribution
        return stack
    }
}
