//
//  ArticleTableViewCell.swift
//  CKCC
//
//  Created by Bun Leap on 4/26/17.
//  Copyright © 2017 CKCC. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        containerView.layer.cornerRadius = 5.0
        containerView.layer.masksToBounds = false
        containerView.layer.shadowColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        containerView.layer.shadowOffset = CGSize.zero
        containerView.layer.shadowOpacity = 0.8
        titleView.backgroundColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0, alpha: 0.3)
        
    }

}
