//
//  CinemaViewController.swift
//  SeSacTMDBProject
//
//  Created by 나지운 on 2022/08/11.
//

import UIKit
import MapKit
import CoreLocation

class CinemaViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let cinemaList = TheaterList().mapAnnotations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        
        let center = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270)
        setRegionAndAnnotation(center: center, title: "청년취업사관학교 영등포 캠퍼스")

        navigationBar()
    }
    
    func setRegionAndAnnotation(center: CLLocationCoordinate2D, title: String) {
        
        // 지도 중심 기반으로 보여질 범위 설정
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500)
        
        mapView.setRegion(region, animated: true)
        
        for cinema in self.cinemaList {
            let center = CLLocationCoordinate2D(latitude: cinema.latitude, longitude: cinema.longitude)
            self.setAnnotation(center: center, title: cinema.location)
        }
        
       setAnnotation(center: center, title: title)
    }
    
    func setAnnotation(center: CLLocationCoordinate2D, title: String) {
        let annotation =  MKPointAnnotation()
        
        annotation.coordinate = center
        annotation.title = title
        
        mapView.addAnnotation(annotation)
    }
    
    func navigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "detail", style: .plain, target: self, action: #selector(detailButtonClicked))
    }
    
    @objc func detailButtonClicked() {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "메가박스", style: .default, handler: {_ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            for cinema in self.cinemaList.filter({$0.type == "메가박스"}) {
                let center = CLLocationCoordinate2D(latitude: cinema.latitude, longitude: cinema.longitude)
                self.setAnnotation(center: center, title: cinema.location)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "롯데시네마", style: .default, handler: {_ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            for cinema in self.cinemaList.filter({$0.type == "롯데시네마"}) {
                let center = CLLocationCoordinate2D(latitude: cinema.latitude, longitude: cinema.longitude)
                self.setAnnotation(center: center, title: cinema.location)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "CGV", style: .default, handler: {_ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            for cinema in self.cinemaList.filter({$0.type == "CGV"}) {
                let center = CLLocationCoordinate2D(latitude: cinema.latitude, longitude: cinema.longitude)
                self.setAnnotation(center: center, title: cinema.location)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "전체보기", style: .default, handler: {_ in
            self.mapView.removeAnnotations(self.mapView.annotations)
            for cinema in self.cinemaList {
                let center = CLLocationCoordinate2D(latitude: cinema.latitude, longitude: cinema.longitude)
                self.setAnnotation(center: center, title: cinema.location)
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true)
    }
}

extension CinemaViewController {
    func checkUserDeviceLocationServiceAuthorization() {
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }
        
        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼ㅏ져 있어")
            showRequestLocationServiceAlert()
        }
    }
    
    func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {
        switch authorizationStatus {
        case .notDetermined:
            print("NOT Determinded")
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            
        case .restricted, .denied:
            showRequestLocationServiceAlert()
        case .authorizedWhenInUse:
            print("When In Use")
            locationManager.startUpdatingLocation()
        default: print("DEFAULT")
        }
    }
    
    func showRequestLocationServiceAlert() {
        let requestLocationServiceAlert = UIAlertController(title: "위치정보 이용", message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정>개인정보 보호'에서 위치 서비스를 켜주세요.", preferredStyle: .alert)
        let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
            
            if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(appSetting)
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .default)
        requestLocationServiceAlert.addAction(cancel)
        requestLocationServiceAlert.addAction(goSetting)
        
        present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}

extension CinemaViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("🌱")
        print(#function, locations)
        
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate, title: "나의 위치")
        }
        
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("🍿")
        print(#function)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        print("⭐️")
        checkUserDeviceLocationServiceAuthorization()
    }
}
