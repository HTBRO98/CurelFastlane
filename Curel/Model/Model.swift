//
//  Model.swift
//  Curel
//
//  Created by HAYATOYAMAMOTo on 2021/03/03.
//

import Foundation

    // TODO:パラメーター値をAPIに合わせる
struct WeatherData: Codable {
    let coord: Coord
    let weather: [Weather]
    let base: String
    let main: Main
    let visibility: Int
    let wind: Wind
    let clouds: Clouds
    let dt: Int
    let sys:Sys
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
    struct Coord: Codable {
        let lon: Double
        let lat: Double
    }
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Main: Codable {
        let temp: Double
        let feels_like: Double
        let temp_min: Double
        let temp_max: Double
        let pressure: Int
        let humidity: Int
    }
    
    struct Wind: Codable {
        let speed: Double
        let deg: Int
    }
    
    struct Clouds: Codable {
        let all: Int
    }
    
    struct Sys: Codable {
        let type: Int
        let id: Int
        let country: String
        let sunrise: Int
        let sunset: Int
    }
    
}

class Model {
    let apiKey: String = "cdc976a8dbd650139d902d1369ac8840"
    
    var dataList : [WeatherData] = [] {
        didSet {
            NotificationCenter.default.post(name: .WeatherNotification, object: nil)
        }
    }
}
