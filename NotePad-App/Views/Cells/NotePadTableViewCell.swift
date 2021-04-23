//
//  NotePadTableViewCell.swift
//  NotePad-App
//
//  Created by mohamed samir on 21/04/2021.
//

import UIKit

class NotePadTableViewCell: UITableViewCell {
    

    
    @IBOutlet weak var titleLB: UILabel!
    @IBOutlet weak var descriptionLB: UILabel!
    @IBOutlet weak var nearestLB: UILabel!
    @IBOutlet weak var noteImage: UIImageView!
    @IBOutlet weak var locationImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
