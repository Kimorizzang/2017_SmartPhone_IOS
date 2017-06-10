//
//  Care.swift
//  SmartPhone_Project
//
//  Created by kpugame on 2017. 6. 10..
//  Copyright © 2017년 KPUGame. All rights reserved.
//

import Foundation

import MapKit

// 주소의 주소나 도시 또는 상태 필드를 설정해야할 때 사용할 수 있는
// kABPersonAddressStreetKey와 같은 사전 키 상수가 포함
import AddressBook

class Care: NSObject, MKAnnotation {
    let title: String?
    let locationName: String?
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }
    var subtitle: String? {
        return locationName
    }
    
    func mapItem() -> MKMapItem {
        let addressDictionary = [String(kABPersonAddressStreetKey): subtitle]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDictionary)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        
        return mapItem
    }
}
