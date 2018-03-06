//
//  AMPresentationController.swift
//  AppleMusicTransition
//
//  Created by cookie on 06/03/2018.
//  Copyright © 2018 cookie. All rights reserved.
//

import UIKit

//https://www.raywenderlich.com/139277/uipresentationcontroller-tutorial-getting-started

//for present
class AMPresentationController: UIPresentationController {
    
    var duration: TimeInterval = 2
    var blackLayer: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.0
        return view
    }()
    
//    override var frameOfPresentedViewInContainerView: CGRect {
//        guard let container = containerView else { return .zero }
//        return CGRect(x: 0, y: container.bounds.height - 120, width: container.bounds.width, height: 120)
//    }
    
    override func presentationTransitionWillBegin() {
        guard let container = containerView else { return }
        guard let toView = presentedView else { return }
        guard let fromView = presentingViewController.view else { return }
        guard let coordinator = presentedViewController.transitionCoordinator else { return }
        guard let toVC = presentedViewController as? MusicDetailViewController else { return }
        
        toVC.frameBeforePresent()
        //toView.frame = CGRect(x: 0, y: container.bounds.height - 120, width: container.bounds.width, height: 0)
        blackLayer.frame = fromView.frame
        container.insertSubview(blackLayer, aboveSubview: fromView)
        coordinator.animate(alongsideTransition: { (context) in
            self.blackLayer.alpha = 0.5
            fromView.layer.cornerRadius = 10
            fromView.clipsToBounds = true
            fromView.transform = fromView.transform.scaledBy(x: 0.95, y: 0.95)
            fromView.transform = fromView.transform.translatedBy(x: 0, y: 20 - container.bounds.height * 0.05 / 2)
            
            toView.layer.cornerRadius = 10
            toView.clipsToBounds = true
            toView.frame = container.frame.offsetBy(dx: 0, dy: 50)
            toVC.frameAfterPresent()
        }) { (_) in
            
        }
    }
    
    override func presentationTransitionDidEnd(_ completed: Bool) {
    }
    
    override func containerViewWillLayoutSubviews() {
//        guard let presented = presentedView else { return }
//        guard let container = containerView else { return }
//        presented.frame = container.frame.offsetBy(dx: 0, dy: 50)
    }
}

// for dismiss
extension AMPresentationController {
    override func dismissalTransitionWillBegin() {
        guard let toView = presentedView else { return }
        guard let fromView = presentingViewController.view else { return }
        guard let container = containerView else { return }
        guard let coordinator = presentedViewController.transitionCoordinator else { return }
        guard let toVC = presentedViewController as? MusicDetailViewController else { return }
        coordinator.animate(alongsideTransition: { (context) in
            self.blackLayer.alpha = 0.0
            fromView.layer.cornerRadius = 0
            fromView.transform = CGAffineTransform.identity
            fromView.frame = container.frame
            toVC.frameBeforePresent()
            toView.layer.cornerRadius = 0
        }) { (_) in
            self.blackLayer.removeFromSuperview()
        }
    }
}
