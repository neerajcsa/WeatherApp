//
//  WeatherListController.swift
//  WeatherApp
//
//  Created by Neeraj Pandey on 25/02/22.
//

import UIKit
import CoreLocation

class WeatherListController: UIViewController {
    
    @IBOutlet weak var activityIndicator : UIActivityIndicatorView!
    @IBOutlet weak var tableView : UITableView!
    
    var weatherModel : WeatherModel?
    var placemark : CLPlacemark? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableFooterView = UIView.init(frame: .zero)
        
        populateWeatherList()
    }
    
    private func showProgressBar(isShow : Bool) {
        DispatchQueue.main.async {
            if !isShow {
                self.activityIndicator.stopAnimating()
                self.tableView.isHidden = false
                self.activityIndicator.isHidden = true
                self.tableView.reloadData()
            } else {
                self.activityIndicator.startAnimating()
                self.activityIndicator.isHidden = false
                self.tableView.isHidden = true
            }
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "weather_detail" {
            let destination = segue.destination as! WeatherDetailController
            let weatherList = sender as! WeatherList
            destination.weatherList = weatherList
        }
    }
    
    private func populateWeatherList() {
        showProgressBar(isShow: true)
        NetworkManager.shared.getWeatherData(latitude: "\(placemark!.location?.coordinate.latitude ?? 0.0)", longitude: "\(placemark!.location?.coordinate.latitude ?? 0.0)") { (result) in
            
            switch result {
            case .success(let weatherModel) :
                self.weatherModel = weatherModel
            case .failure(let error) :
                print("\(error.localizedDescription)")
            }
            
            DispatchQueue.main.async {
                self.showProgressBar(isShow: false)
            }
        }
    }
    
}

extension WeatherListController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherModel?.hourly.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weather_cell", for: indexPath) as! WeatherTableCell
        
        configureWeatherListTableCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    func configureWeatherListTableCell(cell : WeatherTableCell, indexPath : IndexPath) {
        let weatherList = weatherModel?.hourly[indexPath.row]
        cell.configureWeatherListCell(weatherList: weatherList)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weatherList = weatherModel?.hourly[indexPath.row]
        performSegue(withIdentifier: "weather_detail", sender: weatherList)
    }
}
