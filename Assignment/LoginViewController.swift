//
//  LoginViewController.swift
//  Assignment
//
//  Created by Jathavan on 2015-11-27.
//  Copyright © 2015 Bryan Chau. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CryptoSwift

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var loginError: UILabel!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginField: UITextField!
    let nextField = [1:2]
    var userExists = true;
    var passwordMatches = true;


    @IBAction func loginPressed(sender: AnyObject) {
      var user = self.loginField.text
      var password = self.passwordField.text?.md5()
      
      var isUser = manageUser("users", database: "iosproject", apiKey: "wT2XOfoaP8f0Q1akvhXjKg0wpqqkgSX_", username: user, password: password)
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController!.navigationBar.barTintColor = UIColor(red: 0/255.0, green: 60/255.0, blue: 113/255.0, alpha: 0)
        navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
      
        for i in 1...2 {
          if let textField = self.view.viewWithTag(i) as? UITextField {
            textField.delegate = self
          }
        }
      

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    // This is called when the user hits the Next/Return key
    func textFieldShouldReturn(textField: UITextField) -> Bool {
      // Consult our dictionary to find the next field
      
      if (textField.tag == 2){
          textField.resignFirstResponder()
      }
      
      if let nextTag = nextField[textField.tag] {
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
          // Have the next field become the first responder
          nextResponder.becomeFirstResponder()
        }
      }
      // Return false here to avoid Next/Return key doing anything
      return false

  }
  
  
  func manageUser( coll: String!, database: String!, apiKey: String!, username: String!, password: String!) -> Bool{
    var url: NSString!{
      return String("https://api.mongolab.com/api/1/databases/\(database)/collections/\(coll)?q={\"studentNumber\":\"\(username)\"}&apiKey=\(apiKey)")
    }

    let searchURL : NSURL = NSURL(string: url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!

    self.alamoRequest(searchURL, password: password){ response in
      if ((response) != nil){
        let tabBarController = self.storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarController
      } 
    }
    
    return false
  }
  
  func alamoRequest(url: NSURL, password:String, completionHandler: (Bool?) -> ()) {
    makeCall(url, password: password, completionHandler: completionHandler)
  }
  
  func makeCall(url: NSURL, password: String, completionHandler: (Bool?) -> ()) {
    
    Alamofire.request(.GET, url).responseJSON
      { response in
        if let json = response.result.value
        {
          let json = JSON(response.result.value!)
          
          var isUserValid = self.isUserExist(json);
          var retrievedPassword = "";
          var doesPasswordMatch = false
          
          if(isUserValid)
          {
            for (key, value):(String, JSON) in json
            {
              self.parseJSON(value)
              retrievedPassword = value["password"].stringValue
            }
          }
          
          doesPasswordMatch = self.checkPassword(retrievedPassword, inputPassword: password)
          
          if (isUserValid && doesPasswordMatch){
            completionHandler(true)
          } else {
            completionHandler(nil)
          }
          
          
        } //end json LET
    }
  }
  

  func isUserExist(result: JSON) -> Bool{
    if (result.isEmpty){
      dispatch_async(dispatch_get_main_queue()) {
        self.loginError.text = "Unrecognised Username"
      }
      return false
    }
    return true
  }
  
  func checkPassword(userPassword:String, inputPassword:String) -> Bool{
    if(userPassword != inputPassword){
      self.loginError.text = "Unrecognised Password"
      return false
    }
    return true;
  }
  
  func parseJSON(json: JSON) {
    let name = json["name"].string
    let set = json["set"].string
    let studentNumber = json["studentNumber"].string
    
    user = User(name: name!, set: set!, studentNumber: studentNumber!)
  }

}

