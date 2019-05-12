//
//  AllUsersMapViewController.swift
//  MapsRB
//
//  Created by HAMZA on 11/05/2019.
//  Copyright © 2019 HAMZA. All rights reserved.
//

import UIKit
import GoogleMaps

class AllUsersMapViewController: UIViewController {
    var mapView = GMSMapView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get lat and lng of user
        let lat = read(key: "lat")
        let lng = read(key: "lng")

        // Get All Users
        ApiService.getUsers(finish:finishPost)
        let camera = GMSCameraPosition.camera(withLatitude: lat, longitude: lng, zoom: 11.0)
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // add marker on map
    func addMarkerOnMap(latitude:Double, longitude:Double) {

        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
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
    
    //User Defaults
    func read(key:String)->Double{
        let preferences = UserDefaults.standard
        let key = key
        if preferences.object(forKey: key) == nil {
            //  Doesn't exist
            return 0
        } else {
            let value = preferences.double(forKey: key)
            return value
        }
    }
    
    //call back of network call
    func finishPost (arrUsers:[User]) -> Void
    {
        DispatchQueue.main.async{
        for user in arrUsers{
            
            self.addMarkerOnMap(latitude: Double(truncating: user.latitude), longitude: Double(truncating: user.longitude))

            }

        }
        
    }
}
