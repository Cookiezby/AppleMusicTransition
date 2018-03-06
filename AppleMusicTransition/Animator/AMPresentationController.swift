//
//  AMPresentationController.swift
//  AppleMusicTransition
//
//  Created by cookie on 06/03/2018.
//  Copyright © 2018 cookie. All rights reserved.
//

import UIKit
//for present
class AMPresentationController: UIPresentationController {
    
    var duration: TimeInterval = 0.6
    var isPresenting = false
    var isInteractive = false
    
    var fakeTabbar: UIView?
    
    var blackLayer: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.0
        return view
    }()
    
    override func presentationTransitionWillBegin() {
        guard let container = containerView else { return }
        //guard let toView = presentedView else { return }
        guard let fromView = presentingViewController.view else { return }
        guard let coordinator = presentedViewController.transitionCoordinator else { return }
        guard let presentingVC = presentingViewController as? TabBarViewController else { return }
        guard let contentesView = presentingVC.selectedViewController?.view else { return }
        
        blackLayer.frame = fromView.frame
        contentesView.addSubview(blackLayer)
        coordinator.animate(alongsideTransition: { (context) in
            self.blackLayer.alpha = 0.5
        }) { (_) in

        }
    }
}
// for dismiss
extension AMPresentationController {
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else { return }
        coordinator.animate(alongsideTransition: { (context) in
            self.blackLayer.alpha = 0.0
        }) { (context) in
            if !context.isCancelled {
                self.blackLayer.removeFromSuperview()
            }
        }
    }
}

extension AMPresentationController: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let presented = presentedView else { return }
        guard let container = containerView else { return }
        guard let presenting = presentingViewController.view else { return }
        
        guard let presentedVC = presentedViewController as? MusicDetailViewController else { return }
        guard let presentingVC = presentingViewController as? TabBarViewController else { return }
        guard let contentesView = presentingVC.selectedViewController?.view else { return }
        if isPresenting {
            fakeTabbar = presentingVC.tabBar.snapshotView(afterScreenUpdates: false)
            fakeTabbar?.frame = presentingVC.tabBar.frame
            container.addSubview(presented)
            container.addSubview(fakeTabbar!)
            presented.frame = CGRect(x: 0, y: container.bounds.height - 120, width: container.bounds.width, height: 70)
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                contentesView.layer.cornerRadius = 10
                contentesView.clipsToBounds = true
                contentesView.transform = contentesView.transform.scaledBy(x: 0.95, y: 0.95)
                contentesView.transform = contentesView.transform.translatedBy(x: 0, y: 20 - container.bounds.height * 0.05 / 2)
                presentingVC.tabBar.frame = presentingVC.tabBar.frame.offsetBy(dx: 0, dy: presentingVC.tabBar.bounds.height)
                self.fakeTabbar!.frame = self.fakeTabbar!.frame.offsetBy(dx: 0, dy: self.fakeTabbar!.bounds.height)
                
                presentedVC.frameAfterPresent()
                presented.frame = container.frame.offsetBy(dx: 0, dy: 35)
                presented.layer.cornerRadius = 10
                presented.clipsToBounds = true
            }, completion: { (_) in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            })
        } else {
            if !isInteractive {
                UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    contentesView.layer.cornerRadius = 0
                    contentesView.transform = CGAffineTransform.identity
                    contentesView.frame = container.frame
                    presentingVC.tabBar.frame = presentingVC.tabBar.frame.offsetBy(dx: 0, dy: -presentingVC.tabBar.bounds.height)
                    presentingVC.playBar.isHidden = true
                    self.fakeTabbar!.frame = self.fakeTabbar!.frame.offsetBy(dx: 0, dy: -self.fakeTabbar!.bounds.height)
                    
                    presentedVC.frameBeforePresent()
                    presented.layer.cornerRadius = 0
                    presented.frame = CGRect(x: 0, y: container.bounds.height - 120, width: container.bounds.width, height: 70)
                }, completion: { (_) in
                    if !transitionContext.transitionWasCancelled {
                        self.fakeTabbar?.removeFromSuperview()
                        self.fakeTabbar = nil
                        presentingVC.playBar.isHidden = false
                    }
                    
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
            } else {
                UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 0.75, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    contentesView.layer.cornerRadius = 0
                    contentesView.transform = CGAffineTransform.identity
                    contentesView.frame = container.frame
                    presentingVC.tabBar.frame = presentingVC.tabBar.frame.offsetBy(dx: 0, dy: -presentingVC.tabBar.bounds.height)
                    presentingVC.playBar.isHidden = true
                    self.fakeTabbar!.frame = self.fakeTabbar!.frame.offsetBy(dx: 0, dy: -self.fakeTabbar!.bounds.height)
                    
                    presented.layer.cornerRadius = 0
                    presented.frame = CGRect(x: 0, y: container.bounds.height - 120, width: container.bounds.width, height: 70)
                }, completion: { (_) in
                    if !transitionContext.transitionWasCancelled {
                        self.fakeTabbar?.removeFromSuperview()
                        self.fakeTabbar = nil
                        presentingVC.playBar.isHidden = false
                    }
                    
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
                })
                
                
                
            }
        }
        
    }
}
