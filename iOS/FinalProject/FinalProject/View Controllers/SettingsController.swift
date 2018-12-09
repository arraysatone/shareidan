//
//  SettingsController.swift
//  FinalProject
//
//  Created by Xcode User on 2018-12-08.
//  Copyright © 2018 Xcode User. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {

    @IBOutlet weak var StatusText: UILabel!
    @IBOutlet weak var ValueSlider: UISlider!
    @IBOutlet weak var ValueText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func UpdateText(_ sender: Any) {
        self.ValueText.text = String(Int(self.ValueSlider.value))
    }
    @IBAction func UpdateDB(_ sender: Any) {
        postAction(completion: {(status) in
            if let guardStatus = status {
                if (guardStatus){
                    self.StatusText.textColor = self.hexStringToUIColor(hex: "#63e87c")
                    self.StatusText.text = "Threshhold updated!"
                    self.StatusText.isHidden = false
                }
            }
            else{
                self.StatusText.textColor = self.hexStringToUIColor(hex: "#ed2323")
                self.StatusText.text = "Server has issues"
                self.StatusText.isHidden = false
                return
            }
            })
    }
    
    
    func postAction(completion: @escaping ( (Bool?) -> Void) ) {
        guard let guardValue:Float = ValueSlider!.value else {
            return //Please insert User
        }
        let Url = String(format: "https://www.arraysatone.com/php/tempchanger.php?uid=0001203B&temp="+String(Int(guardValue)))
        print("Into PosT")
        guard let serviceUrl = URL(string: Url) else { return }
        //let parameterDictionary = ["user" : userText.text, "pass" : passwordText.text]

        
        let request = URLRequest(url: serviceUrl)
        
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    if let returnData = String(data: data, encoding: .utf8) {
                        DispatchQueue.main.async {
                            if (returnData == "Record updated successfully"){
                                completion(true)
                            }
                            completion(false)
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

    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
