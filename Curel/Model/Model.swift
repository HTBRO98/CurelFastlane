//
//  Model.swift
//  Curel
//
//  Created by HAYATOYAMAMOTo on 2021/03/03.
//

import Foundation

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
        let feels_like: Double      //Temperature. Unit Default: Kelvin
        let temp_min: Double        //Unit Default: Kelvin
        let temp_max: Double        //Unit Default: Kelvin
        let pressure: Int           //Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
        let sea_level: Int          //Atmospheric pressure on the sea level, hPa
        let grnd_level: Int         //Atmospheric pressure on the ground level, hPa
        let humidity: Int           //Humidity, %
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
        let speed: Double
        let deg: Int
    }
    
    struct Sys: Codable {
        let pod: String
    }
}


class Model {
    var apiKey: String = ""
    
    // TODO:クエリを国名で英語に合わせる
    //UI:PickerViewやDiffabledatasource
    //Cityidのquery方法を調べる
    let query = "london"
    //"tokyo"
    
    var dataList : [Forecast] = [] {
        
        didSet {
            NotificationCenter.default.post(name: .WeatherNotification, object: nil)
        }
    }
}
