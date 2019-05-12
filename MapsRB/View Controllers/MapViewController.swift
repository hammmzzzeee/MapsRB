//
//  MapViewController.swift
//  MapsRB
//
//  Created by HAMZA on 10/05/2019.
//  Copyright © 2019 HAMZA. All rights reserved.
//

import UIKit
import GoogleMaps


class MapViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    var latitude = Double()
    var longitude = Double()

   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        // setting default values
        latitude = 0.0
        longitude = 0.0
        
        // Ask for Authorisation from the User.
        self.locationManager.requestAlwaysAuthorization()
        
        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestAlwaysAuthorization()

            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    
    // Location Manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        latitude = locValue.latitude
        longitude = locValue.longitude
       
        write(key: "lat", value: latitude)
        write(key: "lng", value: longitude)

        //Add marker on Location
        addMarkerOnMap()
        
        // post data
       if (readPost(key:"post") == "yes"){
            let location = DBCommon.shared.fetchData()
            writePost(key: "post", value: "no")
            NetworkCallPostData(username: location.username, email: location.email, lat: String(latitude), lng: String(longitude))
       }
       
    }
    
    // add marker on map
    func addMarkerOnMap() {
        let camera = GMSCameraPosition.camera(withLatitude: latitude, longitude: longitude, zoom: 12.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = "Location"
        marker.icon = UIImage(named:"iconLocation.png")
        marker.map = mapView
        
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func NetworkCallPostData(username:String, email:String, lat:String, lng:String){
        
        let parameters = ["username": username, "email": email, "lat": lat, "lng": lng] as [String : Any]

        let url = URL(string: postData )!

        
        ApiService.callPost(url: url, params: parameters, finish: finishPost)

    }
    
    func finishPost (message:String, data:Data?) -> Void
    {
       
    }
    
    
    @IBAction func btnShowAllUsersOnMapClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "moveToMap", sender: self)
        
    }
   
    @IBAction func btnShowAllPointsClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "moveToPositions", sender: self)

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
    
    func readPost(key:String)->String{
        let preferences = UserDefaults.standard
        let key = key
        if preferences.object(forKey: key) == nil {
            //  Doesn't exist
            return ""
        } else {
            let value = preferences.string(forKey: key)
            return value!
        }
    }
    func write(key:String, value:Double){
        let preferences = UserDefaults.standard
        
        let value = value
        let key = key
        preferences.set(value, forKey: key)
    }
    func writePost(key:String, value:String){
        let preferences = UserDefaults.standard
        
        let value = value
        let key = key
        preferences.set(value, forKey: key)
    }
    

}
