//
//  Helper.swift
//  CurelWatch Extension
//
//  Created by HAYATOYAMAMOTo on 2021/06/02.
//

import Foundation

class Helper {
    
    //気温変換　摂氏；日本　華氏：イギリス
    //0°C->100°F
    //華氏->摂氏
    //-32（引く）　÷1.8
    //ケルビンから摂氏
    
    func kelToCel(kelvin: Double) -> Double {
        return round(kelvin - 273.15)
    }
    
    
}
