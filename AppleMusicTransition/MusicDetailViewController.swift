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
    let coverImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "cover"))
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let headerButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 2
        button.backgroundColor = UIColor.lightGray
        return button
    }()

    var originFrame = CGRect.zero
    weak var delegate: MusicDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .groupTableViewBackground
        view.addSubview(coverImage)
        view.addSubview(headerButton)
        headerButton.addTarget(self, action: #selector(handleTap(_:)), for: .touchUpInside)
        frameBeforePresent()

        let pan = UIPanGestureRecognizer(target: self, action: #selector(handlePan(gesture:)))
        view.addGestureRecognizer(pan)
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
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        let viewTransition = gesture.translation(in: view)
        let progress = viewTransition.y / (originFrame.height - 35)
        
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
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    self.view.frame = self.originFrame
                })
            }
            break
        default:
            break
        }
    }

    func update(_ progress: CGFloat) {
        delegate?.update(progress)
        view.frame = CGRect(x: 0, y: originFrame.origin.y + (originFrame.height - 35) * progress, width: view.bounds.width, height: view.bounds.height)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
