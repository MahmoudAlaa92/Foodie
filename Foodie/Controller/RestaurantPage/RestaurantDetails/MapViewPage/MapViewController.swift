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
    
    @IBOutlet weak var directionButton: UIButton!{
        didSet{
            directionButton.layer.cornerRadius = 15
            directionButton.layer.masksToBounds = true
        }
    }
    var restaurant = Restaurant()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configer(location: restaurant.location)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        mapView.delegate = self
        mapView.showsUserLocation = true
        
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled(){
                self.checkAuthrization()
            }else{
                self.showAlert(message: "Please enable location service.")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = UIColor(named: "NavigationBarTitle")
    }
    
    // MARK: - Direction Button Action
    @IBAction func getDirection(_ sender: UIButton) {
        
        if let userLocation = locationManager.location{
            drawDirection(startLocation: userLocation.coordinate, destinationLocation: mapView.centerCoordinate)
            
        }
    }
    
    // MARK: - Draw Direction
    func drawDirection(startLocation: CLLocationCoordinate2D, destinationLocation: CLLocationCoordinate2D){
        
        let startingPlace = MKPlacemark(coordinate: startLocation)
        let destinationPlace = MKPlacemark(coordinate: destinationLocation)
        
        let startItem = MKMapItem(placemark: startingPlace)
        let destinationItem = MKMapItem(placemark: destinationPlace)
        
        
        let request = MKDirections.Request()
        request.source = startItem
        request.destination = destinationItem
        request.transportType = .automobile
//        request.requestsAlternateRoutes = true
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard let respons = response else{
                if let error = error{
                    print("direction Error \(error.localizedDescription)")
                }
                return
            }
            
            for route in respons.routes{
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }

    }
    
    // MARK: - Check Authorization
    func checkAuthrization(){
        switch locationManager.authorizationStatus{
        case .notDetermined:
            locationManager.requestAlwaysAuthorization()
            break
        case .authorizedWhenInUse:
            locationManager.requestAlwaysAuthorization()
            mapView.showsUserLocation = true
            break
        case .authorizedAlways:
            locationManager.startUpdatingLocation()
            mapView.showsUserLocation = true
            break
        case .denied, .restricted:
            showAlert(message: "Please authorize location services.")
        default:
            print("defualt ..")
            break
        }
    }
    
    // MARK: - Alert
    func showAlert(message: String){
        let alert = UIAlertController(
            title: "Alert",
            message: message,
            preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Close", style: .default))
        alert.addAction(UIAlertAction(title: "Setting", style: .default ,handler: { action in
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
        }))
        present(alert ,animated: true)
    }
    

    // MARK: - Configure Map
    func configer(location: String){
       let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(location, completionHandler: { placemarks ,error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                
                // Add Pin on map
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                
                if let location = placemark.location{
                    annotation.coordinate = location.coordinate
                    self.mapView.addAnnotation(annotation)
//                    self.mapView.showAnnotations([annotation], animated: true)
//                    self.mapView.selectAnnotation(annotation, animated: true)
                    
                    let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
                    self.mapView.setRegion(region, animated: true)
//                    let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 3000)
//                    self.mapView.setCameraZoomRange(zoomRange, animated: true)
                }
            }
        })
    }
}

// MARK: - MapKit and Location Manager Delegates

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate{
    
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
    
    // Update location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locations.last else { return }
        
        zoomToUserLocation(locaiton: location)
        locationManager.stopUpdatingLocation()
    }
    
    // Zoom user location
    func zoomToUserLocation(locaiton: CLLocation){
        let region = MKCoordinateRegion(center: locaiton.coordinate, latitudinalMeters: 3000, longitudinalMeters: 3000)
        
        mapView.setRegion(region, animated: true)
    }
    
    // Render
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = .blue
        render.lineWidth = 3.0
        return render
    }
}
