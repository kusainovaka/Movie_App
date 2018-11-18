//
//  VideoCell.swift
//  MovieApp
//
//  Created by Kamila Kusainova on 18.11.2018.
//  Copyright © 2018 Kamila Kusainova. All rights reserved.
//

import UIKit

class VideoCell: UICollectionViewCell {
    
    let videoNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = NSTextAlignment.center
        label.font = UIFont.systemFont(ofSize: 26)
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.007843137255, green: 0, blue: 0.1215686275, alpha: 1)
        layer.cornerRadius = 5
        layer.borderColor = #colorLiteral(red: 0.9568627451, green: 0.6705882353, blue: 0.1019607843, alpha: 1)
        layer.borderWidth = 3
        
        addSubview(videoNameLabel)
        [videoNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
         videoNameLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15)
            ].forEach {
                $0.isActive = true
        }
    }
    
    func videoName(_ name: String) {
        videoNameLabel.text = name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
