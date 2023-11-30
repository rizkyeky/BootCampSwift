//
//  BookNowViewController.swift
//  CinemaTix
//
//  Created by Eky on 28/11/23.
//

import UIKit
import CoreLocation
import UIKitLivePreview

class BookNowViewController: BaseViewController {

    private let locationManager = CLLocationManager()
    
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var changeLocButton: UIButton!
    @IBOutlet weak var cinemaStack: UIStackView!
    @IBOutlet weak var dayPicker: DayPicker!
    
    private let bookViewModel = ContainerDI.shared.resolve(BookViewModel.self)
    
    private var movie: MovieModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookViewModel?.movie = movie

        navBar.isHidden = false
        navBar.backgroundColor = .systemBackground
        navBar.title.textColor = .label
        navBar.title.text = "Book"
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        changeLocButton.setAnimateBounce()
        changeLocButton.makeCornerRadius(8)
        
        locationLabel.skeletonTextNumberOfLines = .init(integerLiteral: 2)
        locationLabel.showAnimatedSkeleton()
        
        cinemaStack.spacing = 8
        cinemaStack.distribution = .fillEqually
        cinemaStack.alignment = .top
        
        let cinemaList = [
            CinemaSection(name: "XXI Kota Kasablanka"),
            CinemaSection(name: "CGV Mega Bekasi"),
            CinemaSection(name: "CGV Mall Thamrin"),
//            CinemaSection(name: "XXI Mall of Indonesia")
        ]
        for cin in cinemaList {
            cinemaStack.addArrangedSubview(cin)
            cin.snp.makeConstraints { make in
                make.left.right.equalTo(self.cinemaStack)
                make.height.equalTo(160)
            }
        }
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
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if error != nil {
                    return
                }
                
                if let placemark = placemarks?.first {
                    if let postalCode = placemark.postalCode, let administrativeArea = placemark.administrativeArea, let name = placemark.name, let locality = placemark.locality, let subAdministrativeArea = placemark.subAdministrativeArea, let country = placemark.country  {
                        let text = name+", "+postalCode+", "+locality+", "+subAdministrativeArea+", "+administrativeArea+", "+country
                        DispatchQueue.main.async {
                            self.locationLabel.hideSkeleton()
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

class CinemaSection: UIView {
    
    var name: String
    
    init(name: String) {
        self.name = name
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = .secondarySystemFill
        makeCornerRadius(16)
        
        let cinemaLabel = UILabel()
        cinemaLabel.text = name
        cinemaLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        addSubview(cinemaLabel)
        cinemaLabel.snp.makeConstraints { make in
            make.left.equalTo(self).offset(16)
            make.top.equalTo(self).offset(16)
        }
        
        let distLabel = UILabel()
        distLabel.text = "10km"
        distLabel.textColor = .secondaryLabel
        addSubview(distLabel)
        distLabel.snp.makeConstraints { make in
            make.right.equalTo(self).inset(16)
            make.top.equalTo(self).offset(16)
        }
        
        let boxSchedule = UIView()
        boxSchedule.backgroundColor = .darkGray
        addSubview(boxSchedule)
        boxSchedule.snp.makeConstraints { make in
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self).inset(16)
            make.top.equalTo(cinemaLabel.snp.bottom).offset(16)
            make.bottom.equalTo(self).inset(16)
        }
    }
}

#if DEBUG && canImport(SwiftUI)

import SwiftUI

@available(iOS 13.0, *)
struct BookNowViewController_Preview: PreviewProvider {
    static var previews: some View {
        BookNowViewController()
            .preview()
            .device(.iPhone11)
    }
}

#endif
