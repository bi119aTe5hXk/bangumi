//
//  SplitViewController.swift
//  bangumiSwift
//
//  Created by billgateshxk on 2019/02/05.
//  Copyright © 2019 bi119aTe5hXk. All rights reserved.
//

import UIKit

class SplitViewController: UISplitViewController, UISplitViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.delegate = self
        self.splitViewController?.delegate = self
        self.splitViewController?.preferredDisplayMode = UISplitViewController.DisplayMode.allVisible
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    // MARK: - Split view
    
//        func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController:UIViewController, onto primaryViewController:UIViewController) -> Bool {
//            guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
//            guard let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController else { return false }
//            if topAsDetailController.detailItem == nil {
//                // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
//                return true
//            }
//            return false
//        }

    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
            //self.tabBar.invalidateIntrinsicContentSize()
            print("heyyy")
            guard let secondaryAsNavController = secondaryViewController as? UINavigationController else { return false }
            guard let topAsDetailController = secondaryAsNavController.topViewController as? BGMDetailViewController else { return false }
            if topAsDetailController.detailItem == nil {
                // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
                return true
            }
            return false
        }
}
