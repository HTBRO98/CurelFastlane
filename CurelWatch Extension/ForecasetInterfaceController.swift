//
//  ForecasetInterfaceController.swift
//  CurelWatch Extension
//
//  Created by HAYATOYAMAMOTo on 2021/05/31.
//

import WatchKit
import Foundation
import AlamofireImage

class ForeCastInterfaceController: WKInterfaceController {

  @IBOutlet var descriLabel: WKInterfaceLabel!
  @IBOutlet var mainLabel: WKInterfaceLabel!
  @IBOutlet var tempminLabel: WKInterfaceLabel!
  @IBOutlet var tempmaxLabel: WKInterfaceLabel!
  @IBOutlet var humidityLabel: WKInterfaceLabel!
  @IBOutlet var pressureLabel: WKInterfaceLabel!
  @IBOutlet var sealevelLabel: WKInterfaceLabel!

    @IBOutlet weak var imageView: WKInterfaceImage!
    var item: Forecast.List? {
    didSet {
      guard let item = item else { return }

        descriLabel.setText("\(item.weather[0].description)")
        mainLabel.setText("\(item.weather[0].main)")
        tempminLabel.setText("\(item.main.temp_min) 最低気温")
        tempmaxLabel.setText("\(item.main.temp_max) 最高気温")

        humidityLabel.setText("\(item.main.humidity) 湿度")
        humidityLabel.setTextColor(.red)

        pressureLabel.setText("気圧 \(item.main.pressure)")
        sealevelLabel.setText("海抜 \(item.main.sea_level)")
        
        let iPath = item.weather[0].icon
        let iUrl = "https://openweathermap.org/img/wn/\(iPath)@2x.png"
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

  override func awake(withContext context: Any?) {
    super.awake(withContext: context)

    if let item = context as? Forecast.List {
      self.item = item
    }
  }
}
