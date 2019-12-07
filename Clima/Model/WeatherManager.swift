//
//  WeatherManager.swift
//  Clima
//
//  Created by Camilo Jiménez on 6/12/19.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation
import HPOpenWeather
import CoreLocation

struct WeatherManager {
    // MARK: - Declarations
    //let weatherURL: String = "https://api.openweathermap.org/data/2.5/weather?appid=51b048e2b9019609f3b728766b906b92&units=metric"
    //let weatherImage: String = "https://openweathermap.org/img/wn/10d@2x.png"
    var api = HPOpenWeather(apiKey: "51b048e2b9019609f3b728766b906b92")
    var delegate: WeatherManagerDelegate?
    
    // MARK: - Functions
    
    //look up city by the name
    func fetchWeather(city: String) {
        api.requestCurrentWeather(with: CityNameRequest(city, countryCode: nil)) { (current, error) in
            guard let current = current, error == nil else {
                // Handle error here
                return
            }
            let temperature = current.main.temperature
            let cityName = current.city.name
            let id = current.condition.id
            let weatherModel = WeatherModel(conditon: id, city: cityName, temperature: temperature)
            self.delegate?.didUpdateWeather(self, weather: weatherModel)
        }
    }
    
    //look up city by coordenades
    func fetchWeather(latitud: Double, longitud: Double){
        let localitation = CLLocationCoordinate2D(latitude: latitud,longitude: longitud)
        let locationRequest = LocationRequest(localitation)
        
        api.requestCurrentWeather(with: locationRequest) { (current, error) in
            guard let current = current, error == nil else {
                // Handle error here
                return
            }
            let temperature = current.main.temperature
            print(temperature)
            let cityName = current.city.name
            let id = current.condition.id
            let weatherModel = WeatherModel(conditon: id, city: cityName, temperature: temperature)
            self.delegate?.didUpdateWeather(self, weather: weatherModel)
        }
    }
}



protocol WeatherManagerDelegate {
    func didUpdateWeather(_ wheatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithDeal(_ error: Error)
}
