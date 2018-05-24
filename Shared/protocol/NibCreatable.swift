import UIKit

protocol NibCreatable: class {

    var view: UIView! { get set }
}

extension NibCreatable {

    func addNibViewAsSubView(to superView: UIView) {
        view = superView.createViewFromNib()
        view.frame = superView.bounds
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        superView.addSubview(view)
    }

}
