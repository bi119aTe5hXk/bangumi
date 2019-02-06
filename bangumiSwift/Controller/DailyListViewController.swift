//
//  DaliyListViewController.swift
//  bangumiSwift
//
//  Created by billgateshxk on 2019/02/05.
//  Copyright © 2019 bi119aTe5hXk. All rights reserved.
//

import UIKit

class DailyListViewController: UITableViewController, BangumiServicesHandlerDelegate {
    let bs = BangumiServices()
    var daylist: Array<Dictionary<String, Any>>? = nil

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

        if (daylist!.count <= 0) {
            self.startGetDayBGMList()
        }
    }
    @objc func onRefresh() {
        self.startGetDayBGMList()
    }
    func startGetDayBGMList() {
        bs.calendar()

    }

    func Completed(_ sender: BangumiServices, _ data: Any) {
        self.refreshControl?.endRefreshing()
        daylist = data as? Array<Dictionary<String, Any>>
        self.tableView.reloadData()
        jumpToToday()
    }
    func jumpToToday() {
        let ip = IndexPath.init(row: 0, section: self.todayNum())
        self.tableView.scrollToRow(at: ip, at: UITableView.ScrollPosition.top, animated: true)
    }
    func todayNum() -> Int {
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

    func Failed(_ sender: BangumiServices, _ data: Any) {
        self.refreshControl?.endRefreshing()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return (daylist != nil) ? daylist!.count : 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if (daylist != nil)
        {
            let items = daylist![section]["items"] as? Array<Any>

            if (items != nil)
            {
                return items!.count;
            }
        }

        return 0;
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyCell", for: indexPath) as! DailyCell

        let dic = daylist![indexPath.section]
        var cont = dic["items"] as! Array<Any>
        var arr = cont[indexPath.row] as! Dictionary<String, Any>

        cell.titlelabel.text = (arr["name"] as! String)
        cell.sublabel.text = (arr["name_cn"] as! String)
        cell.ratscorelabel.text = ((arr["rating"]as! Dictionary<String, Any>)["score"] as! String)
        if (arr["images"] != nil) {
            let imgurlstr: String = (arr["images"]as! Dictionary<String, Any>)["small"] as! String

            if (imgurlstr.lengthOfBytes(using: String.Encoding.utf8) > 0) {
                cell.icon.image = nil
                DispatchQueue.global().async {
                    do {
                        let imgdata = try Data.init(contentsOf: URL(string: imgurlstr)!)
                        let image = UIImage.init(data: imgdata)

                        DispatchQueue.main.async {
                            cell.icon.image = image
                        }
                    } catch { }

                }

            }
        }

        return cell
    }


    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (daylist != nil)
        {
            let items = daylist![section]["weekday"] as? Dictionary<String, Any>

            if (items != nil)
            {
                return (items!["cn"] as! String)
            }
        }
        return "";
    }
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.

    }


}
