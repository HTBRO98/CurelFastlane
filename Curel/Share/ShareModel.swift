//
//  ShareModel.swift
//  Curel
//
//  Created by HAYATOYAMAMOTo on 2021/06/24.
//

import Foundation

class Model {
    let apiKey: String = "cdc976a8dbd650139d902d1369ac8840"
    
    // TODO:クエリを国名で英語に合わせる
    let query = "london"
    //"tokyo"
    
    var delegate: NotifySetDataDelegate?
    
    var dataList : [Forecast] = [] {
        
        didSet {
            NotificationCenter.default.post(name: .WeatherNotification, object: nil)
        }
    }
}

extension Notification.Name {
    static let WeatherNotification = Notification.Name("WeatherNotification")
    static let RotateNotification = Notification.Name("RotateNotification")
}

protocol NotifySetDataDelegate {
    func setModel()
}
