//
//  TableViewController.swift
//  FinalProject
//
//  Created by Kevin Baumgartner on 2018-11-11.
//  Copyright © 2018 Kevin Baumgartner. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, MapDelegate {
    
    //Declarations
    var delegate: TableViewDelegate?
    let buildingPath = "https://arraysatone.com/getBuildings.php"
    var locObj: [locData]? = []
    var mapAddr: String?
    var mapX: Double?
    var mapY: Double?
    
    //Outlets
    @IBOutlet var locationsTable: UITableView?
    
    //On Initial Load Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadLocations(completion: {(data) in
            
            if let locationsTable = self.locationsTable{
                locationsTable.dataSource = self
                locationsTable.delegate = self
                locationsTable.reloadData()
            }else{
                print("Unable to reload table with downloaded data.")
            }
        })
    }
    
    //Function to Download Locations from the online Database using JSONSerialization
    func downloadLocations(completion: @escaping ( ([locData]?) -> Void) ) {
        
        guard let url = URL(string: buildingPath) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }
            do {
                let locDatas = try JSONDecoder().decode([locData].self, from: data)
                var counter = 0
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
    
    //Stylize TableView Cells
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        
        cell.textLabel?.numberOfLines = 0
        
        if let location = locObj?[indexPath.row]{
            cell.textLabel?.text = location.address
        }
        return cell
    }
    
    //Table Sections
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //Table Rows
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.locObj?.count ?? 1
    }
    
    //On Location Select, Assign data to Method to be sent to the MapViewController
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let location = locObj?[indexPath.row]{
            if let address = location.address, let xcoord = location.xcoord, let ycoord = location.ycoord{
                mapAddr = address
                print(xcoord)
                mapX = Double(xcoord)
                mapY = Double(ycoord)
                performSegue(withIdentifier: "thinClientViewSegue", sender: nil)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Make sure the segue is going to the right place
        if let delegate = segue.destination as? MapViewController, let xcoord = mapX, let ycoord = mapY{
            delegate.addr = mapAddr
            delegate.xcoord = xcoord
            delegate.ycoord = ycoord
        }
        else{
            print("No Location")
        }
    }
    
    //Assigning data
    func handleBack(_ sender: Any, xcoord: String?, ycoord: String?)
    {
        delegate?.tableViewDidFinish(sender:self, xcoord: xcoord, ycoord: ycoord)
        dismiss(animated:true, completion:nil)
    }
}

//TableViewDelegate
protocol TableViewDelegate: AnyObject
{
    func tableViewDidFinish(sender: TableViewController, xcoord: String?, ycoord: String?)
}
