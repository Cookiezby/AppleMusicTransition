//
//  AMPresentInteractiveAnimator.swift
//  AppleMusicTransition
//
//  Created by 朱　冰一 on 2018/03/07.
//  Copyright © 2018年 cookie. All rights reserved.
//

import Foundation
import UIKit

protocol AMPresentInteractiveDelegate : class {
    func presentInteractive()
}

class AMPresentInteractiveAnimator: UIPercentDrivenInteractiveTransition {
    
    private var view: UIView
    weak var delegate: AMPresentInteractiveDelegate?
    private var shouldComplete = false
    init(attachTo view: UIView) {
        self.view = view
        super.init()
        setPanGesture(view: view)
    }
    
    private func setPanGesture(view: UIView) {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(gesture:)))
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let viewTransition = gesture.translation(in: view)
        let progress = -viewTransition.y / (UIScreen.main.bounds.height - Const.MusicPlayBarHeight - Const.StatusBarHeight)
        switch gesture.state {
        case .began:
            delegate?.presentInteractive()
        case .changed:
            shouldComplete = progress > 0.3
            update(progress)
        case .cancelled:
            cancel()
        case .ended:
            shouldComplete ? finish() : cancel()
            break
        default:
            break
        }
    }
    
}
