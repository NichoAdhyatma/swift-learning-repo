//
//  MessageCell.swift
//  Flash Chat iOS13
//
//  Created by nicho@mac on 28/01/25.
//  Copyright © 2025 Angela Yu. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    @IBOutlet weak var messageBuble: UIView!
    
    @IBOutlet weak var rightAvatar: UIImageView!
    
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var leftAvatar: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageBuble.layer.cornerRadius = 20
    }
    
}
