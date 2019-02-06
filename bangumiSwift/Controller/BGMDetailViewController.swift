//
//  BGMDetailViewController.swift
//  bangumiSwift
//
//  Created by billgateshxk on 2019/02/05.
//  Copyright © 2019 bi119aTe5hXk. All rights reserved.
//

import UIKit

class BGMDetailViewController: UIViewController,BangumiServicesHandlerDelegate {
    let bs = BangumiServices()
    
    var detailItem:Any!
    var bgmidstr:String!
    
    @IBOutlet var statusmanabtn:UIButton!
    @IBOutlet var progressmanabtn:UIButton!
    @IBOutlet var cover:UIImageView!
    @IBOutlet var titlelabel:UILabel!
    @IBOutlet var titlelabel_cn:UILabel!
    @IBOutlet var ratscoretitle:UILabel!
    @IBOutlet var ratscore:UILabel!
    @IBOutlet var bgmsummary:UITextView!
    @IBOutlet var ranktitle:UILabel!
    @IBOutlet var rankscore:UILabel!
    @IBOutlet var bgmdetailbtn:UIButton!
    @IBOutlet var actionbtn:UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        bs.handlerDelegate = self
        
    }
    
    func Completed(_ sender: BangumiServices, _ data: Any) {
        <#code#>
    }
    
    func Failed(_ sender: BangumiServices, _ data: Any) {
        <#code#>
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
