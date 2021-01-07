//
//  ViewController.swift
//  Vicara_Sample_App
//
//  Created by Neha Chaudhary on 06/01/21.
//  Copyright © 2021 Neha Chaudhary. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var lblLocation : UILabel!
    let viewModel = VCViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.fetchAddress), name: Notification.Name("NotificationIdentifier"), object: nil)

    }
    
    @objc func fetchAddress() {
        
        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: currentLocation?.latitude ?? 0, longitude: currentLocation?.longitude ?? 0)
        geoCoder.reverseGeocodeLocation(location, completionHandler:
            {
                placemarks, error -> Void in

                // Place details
                guard let placeMark = placemarks?.first else { return }

                var address = ""
                // Location name
                if let locationName = placeMark.location {
                    print(locationName)
                }
                // Street address
                if let street = placeMark.thoroughfare {
                    address = street
                    print(street)
                }
                // City
                if let city = placeMark.subAdministrativeArea {
                    address += ", " + city
                    print(city)
                }
                // Zip code
                if let zip = placeMark.isoCountryCode {
                    address += ", " + zip
                    print(zip)
                }
                // Country
                if let country = placeMark.country {
                    address += ", " + country
                    print(country)
                }
                
                self.lblLocation.text = "\(address)"
                
                // if currentlocation is home location , sending coordinates to server
                if currentLocation == homeLocation {
                    DispatchQueue.global(qos: .background).async {
                        self.viewModel.sendLocationToServer()
                    }
                }
        })
    }
    
   
}
