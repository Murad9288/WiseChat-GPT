//
//  HistoryDetailsTableViewCell.swift
//  WiseChat GPT
//
//  Created by Md Murad Hossain on 9/3/23.
//

import UIKit

class HistoryDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var robotImageView: UIImageView!
    @IBOutlet weak var robotTextLabel: UILabel!
    @IBOutlet weak var robotView: UIView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var userView: UIView!
    @IBOutlet weak var userImageView2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        userbgGradientViewColor()
//        ChatGPTbgGradientViewColor()

    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        if userLabel.text!.count < 28 && robotTextLabel.text!.count < 28 {
            userView.roundCorners(corners: [.topRight, .bottomLeft, .topLeft], radius: 10)
            robotView.roundCorners(corners: [.topRight, .bottomRight, .topLeft], radius: 10)
        } else {
            userView.roundCorners(corners: [.topRight, .bottomLeft, .topLeft], radius: 15)
            robotView.roundCorners(corners: [.topRight, .bottomRight, .topLeft], radius: 15)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
