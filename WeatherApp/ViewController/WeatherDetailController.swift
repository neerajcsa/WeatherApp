//
//  WeatherDetailController.swift
//  WeatherApp
//
//  Created by Neeraj Pandey on 25/02/22.
//

import UIKit

class WeatherDetailController: UIViewController {

    @IBOutlet weak var lblMainWeather : UILabel!
    @IBOutlet weak var lblMainWeatherDesc : UILabel!
    @IBOutlet weak var lblTemp : UILabel!
    @IBOutlet weak var lblFeelsLike : UILabel!
    @IBOutlet weak var lblHumidity : UILabel!
    @IBOutlet weak var lblWindSpeed : UILabel!
    
    var weatherList : WeatherList?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureWeatherDetailsView(weatherList: weatherList)
    }
    
    private func configureWeatherDetailsView(weatherList : WeatherList?) {
        lblTemp.text = "\(Int(weatherList?.temp ?? 0.0))°"
        lblMainWeather.text = weatherList?.weather.first?.main
        lblMainWeatherDesc.text = weatherList?.weather.first?.description
        lblFeelsLike.text = "\(weatherList?.feels_like ?? 0.0)°"
        lblHumidity.text = "\(weatherList?.humidity ?? 0)%"
        lblWindSpeed.text = "\(weatherList?.wind_speed ?? 0.0)"
    }
    

}
