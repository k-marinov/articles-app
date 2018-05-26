import UIKit

class ImageCreator {

    class func rightArrowImage(withLenght length: CGFloat, color: UIColor) -> UIImage {
        let renderer: UIGraphicsImageRenderer = UIGraphicsImageRenderer(size: CGSize(width: length, height: length))
        let image: UIImage = renderer.image { context in
            color.set()
            let path: UIBezierPath = UIBezierPath()
            let lineWidth: CGFloat = 2.0
            path.lineWidth = lineWidth
            path.move(to: CGPoint(x: length / 2.0, y: lineWidth))
            path.addLine(to: CGPoint(x: length - lineWidth, y: length / 2.0))
            path.addLine(to: CGPoint(x: length / 2.0, y: length - lineWidth))
            path.stroke()
        }
        return image
    }

}
