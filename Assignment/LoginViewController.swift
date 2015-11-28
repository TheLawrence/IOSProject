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
    var result = true;


    @IBAction func loginPressed(sender: AnyObject) {
      var user = self.loginField.text
      var password = self.passwordField.text
      
      
      var isUser = getUser("users", database: "iosproject", apiKey: "wT2XOfoaP8f0Q1akvhXjKg0wpqqkgSX_", user: user, password: password)
      
      
      if (user == "gggg" && password == "vvvv"){
        let tabBarController = self.storyboard?.instantiateViewControllerWithIdentifier("TabBarController") as! UITabBarController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = tabBarController

      }
      
      print (user)
      print (password)
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
  
  func getUser( coll: String!, database: String!, apiKey: String!, user: String!, password: String!) -> Bool{
    var recievedData : [Agenda] = []
    var url: NSString!{
      return String("https://api.mongolab.com/api/1/databases/\(database)/collections/\(coll)?q={\"studentNumber\":\"\(user)\"}&apiKey=\(apiKey)")
    }
    
    print(url)
    
    let searchURL : NSURL = NSURL(string: url.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!)!
    Alamofire.request(.GET, searchURL)
      .responseJSON
      { response in
        if let json = response.result.value {
          let json = JSON(response.result.value!)
          if (json.stringValue == ""){
            self.result = false
            dispatch_async(dispatch_get_main_queue()) {
              self.loginError.text = "Unrecognised Credentials"
            }
          }

          for (key, value):(String, JSON) in json{
            self.parseJSON(value)
            self.checkPassword(value["password"].stringValue, inputPassword: password)
          }
        }
    }
    return result
  }
  
  func checkPassword(userPassword:String, inputPassword:String){
    if(userPassword != inputPassword){
      self.loginError.text = "Unrecognised Credentials"
    } 
  }
  
  func parseJSON(json: JSON) {
    let name = json["name"].string
    let set = json["set"].string
    let studentNumber = json["studentNumber"].string
    
    user = User(name: name!, set: set!, studentNumber: studentNumber!)
    print(user.name!)
  }


}
