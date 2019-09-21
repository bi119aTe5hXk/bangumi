//
//  BGMDetailViewController.swift
//  bangumiSwift
//
//  Created by billgateshxk on 2019/02/05.
//  Copyright © 2019 bi119aTe5hXk. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
class BGMDetailViewController: UIViewController {
    var detailDic: Dictionary<String, Any>? = Dictionary.init()
    var detailItem:Any!
    var bgmidstr:String?
    
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
        self.navigationItem.title = "番组详细"
        //self.navigationItem.backBarButtonItem?.title = "返回"
        self.progressmanabtn.isHidden = true
        self.statusmanabtn.isHidden = true
        
        
        
        
        if bgmidstr != nil {
            print("did get:" + bgmidstr!)
            getBGMDetail(withID: bgmidstr!){ isSuccess,result in
                //guard let responseObject = responseObject, error == nil else {
                //    print(error ?? "Unknown error")
                //    return
                //}
                if isSuccess {
                    self.detailDic = (result as? Dictionary<String, Any>)!
                    if let dic = self.detailDic!["images"]{
                        if dic is NSNull {
                            // no img
                            self.cover.image = nil
                        }else{
                            let imgurlstr: String = (dic as! Dictionary<String, Any>)["large"] as! String
                            
                            self.cover.af_setImage(withURL: URL(string: imgurlstr)!,
                                                      placeholderImage: nil,
                                                      filter: .none,
                                                      progress: .none,
                                                      progressQueue: .main,
                                                      imageTransition: .noTransition,
                                                      runImageTransitionIfCached: true) { (data) in
                                                        
                            }
                        }
                        
                    }
                    DispatchQueue.main.async {
                        self.progressmanabtn.isHidden = false
                        self.statusmanabtn.isHidden = false
                        self.ratscore.isHidden = false
                        self.ratscoretitle.isHidden = false
                        self.rankscore.isHidden = false
                        self.ranktitle.isHidden = false
                        self.actionbtn.isEnabled = true
                        self.bgmdetailbtn.isHidden = false
                        
                        self.titlelabel.text = (self.detailDic!["name"] as! String)
                        self.titlelabel_cn.text = (self.detailDic!["name_cn"] as! String)
                        self.bgmsummary.text = (self.detailDic!["summary"] as! String)
                        
                        if(self.detailDic!["rating"] != nil && (self.detailDic!["rating"] as! Dictionary<String,Any>)["score"] != nil){
                            self.ratscore.text = String((self.detailDic!["rating"] as! Dictionary<String,Any>)["score"] as! Double) + "/10"
                        }else{
                            self.ratscore.text = "暂无评分"
                        }
                        
                        if (self.detailDic!["rank"] != nil){
                            self.rankscore.text = String(self.detailDic!["rank"] as! Int)
                        }else{
                            self.rankscore.text = "暂无排行"
                        }
                    }
                }
                
                
                
                
            }
        }else{
//            let alert = UIAlertController.init(title: "出错了！", message: "BGMID长度为0。", preferredStyle: UIAlertController.Style.alert)
//            alert.addAction(UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
        }
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
