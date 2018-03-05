//
//  AMTransitionAnimator.swift
//  AppleMusicTransition
//
//  Created by cookie on 05/03/2018.
//  Copyright © 2018 cookie. All rights reserved.
//

import Foundation
import UIKit


class AMTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var duration: TimeInterval
    var isPresenting: Bool
    
    init(duration: TimeInterval, isPresenting: Bool) {
        self.duration = duration
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
        guard var fromVC = transitionContext.viewController(forKey: .from) else { return }
        guard var toVC = transitionContext.viewController(forKey: .to) else { return }
        if isPresenting {
            toVC = toVC as! MusicDetailViewController
        } else {
            fromVC = fromVC as! MusicDetailViewController
        }
    
        let container = transitionContext.containerView
        let snapView = fromView.snapshotView(afterScreenUpdates: false)
        if isPresenting {
            if let snap = snapView {
                container.addSubview(snap)
            }
            container.addSubview(toView)
        } else {
            container.insertSubview(toView, belowSubview: fromView)
        }
        
        if isPresenting {
            toView.frame = fromView.frame.offsetBy(dx: 0, dy: fromView.bounds.height)
        } else {
            toView.frame = container.frame
        }
        
        UIView.animate(withDuration: duration, animations: {
            if self.isPresenting {
                fromView.isHidden = true
                guard let snap = snapView else { return }
                snap.layer.cornerRadius = 10
                snap.clipsToBounds = true
                snap.transform = snap.transform.scaledBy(x: 0.95, y: 0.95)
                snap.transform = snap.transform.translatedBy(x: 0, y: 20 - container.bounds.height * 0.05 / 2 )
                toView.frame = CGRect(x: 0, y: 35, width: container.bounds.width, height: container.bounds.height - 35)
                toView.layer.cornerRadius = 10
                toView.clipsToBounds = true
            } else {
                fromView.frame = toView.frame.offsetBy(dx: 0, dy: fromView.bounds.height)
            }
        }) { (finish) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
