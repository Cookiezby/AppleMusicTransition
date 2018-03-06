//
//  MusicDetailViewController.swift
//  AppleMusicTransition
//
//  Created by cookie on 05/03/2018.
//  Copyright © 2018 cookie. All rights reserved.
//

import UIKit

class MusicDetailViewController: UIViewController {
    let coverImage: UIImageView = {
        let view = UIImageView(image: UIImage(named: "cover"))
        view.clipsToBounds = true
        view.isUserInteractionEnabled = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .groupTableViewBackground
        view.addSubview(coverImage)
        frameBeforePresent()
//        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
//        view.addGestureRecognizer(tap)
    }
    
    func frameBeforePresent() {
        coverImage.layer.cornerRadius = 3
        coverImage.frame = CGRect(x: 20, y: 10, width: 50, height: 50)
    }
    
    func frameAfterPresent() {
        let coverWidth = view.bounds.width * 0.8
        coverImage.layer.cornerRadius = 8
        coverImage.frame = CGRect(x: (view.bounds.width - coverWidth) / 2, y: 30, width: coverWidth, height: coverWidth)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
