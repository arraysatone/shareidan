//
//  MapViewController.swift
//  FinalProject
//
//  Created by Marc Harquail on 2018-11-11.
//  Copyright © 2018 Marc Harquail. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate{
    
    //Location that is passed through the delegate
    var data: locData?
    var addr: String?
    var xcoord: Double?
    var ycoord: Double?
    
    var locationManager: CLLocationManager?
    var buildingLoc: CLLocation?
    @IBOutlet weak var mapView: MKMapView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let mapObject = mapView{
            mapObject.delegate = self
        }
        displayBuilding()
    }
    
    func displayBuilding(){
        //Umwrap the locations and map object
        if let mapObject = mapView{
            if let xcoord = self.xcoord, let ycoord = self.ycoord{
                let location = CLLocation(latitude: xcoord, longitude: ycoord)
                //Get the overlays and annotions currently on the map
                let annotationList = mapObject.annotations
                //Initialize the start and end markers
                let buildingMarker = MKPointAnnotation()
                //Remove the annotations
                mapObject.removeAnnotations(annotationList)
                //Draw both the start and end markers
                buildingMarker.coordinate = location.coordinate
                mapObject.addAnnotation(buildingMarker)
                let span = MKCoordinateSpan(latitudeDelta: 1/111.111, longitudeDelta: 1/111.111)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                mapObject.setRegion(region, animated: true)
            }
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        performSegue(withIdentifier: "liveDataViewSegue", sender: self)
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

protocol MapDelegate: AnyObject
{
    // abstract method to be defined in the MapController
    //func routeDidFinish(sender: RouteController, route: MKRoute, start: CLLocation, end: CLLocation)
}
