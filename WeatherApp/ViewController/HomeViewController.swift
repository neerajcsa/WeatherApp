//
//  ViewController.swift
//  WeatherApp
//
//  Created by Neeraj Pandey on 25/02/22.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    
    @IBOutlet weak var textField : UITextField!
    @IBOutlet weak var lookupBtn : UIButton!
    
    var placemark : CLPlacemark?
    lazy var geoCoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Home"
        
        configureHomeViewController()
    }

    private func configureHomeViewController() {
        lookupBtn.layer.cornerRadius = 10
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "weather_list" {
            let destination = segue.destination as! WeatherListController
            destination.placemark = self.placemark
        }
    }
    
    
    @IBAction func onLookupBtnClick(sender : UIButton) {
        let cityName = self.textField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        getAllPlacesName(from: cityName ?? "", completion: {[weak self] (places, error) in
            guard let self = self else { return }
            if error == nil {
                guard let places = places else {
                    self.displayErrorController()
                    return
                }
                self.placemark = places.first
                self.performSegue(withIdentifier: "weather_list", sender: self)
            } else {
                self.displayErrorController()
            }

        })
    }

    private func displayErrorController() {
        let alert = UIAlertController(title: "WeatherApp", message: "Please enter valid City Name.", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        
        self.present(alert, animated: true)
    }
    
    private func getAllPlacesName(from cityName : String, completion : @escaping ([CLPlacemark]?,Error?)-> Void) {
         geoCoder.geocodeAddressString(cityName) {(places, error) in
             completion(places,error)
         }
     }
    
}



