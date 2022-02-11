import UIKit

extension UIView {

  private static let kLayerNameGradientBorder = "GradientBorderLayer"

  @discardableResult func addGradientLayer(_ colors: [UIColor]) -> CAGradientLayer {
    if let gradientLayer = gradientLayer { return gradientLayer }

    let gradient = CAGradientLayer()
    gradient.frame = bounds
    gradient.colors = colors.map { $0.cgColor }
    gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
    gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
    layer.insertSublayer(gradient, at: 0)

    return gradient
  }

  func removeGradientLayer() -> CAGradientLayer? {
    gradientLayer?.removeFromSuperlayer()

    return gradientLayer
  }

  func resizeGradientLayer() {
    gradientLayer?.frame = bounds
  }

  fileprivate var gradientLayer: CAGradientLayer? {
    return layer.sublayers?.first as? CAGradientLayer
  }

        func gradientBorder(width: CGFloat,
                            colors: [UIColor],
                            startPoint: CGPoint = CGPoint(x: 0.5, y: 0.0),
                            endPoint: CGPoint = CGPoint(x: 0.5, y: 1.0),
                            andRoundCornersWithRadius cornerRadius: CGFloat = 0) {

            let existingBorder = gradientBorderLayer()
            let border = existingBorder ?? CAGradientLayer()
            border.frame = CGRect(x: bounds.origin.x, y: bounds.origin.y,
                                  width: bounds.size.width + width, height: bounds.size.height + width)
            border.colors = colors.map { return $0.cgColor }
            border.startPoint = startPoint
            border.endPoint = endPoint

            let mask = CAShapeLayer()
            let maskRect = CGRect(x: bounds.origin.x + width/2, y: bounds.origin.y + width/2,
                                  width: bounds.size.width - width, height: bounds.size.height - width)
            mask.path = UIBezierPath(roundedRect: maskRect, cornerRadius: cornerRadius).cgPath
            mask.fillColor = UIColor.clear.cgColor
            mask.strokeColor = UIColor.white.cgColor
            mask.lineWidth = width

            border.mask = mask

            let exists = (existingBorder != nil)
            if !exists {
                layer.addSublayer(border)
            }
        }
        private func gradientBorderLayer() -> CAGradientLayer? {
            let borderLayers = layer.sublayers?.filter { return $0.name == UIView.kLayerNameGradientBorder }
            if borderLayers?.count ?? 0 > 1 {
                fatalError()
            }
            return borderLayers?.first as? CAGradientLayer
        }
}
