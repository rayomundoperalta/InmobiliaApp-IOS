//
//  MapViewController.swift
//  InmobiliaApp-IOS
//
//  Created by Raymundo Peralta on 12/29/16.
//  Copyright © 2016 Industrias Peta. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapa: MKMapView!
    
    var localizador:CLLocationManager?
    var count:Int = 0
    var latitud:String  = ""
    var longitud:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Inicia Map View Controler")
        self.localizador = CLLocationManager()
        self.localizador!.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        self.localizador!.delegate = self
        let autorizado = CLLocationManager.authorizationStatus()
        if autorizado == CLAuthorizationStatus.NotDetermined {
            self.localizador!.requestWhenInUseAuthorization()
        }
        self.localizador!.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        self.localizador!.stopUpdatingLocation()
        let ac = UIAlertController(title: "Error", message: "No se pueden obtener lecturas GPS", preferredStyle: .Alert)
        let ab = UIAlertAction (title: "so sad ...", style: .Default, handler: nil)
        ac.addAction(ab)
        self.presentViewController(ac, animated: true, completion: nil)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let ubicacion = locations.last
        self.latitud  = "\(ubicacion!.coordinate.latitude)"
        self.longitud = "\(ubicacion!.coordinate.longitude)"
        self.count += 1
        print ("self.count \(self.count)")
        print("Lat: " + self.latitud)
        print("Lon: " + self.longitud)
        self.colocarMapa(ubicacion!)
    }
    
    func colocarMapa(ubicacion:CLLocation){
        let laCoordenada = ubicacion.coordinate
        let region = MKCoordinateRegionMakeWithDistance(laCoordenada, 200, 200)
        self.mapa.setRegion(region, animated: true)
        let losPines = self.mapa.annotations
        self.mapa.removeAnnotations(losPines)
        let elPin = ElPin(title: "Ud. Está aqui", subtitle: "", coordinate: laCoordenada)
        self.mapa.addAnnotation(elPin)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
