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
    var interactiveAnimator: AMInteractiveAnimator?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .white
        playBar = PlayBarView(frame: CGRect(x: 0, y: view.bounds.height - 120, width: view.bounds.width, height: 70))
        view.addSubview(playBar)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentDetail(_:)))
        playBar.addGestureRecognizer(tap)
        
    }
    
    @objc func presentDetail(_ sender: UITapGestureRecognizer) {
        let vc = MusicDetailViewController()
        vc.transitioningDelegate = self
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        interactiveAnimator = AMInteractiveAnimator(attachTo: vc)
        present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TabBarViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator?.isPresenting = true
        return presentationAnimator
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        presentationAnimator?.isPresenting = false
        presentationAnimator?.isInteractive = false
        return presentationAnimator
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        self.presentationAnimator = AMPresentationController(presentedViewController: presented, presenting: presenting)
        self.interactiveAnimator?.presentationController = presentationAnimator
        return presentationAnimator
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        guard let ia = interactiveAnimator else { return nil }
        presentationAnimator?.isInteractive = ia.transitionInProgress ? true : false
        return ia.transitionInProgress ? ia : nil
    }
}


