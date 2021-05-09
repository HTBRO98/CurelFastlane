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
    @IBOutlet weak var image: WKInterfaceImage!
    
    var data: (Forecast?, Int) {
        didSet {
            guard let data = data else { return }
            let iPath = data.0?.list[data.1].weather[0].icon
            let iUrl = "https://openweathermap.org/img/wn/\(iPath)@2x.png"
            let size = imageview.frame.size
            dateLabel = data.0?.list[data.1].weather[0].main
            CityLabel = data.0?.list[data.1].weather[0].main
            let downloader = ImageDownloader()
            let urlRequest = URLRequest(url: URL(string: iUrl)!)
            downloader.download(urlRequest) { response in
                debugPrint(response.result)
                if case .success(let image) = response.result {
                    image.setImage(image)
                }
            }
            image.setImage()
        }
    }
    
}
