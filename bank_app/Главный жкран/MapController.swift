import UIKit
import MapKit
import Contacts

class MapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    
    var mapVw: MKMapView!
    let locationManager = CLLocationManager()
    
    var regionHasBeenCentered = false
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        
        if !regionHasBeenCentered {
            let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            let userLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            let region: MKCoordinateRegion = MKCoordinateRegion(center: userLocation, span: span)
            
            mapVw.setRegion(region, animated: true)
            regionHasBeenCentered = true //set region centred to true - map will not update loction constantly, which would effetively lock the location in place nad not allow scrolling, so once the user location updated the first time, it is set and the map can be moved
        }
        
        self.mapVw.showsUserLocation = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Карта отделений банка"
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
        setupMapView()
        
        let bank1 = Capital(title: "Отделение №1", coordinate: CLLocationCoordinate2D(latitude: 53.946420, longitude: 27.698773), info: "")
        let bank2 = Capital(title: "Отделение №2", coordinate: CLLocationCoordinate2D(latitude: 53.947007, longitude: 27.696674), info: "")
        let bank3 = Capital(title: "Отделение №3", coordinate: CLLocationCoordinate2D(latitude: 53.946104, longitude: 27.699058), info: "")
        let bank4 = Capital(title: "Отделение №4", coordinate: CLLocationCoordinate2D(latitude: 53.949107, longitude: 27.698077), info: "")
        
        mapVw.addAnnotation(bank1)
        mapVw.addAnnotation(bank2)
        mapVw.addAnnotation(bank3)
        mapVw.addAnnotation(bank4)
    }
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        let identifier = "Capital"
        
        if annotation.isKind(of: Capital.self) {
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
            
            if annotationView == nil {
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView!.canShowCallout = true
            } else {
                annotationView!.annotation = annotation
            }
            
            return annotationView
        }
        
        return nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setupMapView() {
        mapVw = MKMapView()
        
        mapVw.delegate = self
        
        
        let leftMargin:CGFloat = 0
        let topMargin:CGFloat = 0
        let mapWidth:CGFloat = view.frame.size.width
        let mapHeight:CGFloat = view.frame.size.height
        
        mapVw.frame = CGRect(x: leftMargin, y: topMargin, width: mapWidth, height: mapHeight)
        
        let noLocation = self.mapVw.userLocation.coordinate
        let span:MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let pinLocation = MKCoordinateRegion(center: noLocation, span: span)
        
        mapVw.setRegion(pinLocation, animated: true)
        print(pinLocation)
        print(noLocation)
        
        //setup long press gesture
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.addAnnotation(_:)))
        self.mapVw.addGestureRecognizer(longPress)
        
        
        
        view.addSubview(mapVw)
    }
    
    //add annotation
    @objc func addAnnotation(_ gestureRecognizer:UIGestureRecognizer) {
        if gestureRecognizer.state != UIGestureRecognizer.State.began {
            return
        }
        
        let touchPoint = gestureRecognizer.location(in: self.mapVw)
        let newCoordinates = self.mapVw.convert(touchPoint, toCoordinateFrom: self.mapVw)
        
        let annotation = MKPointAnnotation()
        
        annotation.coordinate = newCoordinates
        annotation.title = "Virtual Location"
        annotation.subtitle = "Dropped Pin"
        
        self.mapVw.removeAnnotations(mapVw.annotations)//remove previous pin
        self.mapVw.removeAnnotation(annotation)
        
        //create circle attributes
        let cent = newCoordinates
        let rad: Double = 500
        let circle = MKCircle(center: cent, radius: rad)
        
        self.mapVw.addAnnotation(annotation)
        
        self.mapVw.removeOverlays(self.mapVw.overlays)//remove previous circle
        self.mapVw.addOverlay(circle)
        
        print(newCoordinates)
        print(circle)
    }
    
    
    //circle overlay function
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay.isKind(of: MKCircle.self){
            let circleRenderer = MKCircleRenderer(overlay: overlay)
            circleRenderer.fillColor = UIColor.blue.withAlphaComponent(0.05)
            circleRenderer.strokeColor = UIColor.blue
            circleRenderer.lineWidth = 0.5
            
            return circleRenderer
        }
        self.mapVw.removeOverlays(overlay as! [MKCircle])
        print(overlay)
        return MKOverlayRenderer(overlay: overlay)
    }
    
    
}

class Capital: NSObject, MKAnnotation {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(title: String, coordinate: CLLocationCoordinate2D, info: String) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
    }
}
