//
//  MapViewController.swift
//  Foodie
//
//  Created by Mahmoud Alaa on 06/07/2024.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!{
        didSet{
            mapView.showsCompass = true
            mapView.showsScale = true
            mapView.showsTraffic = true
        }
    }
    var restaurant = Restaurant()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configer(location: restaurant.location)
        mapView.delegate = self
    }
    
    func configer(location: String){
       
       let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(location, completionHandler: { placemarks ,error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                
                if let location = placemark.location{
                    annotation.coordinate = location.coordinate
                    
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                    
                    let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 3000)
                    self.mapView.setCameraZoomRange(zoomRange, animated: true)
                }
            }
        })
    }
}

extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
      
        let identifier = "MyMarker"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        var annotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        annotationView?.glyphText = "🤩"
        annotationView?.markerTintColor = UIColor.red
//        annotationView?.glyphImage = UIImage(systemName: "arrowtriangle.down.circle")
        return annotationView
    }
}
