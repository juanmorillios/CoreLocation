//
//  ViewController.swift
//  CoreLocation
//
//  Created by Juan Morillo on 22/10/16.
//  Copyright © 2016 Juan Morillo. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
  
  let location = CLLocationManager()
  
  @IBOutlet weak var showLocalitationLabel: UILabel!
  @IBOutlet weak var imageLocalizacion: UIImageView!
  
  
  override func viewDidLoad() {
   super.viewDidLoad()
   
    showLocalitationLabel.text = "Aqui se muestra la información de la posicion geográfica."
  }

 
  @IBAction func informationAppBtnPressed(_ sender: UIButton) {
    
    let alert = UIAlertController(title: "Información sobre My Location", message: "Esta aplicación le permite obtener en cada momento la información de la localización en la zona que se encuentre", preferredStyle: UIAlertControllerStyle.alert)
    
    let okAction = UIAlertAction(title: "Aceptar", style: UIAlertActionStyle.default, handler: nil)
    
   
    alert.addAction(okAction)
    
    present(alert, animated: true, completion: nil)
    
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let currentLocation = locations.last
    showLocalitationLabel.text = "\(currentLocation!)"
    print("\(currentLocation)")
  }
  
  func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    showLocalitationLabel.text = "Error, localitation fail"
    print("Error: \(error)")
  }
 
  @IBAction func showLocation(_ sender: UIButton) {
    
    let status = CLLocationManager.authorizationStatus()
    
    if status == .notDetermined {
    
      location.requestWhenInUseAuthorization()
      return
    }
    
    if status == .denied || status == .restricted {
    
      let alerta = UIAlertController(title: "Location Services Disable", message: "Please Enable Location Services in Setting", preferredStyle: UIAlertControllerStyle.actionSheet)
      let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
      
      alerta.addAction(okAction)
      
      present(alerta, animated:true, completion: nil)
      return
    }
    
    location.delegate = self
    location.startUpdatingLocation()
  }
}

