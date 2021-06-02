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
    
    let helper = Helper()

    @IBOutlet weak var imageView: WKInterfaceImage!
    var item: Forecast.List? {
    didSet {
      guard let item = item else { return }

        descriLabel.setText("\(item.weather[0].description)")
        mainLabel.setText("\(item.weather[0].main)")
        tempminLabel.setText("最低気温 \(helper.kelToCel(kelvin: item.main.temp_min))度")
        tempmaxLabel.setText("最高気温 \(helper.kelToCel(kelvin: item.main.temp_max))度")

        humidityLabel.setText("湿度 \(item.main.humidity)%")
        humidityLabel.setTextColor(.red)

        pressureLabel.setText("気圧 \(item.main.pressure)hPa")
        sealevelLabel.setText("風速 \(round(item.wind.speed))m/秒")
        
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
