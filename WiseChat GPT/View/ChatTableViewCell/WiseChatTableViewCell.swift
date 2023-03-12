//
//  WiseChatTableViewCell.swift
//  WiseChat GPT
//
//  Created by Md Murad Hossain on 25/2/23.
//

import UIKit

class WiseChatTableViewCell: UITableViewCell {

    @IBOutlet weak var chatAnswerbgcellView: UIView!
    @IBOutlet weak var wiseChatTextLabel: UILabel!
    @IBOutlet weak var wiseChatImageView: UIImageView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userBGView: UIView!
    @IBOutlet weak var userTextLabel: UILabel!
    
    let colors = Colors()

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if userTextLabel.text!.count < 31 && wiseChatTextLabel.text!.count < 31 {
            userBGView.roundCorners(corners: [.topRight, .bottomLeft, .topLeft], radius: 10)
            chatAnswerbgcellView.roundCorners(corners: [.topRight, .bottomRight, .topLeft], radius: 10)
        } else if userTextLabel.text!.count < 150 && wiseChatTextLabel.text!.count < 150 {
            userBGView.roundCorners(corners: [.topRight, .bottomLeft, .topLeft], radius: 20)
            chatAnswerbgcellView.roundCorners(corners: [.topRight, .bottomRight, .topLeft], radius: 20)
            
        } else {
            userBGView.roundCorners(corners: [.topRight, .bottomLeft, .topLeft], radius: 15)
            chatAnswerbgcellView.roundCorners(corners: [.topRight, .bottomRight, .topLeft], radius: 15)
        }
    }
    
    func userbgGradientViewColor() {
        let colorTop =  UIColor(red: 15.0/255.0, green: 118.0/255.0, blue: 128.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 84.0/255.0, green: 187.0/255.0, blue: 187.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        userBGView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func ChatGPTbgGradientViewColor() {
        let colorTop =  UIColor(red: 15.0/255.0, green: 118.0/255.0, blue: 128.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 84.0/255.0, green: 187.0/255.0, blue: 187.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        chatAnswerbgcellView.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}


class Colors {
    let colorTop = UIColor(red: 10, green: 10, blue: 100, alpha: 1.0)
    let colorBottom = UIColor(red: 10, green: 10, blue: 100, alpha: 1.0)
    
    let gl: CAGradientLayer
    
    init() {
        gl = CAGradientLayer()
        gl.colors = [ colorBottom, colorTop]
        gl.locations = [1.0, 0.1]
    }
}

