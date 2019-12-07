//
//  WeatherModel.swift
//  Clima
//
//  Created by Camilo Jiménez on 6/12/19.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import Foundation
struct WeatherModel {
    
    let condition: Int
    let city: String
    let temperature: Double
    
    init(conditon: Int, city: String, temperature: Double) {
        self.condition = conditon
        self.city = city
        self.temperature = temperature

    }
    
    var tempDouble: String {
        return String(format: "%.1f", temperature)
    }
    
    var conditionTime: String {
        switch condition {
        case 200 ... 232:
            return "cloud.bolt.rain"
        case 300 ... 321:
            return "cloud.drizzle"
        case 500 ... 531:
            if condition >= 511{
                return "cloud.heavyrain"
            }else{
                return "cloud.rain"
            }
        case 600 ... 622:
            if condition <= 615{
                return "cloud.snow"
            }else{
                return "cloud.sleet"
            }
        case 701 ... 781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801 ... 804:
            return "cloud.bolt"
        default:
            return "cloud"
        }
    }
}
