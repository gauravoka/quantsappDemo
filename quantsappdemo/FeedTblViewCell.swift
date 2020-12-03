//
//  FeedTblViewCell.swift
//  quantsappdemo
//
//  Created by Gaurav Oka on 03/12/20.
//

import UIKit

class FeedTblViewCell: UITableViewCell {
    
    
    @IBOutlet weak var outerCellView: UIView!
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeStampLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var descImgView: UIImageView!
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
