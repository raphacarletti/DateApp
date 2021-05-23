import UIKit

final class ShapeLayerUtils {
    static func eventDetailCurvePath(in view: UIView) {
        let shape = CAShapeLayer()
        shape.fillColor = UIColor.white.cgColor
        shape.lineCap = .round
        let bezierPath = UIBezierPath(rect: view.frame)
        bezierPath.addArc(withCenter: CGPoint(x: view.center.x, y: 0), radius: 350, startAngle: 0, endAngle: 180, clockwise: true)
        bezierPath.close()
        shape.path = bezierPath.reversing().cgPath
        shape.frame = view.frame
        shape.fillRule = .evenOdd
        view.layer.insertSublayer(shape, at: 1)
        let shapeLine = CAShapeLayer()
        let bezierPathLine = UIBezierPath(arcCenter: CGPoint(x: view.center.x, y: 0), radius: 350, startAngle: 0, endAngle: 180, clockwise: true)
        shapeLine.lineCap = .round
        shapeLine.fillColor = UIColor.clear.cgColor
        shapeLine.path = bezierPathLine.cgPath
        shapeLine.borderWidth = 15
        shapeLine.strokeColor = UIColor.white.cgColor
        shapeLine.strokeStart = 0
        shapeLine.strokeEnd = 30
        shapeLine.shadowColor = UIColor.black.cgColor
        shapeLine.shadowRadius = 8
        shapeLine.shadowOpacity = 1
        shapeLine.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.insertSublayer(shapeLine, at: 2)
    }
}
