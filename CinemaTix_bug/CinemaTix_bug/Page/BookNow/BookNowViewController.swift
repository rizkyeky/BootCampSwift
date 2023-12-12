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
    
    var movie: MovieModel?
    private var currLocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bookViewModel?.movie = movie

        navBar.isHidden = false
        navBar.backgroundColor = .systemBackground
        navBar.title.textColor = .label
        navBar.title.text = bookViewModel?.movie?.title ?? "Book"
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        changeLocButton.setAnimateBounce()
        changeLocButton.makeCornerRadius(8)
        changeLocButton.addAction(UIAction { _ in
            let mapVC = MapViewController()
            mapVC.currLocation = self.currLocation
            self.navigationController?.pushViewController(mapVC, animated: true)
        }, for: .touchUpInside)
        
        locationLabel.skeletonTextNumberOfLines = .init(integerLiteral: 2)
        locationLabel.showAnimatedSkeleton()
        
        cinemaStack.spacing = 8
        cinemaStack.distribution = .fillProportionally
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
//                make.height.equalTo(200)
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
            
            self.currLocation = location
            
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
        backgroundColor = .secondarySystemBackground
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
        
        let stackScheduleSection = UIStackView()
        addSubview(stackScheduleSection)
        stackScheduleSection.snp.makeConstraints { make in
            make.left.equalTo(self).offset(16)
            make.right.equalTo(self).inset(16)
            make.top.equalTo(cinemaLabel.snp.bottom).offset(8)
            make.bottom.equalTo(self).inset(16)
        }
        
        stackScheduleSection.axis = .vertical
        stackScheduleSection.spacing = 4.0
        stackScheduleSection.alignment = .fill
        stackScheduleSection.distribution = .fillEqually
        
        let scheduleSections = [
            ScheduleSection(name: "Regular | Rp50.000 | Audi 6"),
            ScheduleSection(name: "VVIP | Rp200.000 | Audi 7"),
        ]
        for sec in scheduleSections {
            stackScheduleSection.addArrangedSubview(sec)
        }
    }
}

class ScheduleSection: UIView {
    
    var name: String
    
    init(name: String) {
        self.name = name
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let typeLabel = UILabel()
        typeLabel.text = name
        typeLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        typeLabel.textColor = .lightGray
        
        addSubview(typeLabel)
        typeLabel.snp.makeConstraints { make in
            make.top.left.equalTo(self)
        }
        
        let scheduleStack = UIStackView()
        addSubview(scheduleStack)
        scheduleStack.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(typeLabel.snp.bottom).offset(8)
            make.left.right.equalTo(self)
        }
        
        scheduleStack.spacing = 4.0
        scheduleStack.alignment = .fill
        scheduleStack.distribution = .fillEqually
        
        let schedules = [
            ScheduleBox(time: "15:00", seats: "200/300"),
            ScheduleBox(time: "16:30", seats: "100/300"),
            ScheduleBox(time: "17:30", seats: "80/300"),
            ScheduleBox(time: "18:00", seats: "50/300")
        ]
        for sch in schedules {
            scheduleStack.addArrangedSubview(sch)
        }
    }
}

class ScheduleBox: UIView {
    
    var time: String
    var seats: String
    
    init(time: String, seats: String) {
        self.time = time
        self.seats = time
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        makeCornerRadius(8)
        addBorderLine(width: 1, color: .accent)
        snp.makeConstraints { make in
//            make.height.equalTo(24)
//            make.width.equalTo(90)
        }
        
        let timeLabel = UILabel()
        timeLabel.text = time
        addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self)
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
