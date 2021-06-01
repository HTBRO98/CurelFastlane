//
//  RowController.swift
//  CurelWatch Extension
//
//  Created by HAYATOYAMAMOTo on 2021/05/09.
//

import WatchKit
import AlamofireImage

class RowController: NSObject {
    
    @IBOutlet weak var dateLabel: WKInterfaceLabel!
    @IBOutlet weak var CityLabel: WKInterfaceLabel!
    @IBOutlet weak var imageView: WKInterfaceImage!
    
    var data: (Forecast.List, Int)? {
        didSet {
            guard let data = data else { return }
            let iPath = data.0.weather[0].icon
            let iUrl = "https://openweathermap.org/img/wn/\(iPath)@2x.png"
            dateLabel.setText(data.0.weather[0].description)
            CityLabel.setText(data.0.weather[0].main)
            let downloader = ImageDownloader()
            let urlRequest = URLRequest(url: URL(string: iUrl)!)
            downloader.download(urlRequest) { response in
                debugPrint(response.result)
                if case .success(let image) = response.result {
                    self.imageView.setImage(image)
                }
            }
        }
    }
    
}
