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
    
    let urlpath = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func getLogin(completion: @escaping ( (jsonData?) -> Void) ) {
        
        guard let url = URL(string: urlPath) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let jsonDatas = try JSONDecoder().decode([jsonData].self, from: data)
                
                //Get back to the main queue
                DispatchQueue.main.async {
                    //print(articlesData)
                    self.jsonObj = jsonDatas[0]
                    completion(self.jsonObj)
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            }.resume()
    }


}

