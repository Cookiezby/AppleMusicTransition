//
//  PlayBarView.swift
//  AppleMusicTransition
//
//  Created by cookie on 05/03/2018.
//  Copyright © 2018 cookie. All rights reserved.
//

import Foundation
import UIKit

class PlayBarView: UIView {
    
    let thumbnailView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "cover"))
        view.contentMode = .scaleAspectFit
        view.layer.shadowOpacity = 0.3
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowRadius = 10
        view.layer.cornerRadius = 3
        view.clipsToBounds = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .groupTableViewBackground
        addSubview(thumbnailView)
        thumbnailView.frame = CGRect(x: 20, y: 10, width: 50, height: 50)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
