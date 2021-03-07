//
//  Cell.swift
//  Curel
//
//  Created by HAYATOYAMAMOTo on 2021/03/05.
//

import UIKit
import AlamofireImage

class HomeCell: UITableViewCell {
    
    @IBOutlet weak var imageview: UIImageView!
    @IBOutlet weak var label: UILabel!
    let color = Color()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupMainContents(iPath: String, plaseHolderImage: UIImage, text: String) {
        let iUrl = "https://openweathermap.org/img/wn/\(iPath)@2x.png"
        let size = imageview.frame.size
        label.text = text
        label.tintColor = UIColor(hex: color.title, alpha: 1.0)
        guard let url = URL(string: iUrl) else { return }
        imageview.af.setImage(withURL: url,
                                      placeholderImage: plaseHolderImage,
                                      filter: AspectScaledToFillSizeWithRoundedCornersFilter(size: size, radius: 20.0),
                                      imageTransition: .crossDissolve(0.3))
        
    }
}
