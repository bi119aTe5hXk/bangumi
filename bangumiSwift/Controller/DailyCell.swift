//
//  DailyCell.swift
//  bangumiSwift
//
//  Created by billgateshxk on 2019/02/06.
//  Copyright © 2019 bi119aTe5hXk. All rights reserved.
//

import UIKit

class DailyCell: UITableViewCell {

    @IBOutlet var icon: UIImageView!
    @IBOutlet var ratscorelabel: UILabel!
    @IBOutlet var sublabel: UILabel!
    @IBOutlet var titlelabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
