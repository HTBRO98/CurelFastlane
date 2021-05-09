//
//  ViewModel.swift
//  CurelWatch Extension
//
//  Created by HAYATOYAMAMOTo on 2021/05/09.
//

import Foundation
import Alamofire
import AlamofireImage

class FetchProvider {
    
    func fetchAPI(search: String, model: Model) {
        // TODO:apiのurlを合わせる search: tokyo
        // TODO:OpenWeathermap Current weather dataのWeb API
        //"https://api.openweathermap.org/data/2.5/weather?q=london&appid=cdc976a8dbd650139d902d1369ac8840"
        //今の天気
//        let baseUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(search)&appid=\(model.apiKey)"
        //天気予報
        let baseUrl = "https://api.openweathermap.org/data/2.5/forecast?q=\(search)&appid=\(model.apiKey)"
        let parameters: [String: Any] = [:]
        let headers: HTTPHeaders = ["Content-Type": "application/json"]
        AF.request(baseUrl, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers, interceptor: nil, requestModifier: nil).response(queue: DispatchQueue.global(qos: .utility)) {
            progress in
            print("fetchAPI progress: \(progress)")
        }
        .responseJSON { response in
                switch response.result {
                case .success:
                    print("Success!")
                    let data = response.data
                    self.jDecode(data: data, model: model)
                case .failure:
                    print("Failure!")
                }
        }
    }
    
    func jDecode(data: Data?, model: Model) {
        guard let data = data else { return }
        do {
            let data = try JSONDecoder().decode(Forecast.self, from: data)
            print("jDecode: \(data)")
            model.dataList.append(data)
        } catch let error {
            print("jDecode error: \(error)")
        }
    }
    
    func fetchIconAPI(iPath:String, imageview: UIImageView, placeHolderImage: UIImage) {
        let iUrl = "https://openweathermap.org/img/wn/\(iPath)@2x.png"
        guard let url = URL(string: iUrl) else { return }
        imageview.af.setImage(withURL: url,
                                      placeholderImage: placeHolderImage,
                                      imageTransition: .crossDissolve(0.3))
    }
    
}
