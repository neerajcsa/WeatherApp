//
//  WeatherTableCell.swift
//  WeatherApp
//
//  Created by Neeraj Pandey on 25/02/22.
//

import UIKit

class WeatherTableCell: UITableViewCell {
    
    @IBOutlet weak var imgMainWeather : UIImageView!
    @IBOutlet weak var lblMainWeather : UILabel!
    
    @IBOutlet weak var imgTemp : UIImageView!
    @IBOutlet weak var lblTemp : UILabel!
    
    @IBOutlet weak var lblFeelsLike : UILabel!
    @IBOutlet weak var lblHumidity : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        imgTemp.image = nil
        imgMainWeather.image = nil
    }
    
    func configureWeatherListCell(weatherList : WeatherList?) {
        configureTemp(temp: weatherList?.temp)
        configureMainWeather(mainWeather: weatherList?.weather.first)
        configureOtherWeatherInfo(feelsLike: weatherList?.feels_like, humidity: weatherList?.humidity)
    }
    
    private func configureTemp(temp : Double?) {
        guard let tempCelc = temp else {
            return
        }
        
        let tempInCelc = Int(tempCelc)
        lblTemp.text = "\(tempInCelc)°"
        imgTemp.image = UIImage(named: "temp")
    }
        
    private func configureMainWeather(mainWeather : MainWeather?) {
        let imageCode = mainWeather!.icon
        let imageURL = URL(string: Endpoints.weatherImage + "/" + "\(imageCode)@2x.png")
        imgMainWeather.load(url: imageURL!)
        lblMainWeather.text = mainWeather?.main
    }
    
    private func configureOtherWeatherInfo(feelsLike : Double?, humidity : Int?) {
        lblFeelsLike.text = "Feels Like : \(feelsLike ?? 0.0)°"
        lblHumidity.text = "Humidity : \(humidity ?? 0)%"
    }
    
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
