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
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .groupTableViewBackground
        view.addSubview(coverImage)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tap)
    }
    
    func frameBeforePresent() {
        coverImage.frame = CGRect(x: 20, y: 10, width: 50, height: 50)
    }
    
    func frameAfterPresent() {
        let coverWidth = view.bounds.width * 0.8
        coverImage.frame = CGRect(x: (view.bounds.width - coverWidth) / 2, y: 30, width: coverWidth, height: coverWidth)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        dismiss(animated: true, completion: nil)
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
