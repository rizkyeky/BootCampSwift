//
//  BookNowViewController.swift
//  CinemaTix
//
//  Created by Eky on 28/11/23.
//

import UIKit
import CoreLocation

class BookNowViewController: BaseViewController {

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var changeLocButton: UIButton!
    
    let bookViewModel = BookViewModel()
    
    var movie: MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ContainerDI.shared.register(BookViewModel.self, factory: { _ in return self.bookViewModel
        }).inObjectScope(.container)
        
        bookViewModel.movie = movie

        navBar.isHidden = false
        navBar.backgroundColor = .systemBackground
        navBar.title.textColor = .label
        navBar.title.text = "Book"
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        changeLocButton.setAnimateBounce()
        changeLocButton.makeCornerRadius(8)
    }
}

extension BookNowViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedWhenInUse, .authorizedAlways:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            break
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print("Latitude: \(location.coordinate.latitude), Longitude: \(location.coordinate.longitude)")
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    print("Reverse geocoding failed with error: \(error.localizedDescription)")
                    return
                }
                
                if let placemark = placemarks?.first {
                    if let postalCode = placemark.postalCode, let administrativeArea = placemark.administrativeArea, let name = placemark.name, let locality = placemark.locality, let subAdministrativeArea = placemark.subAdministrativeArea, let country = placemark.country  {
                        let text = name+", "+postalCode+", "+locality+", "+subAdministrativeArea+", "+administrativeArea+", "+country
                        DispatchQueue.main.async {
                            self.locationLabel.text = text
                        }
                    }
                }
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error.localizedDescription)")
    }
}

