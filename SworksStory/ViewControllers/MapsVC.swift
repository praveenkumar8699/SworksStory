//
//  MapsVc.swift
//  SworksStory
//
//  Created by Praveen Kumar on 27/11/20.
//

import UIKit
import MapKit

class MapsVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var order : Order?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        print("viewdidload")
        
    }
    
    private func setUpUI() {
        
        mapView.mapType = .standard
        
        guard let long = order?.location?.long, let lat = order?.location?.lat else { return }
        
        let annotation = MKPointAnnotation()
        annotation.title = order?.address
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        mapView.addAnnotations([annotation])
        
        let location = CLLocation(latitude: lat, longitude: long)
        
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: CLLocationDistance(exactly: 100)!, longitudinalMeters: CLLocationDistance(exactly: 100)!)
        mapView.setRegion(region, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        mapView.showAnnotations(mapView.annotations, animated: true)
        
    }
    
}

extension MapsVC : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
        
    }
    
}
