//
//  MapViewController.swift
//  CinemaTix
//
//  Created by Eky on 01/12/23.
//

import UIKit
import MapKit

class MapViewController: BaseViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var currLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navBar.isHidden = false
        navBar.isHasBlurBox = true
        
        mapView.delegate = self
        mapView.showsUserLocation = true
    
        let initialLocation = currLocation ?? CLLocation(latitude: -6.9034495, longitude: 107.6431575)
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: initialLocation.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        
        mapView.setRegion(coordinateRegion, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = initialLocation.coordinate
        annotation.title = "Your Location"
        mapView.addAnnotation(annotation)
    }
}

extension MapViewController: MKMapViewDelegate {
    
}
