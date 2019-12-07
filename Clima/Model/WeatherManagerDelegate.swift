//
//  WeatherManagerDelegate.swift
//  Clima
//
//  Created by Camilo Jiménez on 27/11/19.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(weather: WeatherModel)
}
