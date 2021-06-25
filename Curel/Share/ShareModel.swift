//
//  ShareModel.swift
//  Curel
//
//  Created by HAYATOYAMAMOTo on 2021/06/24.
//

import Foundation

//共通
struct Forecast: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    let list: [List]
    
    struct List: Codable {
        let dt: Int
        let main: Main
        let weather: [Weather]
        let clouds: Clouds
        let wind: Wind
        let visibility: Int
        let pop: Double
        let sys: Sys
        let dt_txt: String
    }
    
    struct Main: Codable {
        let temp: Double
        let feels_like: Double  //Temperature. Unit Default: Kelvin
        let temp_min: Double    //Unit Default: Kelvin
        let temp_max: Double    //Unit Default: Kelvin
        let pressure: Int       //Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
        let sea_level: Int      //Atmospheric pressure on the sea level, hPa
        let grnd_level: Int     //Atmospheric pressure on the ground level, hPa
        let humidity: Int       //Humidity, %
        let temp_kf: Double
    }
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Clouds: Codable {
        let all: Int
    }
    
    struct Wind: Codable {
        let speed: Double       //Unit Default: meter/sec
        let deg: Int
    }
    
    struct Sys: Codable {
        let pod: String
    }
}

    // TODO:使わない
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

//共通
class Model {
    let apiKey: String = "cdc976a8dbd650139d902d1369ac8840"
    
    // TODO:クエリを国名で英語に合わせる
    let query = "london"
    //"tokyo"
    
    var delegate: NotifySetDataDelegate?
    
    var dataList : [Forecast] = [] {
        
        didSet {
            print("NotificationCenter.default.post(name: .WeatherNotification, object: nil)")
            NotificationCenter.default.post(name: .WeatherNotification, object: nil)
        }
    }
}

//iOS
extension Notification.Name {
    static let WeatherNotification = Notification.Name("WeatherNotification")
    static let RotateNotification = Notification.Name("RotateNotification")
}

//Watch OS
protocol NotifySetDataDelegate {
    func setModel()
}
