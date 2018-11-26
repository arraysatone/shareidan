//
//  TableViewController.swift
//  FinalProject
//
//  Created by Kevin Baumgartner on 2018-11-11.
//  Copyright © 2018 Kevin Baumgartner. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let buildingPath = "https://arraysatone.com/getBuildings.php"
    
    var locObj: [locData]? = []
    
    @IBOutlet var locationsTable: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadLocations(completion: {(data) in
            
            if let locationsTable = self.locationsTable{
                locationsTable.reloadData()
            }else{
             print("fff")
            }
        })
    }
    
    func downloadLocations(completion: @escaping ( ([locData]?) -> Void) ) {
        
        guard let url = URL(string: buildingPath) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            
            guard let data = data else { return }
            //Implement JSON decoding and parsing
            do {
                //Decode retrived data with JSONDecoder and assing type of Article object
                let locDatas = try JSONDecoder().decode([locData].self, from: data)
                
                var counter = 0
                //Get back to the main queue
                DispatchQueue.main.async {
                    for objects in locDatas{
                        self.locObj?.append(objects)
                        counter = counter + 1
                    }
                    
                    completion(self.locObj)
                    
                }
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            }.resume()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        
            if let location = locObj?[indexPath.row]{
                cell.textLabel?.text = location.address
            }
        return cell
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locObj?.count ?? 1
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
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

}
