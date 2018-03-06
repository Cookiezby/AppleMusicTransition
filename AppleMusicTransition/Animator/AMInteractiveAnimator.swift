//
//  AMPercentAnimator.swift
//  AppleMusicTransition
//
//  Created by cookie on 06/03/2018.
//  Copyright © 2018 cookie. All rights reserved.
//

import Foundation
import UIKit

class AMInteractiveAnimator: UIPercentDrivenInteractiveTransition {
    
    weak var viewController: UIViewController?
    weak var presentationController: AMPresentationController?
    var transitionInProgress = false
    var shouldCompleteTransition = false
 
    
    init(attachTo viewController: UIViewController) {
        self.viewController = viewController
        super.init()
        setupGesture(view: viewController.view)
    }
    
    private func setupGesture(view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        guard let vc = viewController else { return }
        let viewTransition = gesture.translation(in: vc.view)
        let progress = viewTransition.y / UIScreen.main.bounds.height / 3
        
        switch gesture.state {
        case .began:
            transitionInProgress = true
            vc.dismiss(animated: true, completion: nil)
        case .changed:
            shouldCompleteTransition = progress > 0.2
            update(progress)
        case .cancelled:
            transitionInProgress = false
            cancel()
        case .ended:
            transitionInProgress = false
            shouldCompleteTransition ? finish() : cancel()
        default:
            break
        }
    }
}
