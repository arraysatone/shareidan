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
    
    var jsonObj : jsonData?
    
    let urlPath = "https://www.arraysatone.com/php/iOSTemps"
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            let minStr = dataObj?.min
        else{
            return
        }
        let tempSubStr = tempStr.prefix(2)
        let maxSubStr = maxStr.prefix(2)
        let minSubStr = minStr.prefix(2)
        liveLbl.text = String(tempSubStr) + "°C"
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
