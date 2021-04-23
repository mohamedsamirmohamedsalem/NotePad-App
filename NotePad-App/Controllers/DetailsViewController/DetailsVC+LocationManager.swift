//
//  DetailsVC+LocationManager.swift
//  NotePad-App
//
//  Created by mohamed samir on 22/04/2021.
//

import Foundation
import CoreLocation

extension DetailsViewController : CLLocationManagerDelegate {
    
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func getCurrentLocation() -> CLLocation{
        
        // get the user location
        let location: CLLocation = locationManager.location ?? CLLocation()
        location.fetchCityAndCountry { city, country, error in
            guard let city = city, let country = country, error == nil else { return }
            self.taskCity = city
            self.taskCountry = country
            print(city + ", " + country)  // Rio de Janeiro, Brazil
        }
        self.isLocationSelected = true
        return location
        
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func AuthorizeLocation(){
        locationManager.requestWhenInUseAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        // check the permission status
        switch(CLLocationManager.authorizationStatus()) {
        case .authorizedAlways, .authorizedWhenInUse:
            self.location = getCurrentLocation()
            displaySuccessLocationAlert()
        case .restricted, .denied:
            self.displayCancelLAlert()
        case .notDetermined :requestAuthorization()
        default:requestAuthorization()
            
        }
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func requestAuthorization(){
        locationManager.requestWhenInUseAuthorization()
        AuthorizeLocation()
    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    func fetchCityAndCountry(from location: CLLocation, completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            completion(placemarks?.first?.locality,placemarks?.first?.country,error)
        }
    }
    
}

extension TaskListViewController {
    
    func locationInLocations(locations: [CLLocation], closestToLocation location: CLLocation) -> CLLocation? {
        if locations.count == 0 {
            return nil
        }
        
        var closestLocation: CLLocation?
        var smallestDistance: CLLocationDistance?
        
        for location in locations {
            let distance = location.distance(from: location)
            if smallestDistance == nil || distance < smallestDistance! {
                closestLocation = location
                smallestDistance = distance
            }
        }
        
        print("closestLocation: \(closestLocation), distance: \(smallestDistance)")
        return closestLocation
    }
    
    
}
