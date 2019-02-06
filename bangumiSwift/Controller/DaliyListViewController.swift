//
//  DaliyListViewController.swift
//  bangumiSwift
//
//  Created by billgateshxk on 2019/02/05.
//  Copyright © 2019 bi119aTe5hXk. All rights reserved.
//

import UIKit

class DaliyListViewController: UITableViewController, BangumiServicesHandlerDelegate {
    let bs = BangumiServices()
    var daylist = Array.init([])

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem

        let refreshControl = UIRefreshControl.init()
        refreshControl.addTarget(self, action: #selector(self.onRefresh), for: UIControl.Event.valueChanged)
        self.refreshControl = refreshControl
        bs.handlerDelegate = self

        if (daylist.count <= 0) {
            self.startGetDayBGMList()
        }
    }
    @objc func onRefresh() {
        self.startGetDayBGMList()
    }
    func startGetDayBGMList() {
        bs.calendar()
        
    }

    func Completed(_ sender: BangumiServices, _ data: Array<Any>?) {
        self.refreshControl?.endRefreshing()
        daylist = data!
        self.tableView.reloadData()
        jumpToToday()
    }
    func jumpToToday(){
        let ip = IndexPath.init(row: 0, section: self.todayNum())
        self.tableView.scrollToRow(at: ip, at: UITableView.ScrollPosition.top, animated: true)
    }
    func todayNum()->Int{
        let gregorian = Calendar.init(identifier: Calendar.Identifier.japanese)
        let comps = gregorian.component(Calendar.Component.weekday, from: Date.init())
        //var wd = comps.weekday
        switch comps {
        case 1:
            //sun
            return 6
        case 2:
            //mon
            return 0
        case 3:
            //tue
            return 1
        case 4:
            //wen
            return 2
        case 5:
            //tur
            return 3
        case 6:
            //fri
            return 4
        case 7:
            //sat
            return 5
        default:
            return 0
        }
        
    }

    func Failed(_ sender: BangumiServices, _ data: Any?) {
        self.refreshControl?.endRefreshing()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return daylist.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0//daylist[section]
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
