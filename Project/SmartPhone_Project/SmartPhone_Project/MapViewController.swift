//
//  MapViewController.swift
//  SmartPhone_Project
//
//  Created by kpugame on 2017. 6. 10..
//  Copyright © 2017년 KPUGame. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var posts = NSMutableArray()
    
    var initialLocation = CLLocation()
    var geocoder = CLGeocoder()
    var careAddr: String = ""
    var cares = [Care]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        geoCode()
        
    }

    func geoCode() {
     
        geocoder.geocodeAddressString(careAddr) { (placemarks, error) in
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    
    func loadInitialData() {

    }
    
    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
            
        } else {
            var location: CLLocation?
            
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }
            
            if let location = location {
                let coordinate = location.coordinate
                initialLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
                print(coordinate)
                
                centerMapOnLocation(location: initialLocation)
                
                mapView.delegate = self
                
                for post in posts {
                    let careNm = (post as AnyObject).value(forKey: "careNm") as! NSString as String
                    let careAddr = (post as AnyObject).value(forKey: "careAddr") as! NSString as String
                    //let XPos = (post as AnyObject).value(forKey: "XPos") as! NSString as String
                    //let YPos = (post as AnyObject).value(forKey: "YPos") as! NSString as String
                    let lat = (coordinate.latitude)
                    let lon = (coordinate.longitude)
                    let care = Care(title: careNm, locationName: careAddr, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
                    cares.append(care)
                }
                
                mapView.addAnnotations(cares)
                
            } else {
                print("없음")
            }
        }
    }
    
    let regionRadius: CLLocationDistance = 1000
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? Care {
            let identifier = "pin"
            var view: MKPinAnnotationView
            // 2. 코드는 새로 생성하기 전에 재사용 가능한 주석 뷰를 사용할 수 있는지 먼저 확인
            if let dequeueView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                dequeueView.annotation = annotation
                view = dequeueView
            } else {
                view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                view.canShowCallout = true
                view.calloutOffset = CGPoint(x: -5, y: 5)
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)as UIView
            }
            
            return view
        }
        return nil
    }
    
    // 사용자가 지도 annotation pin을 탭하면 설명 선에 info button 표시
    // 사용자가 info button을 탭하면 mapView(_ : annotationView: calloutAccessoryControlTapped :) 호출
    // 참조하는 Artwork 객체에서 관련 MKMapItem을 만들고
    // 지도 항목에서 openInMapWithLaunchOptions를 호출하여 지도 앱 시작
    // launchOptions에 사전을 전달하고 있음. 이렇게 하면 몇 가지 옵션을 지정할 수 있음
    // 여기서 DirecionModeKeys는 Driving으로 설정. 이렇게 하면 지도 앱이 사용자의 현재 위치에서 이 핀까지의 운전 경로를 표시
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! Care
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }


}
