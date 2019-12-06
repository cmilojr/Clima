//
//  WeatherManager.swift
//  Clima
//
//  Created by Camilo Jiménez on 27/11/19.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    
    let watherURL: String = "https://api.openweathermap.org/data/2.5/weather?appid=51b048e2b9019609f3b728766b906b92&units=metric"
    
    func fetchWeather(city: String) -> String {
        return watherURL+"&q=\(city)"
    }
}
