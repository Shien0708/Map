//
//  ViewController.swift
//  Map
//
//  Created by 方仕賢 on 2022/3/14.
//

import UIKit
import MapKit
class ViewController: UIViewController {
    @IBOutlet var longitudeTextFields: [UITextField]!
    
    
    @IBOutlet var latitudeTextFields: [UITextField]!
    
    @IBOutlet var calculateButtons: [UIButton]!
    @IBOutlet weak var coordinateView: UIView!
    
    @IBOutlet weak var markView: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var subtitleTextView: UITextField!
    @IBOutlet weak var changeViewButton: UIButton!
    @IBOutlet weak var settingView: UIView!
    
    let mapView = MKMapView(frame: CGRect(x: 0, y: 0, width: 440, height: 1000))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayMap(latitude: 25.033642, longitude: 121.564740)
        changeView()
    }
    
    func displayMap(latitude: Float, longitude: Float){
        
        mapView.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude)), latitudinalMeters: 1000, longitudinalMeters: 1000)
        view.addSubview(mapView)
        
        let taipei101Annotation = MKPointAnnotation()
        taipei101Annotation.title = "台北 101"
        taipei101Annotation.subtitle = "台灣最高建築"
        taipei101Annotation.coordinate = CLLocationCoordinate2D(latitude: 25.033642, longitude: 121.564740)
        mapView.addAnnotation(taipei101Annotation)
        view.sendSubviewToBack(mapView)
    }
    
    //mark annotation
    
    func mark(title: String, subtitle: String){
        let annotation = MKPointAnnotation()
        annotation.title = title
        annotation.subtitle = subtitle
        annotation.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitudeTextFields[0].text!)!, longitude: CLLocationDegrees(longitudeTextFields[0].text!)!)
        mapView.addAnnotation(annotation)
    }
    
   
    @IBAction func setAnnotationTitle(_ sender: Any) {
        if titleTextField.text != "" && longitudeTextFields[0].text! != "" && latitudeTextFields[0].text! != "" {
            mark(title: titleTextField.text!, subtitle: subtitleTextView.text! )
        } else {
            let alert = UIAlertController(title: "Set the Coordinate!", message: "You haven't set any coordinate", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func mark(_ sender: Any) {
        markView.isHidden = false
        coordinateView.isHidden = true
    }
    
    @IBAction func closeMarkView(_ sender: Any) {
        markView.isHidden = true
    }
    
    //unit calculation
    
    @IBAction func calculate(_ sender: UIButton) {
        var loDegree: Int = 0
        var loMinute: Float = 0
        var loSecond: Float = 0
        var laDegree: Int = 0
        var laMinute: Float = 0
        var laSecond: Float = 0
        
            switch sender {
        case calculateButtons[0]:
                
                if longitudeTextFields[0].text != "" && latitudeTextFields[0].text != "" {
                loDegree = Int(Float(longitudeTextFields[0].text!)!)
                loMinute = (Float(longitudeTextFields[0].text!)! - Float(loDegree)) * 60
                loSecond = (loMinute-Float(Int(loMinute)))*60
                
                longitudeTextFields[1].text = String(loDegree)
                longitudeTextFields[2].text = String(loMinute)
                longitudeTextFields[3].text = String(loDegree)
                longitudeTextFields[4].text = String(Int(loMinute))
                longitudeTextFields[5].text = String(loSecond)
                
                laDegree = Int(Float(latitudeTextFields[0].text!)!)
                laMinute = (Float(latitudeTextFields[0].text!)! - Float(laDegree)) * 60
                laSecond = (laMinute-Float(Int(laMinute)))*60
                
                latitudeTextFields[1].text = String(laDegree)
                latitudeTextFields[2].text = String(laMinute)
                latitudeTextFields[3].text = String(laDegree)
                latitudeTextFields[4].text = String(Int(laMinute))
                latitudeTextFields[5].text = String(laSecond)
                
                displayMap(latitude: Float(latitudeTextFields[0].text!)!, longitude: Float(longitudeTextFields[0].text!)!)
            }
                
        case calculateButtons[1]:
                if longitudeTextFields[1].text != "" && latitudeTextFields[1].text != "" {
                    
                loMinute = Float(longitudeTextFields[2].text!) ?? 0
                loDegree = Int(longitudeTextFields[1].text!)!
                loSecond = loMinute - Float(Int(loMinute)) * 60
                
                longitudeTextFields[0].text = String(Float(loDegree)+loMinute/60)
                longitudeTextFields[3].text = String(loDegree)
                longitudeTextFields[4].text = String(Int(loMinute))
                longitudeTextFields[5].text = String(loSecond)
                
                laMinute = Float(latitudeTextFields[2].text!)!
                laDegree = Int(latitudeTextFields[1].text!)!
                laSecond = laMinute - Float(Int(laMinute)) * 60
                
                latitudeTextFields[0].text = String(Float(laDegree)+laMinute/60)
                latitudeTextFields[3].text = String(laDegree)
                latitudeTextFields[4].text = String(Int(laMinute))
                latitudeTextFields[5].text = String(laSecond)
                
                displayMap(latitude: Float(latitudeTextFields[0].text!)!, longitude: Float(longitudeTextFields[0].text!)!)
            }
            
        default:
                if longitudeTextFields[2].text != "" && latitudeTextFields[2].text != "" {
                    
                    loSecond = Float(longitudeTextFields[5].text!)!
                    loMinute = Float(longitudeTextFields[4].text!)!
                    loDegree = Int(longitudeTextFields[3].text!)!
                
                longitudeTextFields[0].text = String(Float(loDegree)+(loMinute+loSecond/60)/60)
                longitudeTextFields[1].text = String(loDegree)
                longitudeTextFields[2].text = String(loMinute+loSecond/60)
                
                    laSecond = Float(latitudeTextFields[5].text!)!
                    laMinute = Float(latitudeTextFields[4].text!)!
                    laDegree = Int(latitudeTextFields[3].text!)!
                
                    latitudeTextFields[0].text = String(Float(laDegree)+(laMinute+laSecond/60)/60)
                    latitudeTextFields[1].text = String(laDegree)
                    latitudeTextFields[2].text = String(laMinute+laSecond/60)
                
                displayMap(latitude: Float(latitudeTextFields[0].text!)!, longitude: Float(longitudeTextFields[0].text!)!)
            }
        }
    }
    
    
    @IBAction func clear(_ sender: Any) {
        
        for i in 0...longitudeTextFields.count-1 {
            longitudeTextFields[i].text = ""
            latitudeTextFields[i].text = ""
        }
    }
    
    @IBAction func setCoordinate(_ sender: Any) {
        coordinateView.isHidden = false
        markView.isHidden = true
    }
    
    @IBAction func closeView(_ sender: Any) {
        coordinateView.isHidden = true
    }
    
    func changeView(){
        var actions = [UIAction]()
        
        let viewNames = ["Satellite", "Hybrid", "Satellite Fly Over", "Muted Standard", "Standard"]
        let viewTypes = [MKMapType.satellite, MKMapType.hybrid, MKMapType.satelliteFlyover, MKMapType.mutedStandard, MKMapType.standard]
        
        
        for i in 0...viewNames.count-1 {
            actions.append(UIAction(title: viewNames[i], handler: { action in
                self.mapView.mapType = viewTypes[i]
                self.markView.isHidden = true
                self.coordinateView.isHidden = true
            }))
        }
        changeViewButton.showsMenuAsPrimaryAction = true
        changeViewButton.menu = UIMenu(children: actions)
        
    }
    
    
    
    @IBAction func set(_ sender: Any) {
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.settingView.frame = self.settingView.frame.offsetBy(dx: 190, dy: 0)
        }
        animator.startAnimation()
    }
    
    @IBAction func closeSettingView(_ sender: Any) {
        let animator = UIViewPropertyAnimator(duration: 1, curve: .easeOut) {
            self.settingView.frame = self.settingView.frame.offsetBy(dx: -190, dy: 0)
        }
        animator.startAnimation()
    }
    
}

