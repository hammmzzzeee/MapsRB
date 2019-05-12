//
//  SinglePointOnMapViewController.swift
//  MapsRB
//
//  Created by HAMZA on 11/05/2019.
//  Copyright © 2019 HAMZA. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class SinglePointOnMapViewController: UIViewController {

    var selectedUser = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addMarkerOnMap()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // add marker on map
    func addMarkerOnMap() {
        let camera = GMSCameraPosition.camera(withLatitude: Double(truncating: selectedUser.latitude), longitude: Double(truncating: selectedUser.longitude), zoom: 12.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: Double(truncating: selectedUser.latitude), longitude: Double(truncating: selectedUser.longitude))
        marker.title = "Location"
        marker.icon = UIImage(named:"iconLocation.png")
        marker.map = mapView
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
