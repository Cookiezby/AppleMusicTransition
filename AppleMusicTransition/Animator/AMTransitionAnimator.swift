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
    var isPresenting: Bool = false
    var snapView = UIView()
    
    init(duration: TimeInterval) {
        self.duration = duration
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
        let container = transitionContext.containerView
        
        if isPresenting {
            toView.frame = CGRect(x: 0, y: container.bounds.height - 120, width: container.bounds.width, height: 70)
            container.addSubview(toView)
            
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
//                fromView.layer.cornerRadius = 10
//                fromView.clipsToBounds = true
//                fromView.transform = fromView.transform.scaledBy(x: 0.95, y: 0.95)
//                fromView.transform = fromView.transform.translatedBy(x: 0, y: 20 - container.bounds.height * 0.05 / 2 )
//                toView.frame = CGRect(x: 0, y: 35, width: container.bounds.width, height: container.bounds.height - 35)
//                toView.layer.cornerRadius = 10
//                toView.clipsToBounds = true
//                toVC.frameAfterPresent()
//                fromVC.tabBar.frame = fromVC.tabBar.frame.offsetBy(dx: 0, dy: fromVC.tabBar.bounds.height)
                toView.frame = container.frame
            }) { (_) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        } else {
            container.insertSubview(toView, belowSubview: fromView)
            UIView.animate(withDuration: duration, delay: 0, options: .curveEaseIn, animations: {
                toView.frame = container.frame
                fromView.frame = CGRect(x: 0, y: container.bounds.height - 120, width: container.bounds.width, height: 120)
            }, completion: { (_) in
                toView.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        }
        
    }
}
