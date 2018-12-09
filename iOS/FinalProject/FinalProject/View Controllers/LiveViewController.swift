//
//  LiveViewController.swift
//  FinalProject
//
//  Created by Marc Harquail on 2018-11-11.
//  Copyright © 2018 Marc Harquail. All rights reserved.
//

import UIKit
import Foundation

class LiveViewController: UIViewController {
    
    @IBOutlet weak var liveDataLbl: UILabel!
    @IBOutlet weak var movementLbl: UILabel!
    @IBOutlet weak var highLbl: UILabel!
    @IBOutlet weak var lowLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var refreshBtn: UIButton!
    
    var jsonObj : jsonData?
    var timer : Timer?
    
    let urlPath = "https://www.arraysatone.com/php/iOSTemps"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadItems(completion: {(data) in
            self.updateTemp(dataObj: data)
        })
    }
    
    @IBAction func refreshLbls(_ sender: Any) {
        downloadItems(completion: {(data) in
            self.updateTemp(dataObj: data)
        })
    }
    
    func updateTemp(dataObj: jsonData?){
        guard let liveLbl = liveDataLbl,
            let maxLbl = highLbl,
            let minLbl = lowLbl,
            let updateLbl = timeLbl,
            let tempStr = dataObj?.temp,
            let maxStr = dataObj?.max,
            let minStr = dataObj?.min,
            let thresh = dataObj?.thresh
        else{
            return
        }
        let tempSubStr = tempStr.prefix(2)
        let maxSubStr = maxStr.prefix(2)
        let minSubStr = minStr.prefix(2)
        
        if let tempInt = Int(tempSubStr),
            let threshInt = Int(thresh){
            if(tempInt >= threshInt){
                liveLbl.text = String(tempSubStr) + "°C"
                liveLbl.textColor = self.hexStringToUIColor(hex: "#ed2323")
            }
            else{
                liveLbl.text = String(tempSubStr) + "°C"
                liveLbl.textColor = self.hexStringToUIColor(hex: "#63e87c")
            }
        }
        maxLbl.text = String(maxSubStr) + "°C"
        minLbl.text = String(minSubStr) + "°C"
        updateLbl.text = dataObj?.time
    }
    
    func downloadItems(completion: @escaping ( (jsonData?) -> Void) ) {
        
        guard let url = URL(string: urlPath) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                //Decode retrieved data with JSONDecoder and assing type of Article object
                let jsonDatas = try JSONDecoder().decode(jsonData.self, from: data)
                //Get back to the main queue
                DispatchQueue.main.async {
                    //print(articlesData)
                    self.jsonObj = jsonDatas
                    completion(self.jsonObj)
                }
                
            } catch let jsonError {
                print(jsonError)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
