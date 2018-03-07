//
//  TabBarViewController.swift
//  AppleMusicTransition
//
//  Created by cookie on 05/03/2018.
//  Copyright © 2018 cookie. All rights reserved.
//

import UIKit
class TabBarViewController: UITabBarController {
    var playBar: PlayBarView!
    var presentationAnimator: AMPresentationController?
    var presentInteractiveAnimator: AMPresentInteractiveAnimator?

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .white
        playBar = PlayBarView(frame: CGRect(x: 0, y: view.bounds.height - 120, width: view.bounds.width, height: 120))
        view.insertSubview(playBar, belowSubview: tabBar)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        playBar.addGestureRecognizer(tap)
        
        presentInteractiveAnimator = AMPresentInteractiveAnimator(attachTo: playBar)
        presentInteractiveAnimator?.delegate = self
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        presentDetail()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func presentDetail() {
        let vc = MusicDetailViewController()
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        vc.delegate = self
        present(vc, animated: true, completion: nil)
    }
}

extension TabBarViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator?.isPresenting = true
        return presentationAnimator
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator?.isPresenting = false
        return presentationAnimator
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        self.presentationAnimator = AMPresentationController(presentedViewController: presented, presenting: presenting)
        return presentationAnimator
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return presentInteractiveAnimator
    }
}

extension TabBarViewController: MusicDetailViewControllerDelegate {
    func update(_ progress: CGFloat) {
        guard let currView = selectedViewController?.view else { return }
        currView.transform = CGAffineTransform.identity.scaledBy(x: 0.95 + 0.05 * progress, y: 0.95 + 0.05 * progress)
    }
}

extension TabBarViewController: AMPresentInteractiveDelegate {
    func presentInteractive() {
        presentDetail()
    }
}


