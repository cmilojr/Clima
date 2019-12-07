//
//  WeatherAPI.swift
//  Clima
//
//  Created by Camilo Jiménez on 8/11/19.
//  Copyright © 2019 Camilo Jiménez. All rights reserved.
//


import Foundation
import HPOpenWeather
import CoreLocation

/*
 
struct WeatherManager {
    
    let weatherURL: String = "https://api.openweathermap.org/data/2.5/weather?appid=51b048e2b9019609f3b728766b906b92&units=metric"
    let weatherImage: String = "https://openweathermap.org/img/wn/10d@2x.png"
    var api = HPOpenWeather(apiKey: "51b048e2b9019609f3b728766b906b92")
    var delegate: WeatherManagerDelegate?
    
    
    func fetchWeather(city: String) {
        var cityRequest = CityNameRequest(city, countryCode: nil)
        let URLstring = weatherURL+"&q=\(city)"
        performRequest(with: URLstring)
    }
    func fetchWeather(latitud: Double, longitud: Double){
        let x = CLLocationCoordinate2D(latitude: latitud,longitude: longitud)
        let locationRequest = LocationRequest(x)
        
        api.requestCurrentWeather(with: locationRequest) { (current, error) in
            guard let current = current, error == nil else {
                // Handle error here
                return
            }
            
            print(current.main.temperature)
        }
        
        let URLstring = weatherURL+"&lat=\(latitud)&lon=\(longitud)"
        performRequest(with: URLstring)
    }
    
    func performRequest(with urlString: String) {
        // 1. Create URL
        
        if let url = URL(string: urlString) {
            
            // 2. Create URL session
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { (data, URLresponse, error) in
                if error != nil {
                    self.delegate?.didFailWithDeal(error!)
                    return
                }
                if let safeData = data {
                    if let WM = self.parseJSON(safeData) {
                        self.delegate?.didUpdateWeather(self, weather: WM)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            let temperature = decoderData.main.temp
            
            let cityName = decoderData.name
            let id = Int(decoderData.weather[0].id)
            let weatherModer = WeatherModel(conditon: id, city: cityName, temperature: temperature)
            return weatherModer
        } catch {
            self.delegate?.didFailWithDeal(error)
            return nil
        }
    }
    
}



protocol WeatherManagerDelegate {
    func didUpdateWeather(_ wheatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithDeal(_ error: Error)
}
*/
