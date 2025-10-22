//
//  LocationManager.swift
//  DrivingLog
//
//  Created by HAVISH PRATTIPATI on 5/26/23.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    
    static let shared = LocationManager()
    
    let manager = CLLocationManager()
    var completion: ((CLLocation) -> Void)?
    var locationAuth = false
    public static var location: CLLocation?
    
    
    public func getUserLocation(completion: @escaping (CLLocation) -> Void) {
        self.completion = completion
        manager.requestWhenInUseAuthorization()
        manager.allowsBackgroundLocationUpdates = true
        manager.delegate = self
        manager.distanceFilter = 50
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else{
            return
        }
        
        SessionClass.locationCoordinates.append(location.coordinate)
        print(SessionClass.locationCoordinates.count)
        completion?(location)
        
    }
    
    
}
