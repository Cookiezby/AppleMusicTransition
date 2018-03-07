//
//  MusicDetailViewController.swift
//  AppleMusicTransition
//
//  Created by cookie on 05/03/2018.
//  Copyright © 2018 cookie. All rights reserved.
//

import UIKit

protocol MusicDetailViewControllerDelegate: class{
    func update(_ progress: CGFloat)
}

class MusicDetailViewController: UIViewController {
    private let coverImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "cover"))
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let headerButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 2
        button.backgroundColor = UIColor.lightGray
        return button
    }()

    private var originFrame = CGRect(x: 0, y: 0, width: 0, height: 1)
    weak var delegate: MusicDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(coverImage)
        view.addSubview(headerButton)
        headerButton.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        view.addGestureRecognizer(pan)
        
        frameBeforePresent()
    }
    
    func frameBeforePresent() {
        headerButton.isHidden = true
        coverImage.layer.cornerRadius = 3
        coverImage.frame = CGRect(x: 20, y: 10, width: 50, height: 50)
    }
    
    func frameAfterPresent() {
        headerButton.isHidden = false
        headerButton.frame = CGRect(x: (view.bounds.width - 100) / 2, y: 10, width: 100, height: 5)
        let coverWidth = view.bounds.width * 0.8
        coverImage.layer.cornerRadius = 8
        coverImage.frame = CGRect(x: (view.bounds.width - coverWidth) / 2, y: 40, width: coverWidth, height: coverWidth)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        let viewTransition = gesture.translation(in: view)
        let progress = viewTransition.y / (originFrame.height - Const.MusicPlayBarHeight)
        switch gesture.state {
        case .began:
            originFrame = view.frame
        case .changed:
            update(progress)
        case .cancelled:
            break
        case .ended:
            if progress > 0.2 {
                dismiss(animated: true, completion: nil)
            } else {
                UIView.animate(withDuration: 0.2 + 0.2 * Double(progress), delay: 0, options: .curveEaseInOut, animations: {
                    self.delegate?.update(0)
                    self.view.frame = self.originFrame
                })
            }
            break
        default:
            break
        }
    }

    private func update(_ progress: CGFloat) {
        delegate?.update(progress)
        view.frame = CGRect(x: 0, y: originFrame.origin.y + (originFrame.height - Const.MusicPlayBarHeight) * progress, width: view.bounds.width, height: view.bounds.height)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
