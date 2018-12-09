//
//  ViewController.swift
//  FinalProject
//
//  Created by Xcode User on 2018-10-26.
//  Copyright © 2018 Xcode User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var userText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    var loginStatus = false
    
    let urlPath = "https://www.arraysatone.com/iOSfinallogin.php?user=a&pass=a"
    var jsonObj : jsonData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func getLogin(_ sender: Any) {
        postAction(completion: {(data) in
            guard let guardAccess = data else {return}
            self.Login(success: guardAccess)
        })
    }
    
    func Login(success : Bool){
        if (success){
            self.performSegue(withIdentifier: "locSegue", sender: self)
        }
        else{
            let alert = UIAlertController(title: "ERROR", message: "Invalid Credentials", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    
    func postAction(completion: @escaping ( (Bool?) -> Void) ) {
        let Url = String(format: "https://www.arraysatone.com/php/login.php")
        guard let serviceUrl = URL(string: Url) else { return }
        //let parameterDictionary = ["user" : userText.text, "pass" : passwordText.text]
        guard let guardUser:String = userText.text else {
            return //Please insert User
        }
        guard let guardPass: String = passwordText.text else {
            return //Please insert pass
        }
        let URLMake = "user="+guardUser+"&pass="+guardPass
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        guard let httpBody = URLMake.data(using: String.Encoding.utf8) else {
            print("Parameter Make Failure")
            return
        }
        request.httpBody = httpBody
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    //print(response)
                }
                if let data = data {
                    do {
                        if let returnData = String(data: data, encoding: .utf8) {
                            DispatchQueue.main.async {
                                if (returnData == "success"){
                                    self.loginStatus = true
                                }
                                completion(self.loginStatus)
                            }

                        } else {
                            print("")
                        }
                        
                    }catch {
                        print(error)
                    }
                }
            }.resume()
        
    }
}

