//
//  LoginViewController.swift
//  bangumi2
//
//  Created by bi119aTe5hXk on 2016/03/21.
//  Copyright © 2016年 HT&L. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController,UITextFieldDelegate,BGMAPIDelegate{
    @IBOutlet weak var usernamefield:UITextField!
    @IBOutlet weak var passwordfield:UITextField!
    
    @IBOutlet weak var registBTN:UIButton!
    @IBOutlet weak var loginBTN:UIButton!
    
    var userdefaults:NSUserDefaults!
    var auth:NSString!
    var auth_urlencoded:NSString!
    var userid:NSString!
    var request_type:NSString!
    
    weak var bgmapi:BGMAPI?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.usernamefield.delegate = self
        self.passwordfield.delegate = self
        // Do any additional setup after loading the view.
        
        
        userdefaults = NSUserDefaults.standardUserDefaults()
        bgmapi?.initWithdelegate(self);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func loginBTNPressed(sender: UIButton) {
        
        if (self.usernamefield.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 && self.passwordfield.text?.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0) {
            bgmapi?.userLogin(self.usernamefield.text!, password:self.passwordfield.text! )
        }
        
        
        
        
        
        
        
    }
    @IBAction func registerBTNPressed(sender: UIButton) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


