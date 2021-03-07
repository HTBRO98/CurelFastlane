//
//  UIColorEx.swift
//  Curel
//
//  Created by HAYATOYAMAMOTo on 2021/03/07.
//

import UIKit

class Color {
    let title = "91926B"
    let subTitle = "9BBDD0"
    let some = "D7D3D1"
    let background = "0C2C81"
    let bodyText = "FFFFFF"
    let head = "91926B"
    let cellBac = "A1D9DD"
}

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
}
