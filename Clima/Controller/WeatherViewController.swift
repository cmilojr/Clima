//
//  ViewController.swift
//  Clima
//
//  Created by Camilo Jiménez on 6/12/19.
//  Copyright © 2019 App Brewery. All rights reserved.
//


import UIKit
import CoreLocation

class WeatherViewController: UIViewController{
    // MARK: - Initialization
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var inspirationalQuote: UILabel!
    
    var weatherMGR = WeatherManager()
    var quoteMGR = RandomQuote()
    let locationManager:CLLocationManager! = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 1000
        
        quoteMGR.delegate = self
        searchTextField.delegate = self
        weatherMGR.delegate = self
        newQuote()
    }

}

// MARK: - WeatherManagerDelegate
extension WeatherViewController: WeatherManagerDelegate{
    func didUpdateWeather(_ wheatherManager: WeatherManager, weather: WeatherModel) {
        
        DispatchQueue.main.async {
            self.temperatureLabel.text = String(weather.tempDouble)
            if #available(iOS 13.0, *) {
                self.conditionImageView.image = UIImage(systemName: weather.conditionTime)
            } else {
                // Fallback on earlier versions
            }
            self.cityLabel.text = weather.city
        }
    }
    func didFailWithDeal(_ error: Error) {
        print(error.localizedDescription)
    }
}

// MARK: - UITexFieldDelegate
extension WeatherViewController: UITextFieldDelegate{
    @IBAction func search(_ sender: UIButton) {
        searchTextField.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" || Int(textField.text!) == nil{
            return true
        } else {
            textField.placeholder = "Try again"
            return false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherMGR.fetchWeather(city: city)
        }
        searchTextField.text = ""
    }
}

// MARK: - CLLocationManagerDelegate
extension WeatherViewController: CLLocationManagerDelegate {
    @IBAction func actualLocation(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("location error is = \(error.localizedDescription)")
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let latitude = location.coordinate.latitude
            let longitude = location.coordinate.longitude
            weatherMGR.fetchWeather(latitud: latitude, longitud: longitude)
            newQuote()
        }
    }
}

extension WeatherViewController: QuoteManagerDelegate {
    func didQuoteUpdate(_ quoteManager: RandomQuote, quote: String) {
        DispatchQueue.main.async {
            self.inspirationalQuote.text = quote
        }
    }
    
    func didFailDeal(_ error: Error) {
        print(error.localizedDescription)
    }
    func newQuote(){
        quoteMGR.performRequest()
    }
}
