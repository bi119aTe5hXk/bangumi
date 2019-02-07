//
//  WatchingCell.swift
//  bangumiSwift
//
//  Created by billgateshxk on 2019/02/07.
//  Copyright © 2019 bi119aTe5hXk. All rights reserved.
//

import UIKit

class WatchingCell: UITableViewCell {
    @IBOutlet var icon: UIImageView!
    @IBOutlet var titlelabel: UILabel!
    @IBOutlet var progresslabel: UILabel!
    @IBOutlet var updatebtn: UIButton!
    @IBOutlet var prgoressbar: UIProgressView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
