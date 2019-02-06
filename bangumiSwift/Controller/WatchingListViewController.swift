//
//  WatchingListViewController.swift
//  bangumiSwift
//
//  Created by billgateshxk on 2019/02/05.
//  Copyright © 2019 bi119aTe5hXk. All rights reserved.
//

import UIKit

class WatchingListViewController: UITableViewController, BangumiServicesHandlerDelegate {
    let bs = BangumiServices()
    let loginsv = LoginServices.self
    let bslist = Array.init([])
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController!.navigationItem.title  = "进度管理";
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let refreshControl = UIRefreshControl.init()
        refreshControl.addTarget(self, action: #selector(self.onRefresh), for: UIControl.Event.valueChanged)
        self.refreshControl = refreshControl
        bs.handlerDelegate = self
        
        self.checkLoginAndLoadList()
        
    }
    func checkLoginAndLoadList() {
        if (loginsv.isLogin() == false) {
            self.notLoginMSG()
        }else{
            
        }
    }
    func notLoginMSG() {
        self.refreshControl?.endRefreshing()
        let alert = UIAlertController.init(title: "您需要登录才可继续操作", message: "请点击登录按钮跳转网页进行登录或注册操作.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction.init(title: "登录", style: UIAlertAction.Style.default, handler: { (UIAlertAction) in
            self.loginsv.tryLogin()
        }))
        alert.addAction(UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    @objc func onRefresh() {
        self.checkLoginAndLoadList()
    }

    func Completed(_ sender: BangumiServices, _ data: Any) {
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
        }
    }
    
    func Failed(_ sender: BangumiServices, _ data: Any) {
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
        }
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
