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
    var transitionAnimator = AMTransitionAnimator(duration: 0.5)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playBar = PlayBarView(frame: CGRect(x: 0, y: view.bounds.height - 120, width: view.bounds.width, height: 70))
        view.addSubview(playBar)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(presentDetail(_:)))
        playBar.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
    
    @objc func presentDetail(_ sender: UITapGestureRecognizer) {
        let vc = MusicDetailViewController()
        vc.transitioningDelegate = self
        present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TabBarViewController: UIViewControllerTransitioningDelegate {
//    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transitionAnimator.isPresenting = true
//        return transitionAnimator
//    }
//
//    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transitionAnimator.isPresenting = false
//        return transitionAnimator
//    }
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return nil
    }
}


