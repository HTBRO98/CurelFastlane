//
//  DetailViewController.swift
//  Curel
//
//  Created by HAYATOYAMAMOTo on 2021/03/03.
//

import UIKit


class DetailViewController: UIViewController {
    
    fileprivate var imageview: UIImageView = UIImageView(frame: .zero)
    fileprivate var label = UILabel()
    fileprivate var descript = UILabel()
    fileprivate var temp = UILabel()
    fileprivate var feellike = UILabel()
    fileprivate var pressure = UILabel()
    fileprivate var humidity = UILabel()
    fileprivate let image = UIImage(named: "noalpha.appicon_120")!
    var data: Forecast?
    var index: Int?
    fileprivate let fetchProvider = FetchProvider()
    fileprivate let color = Color()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor(hex: color.background, alpha: 1)
        setupImageView()
        setupLabel()
        setupDescrip()
        setupTemp()
        setupFeellike()
        setupPressure()
        setupHumidity()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let data = data, let index = index else { return imageview.image = image }
        label.text = data.list[index].weather[0].main
        descript.text = data.list[index].weather[0].description
        temp.text = String(data.list[index].main.temp)
        feellike.text = String(data.list[index].main.feels_like)
        pressure.text = String(data.list[index].main.pressure)
        humidity.text = String(data.list[index].main.humidity)
        fetchProvider.fetchIconAPI(iPath: data.list[index].weather[0].icon, imageview: imageview, placeHolderImage: image)
 
    }
    
    func setupImageView() {
        //.center 画像サイズそのままで、ImageViewに対する位置を指定する。つまり画像サイズは変わらない
        //.scaleAspectFit ImageViewのサイズ内で、画像を元の比率のまま表示する。
        imageview.contentMode = .scaleAspectFit
        imageview.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageview)
        // TODO:画像に合わせてレイアウトが変わるのか調べる。
        NSLayoutConstraint.activate([
            imageview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            imageview.heightAnchor.constraint(equalToConstant: 100),
            imageview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            imageview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func setupLabel() {
        label.translatesAutoresizingMaskIntoConstraints = false
        let localizedMailAddress = NSLocalizedString("国名コード", comment: "")
        label.text = localizedMailAddress
        label.textColor = UIColor(hex: color.title, alpha: 1)
        label.font = UIFont(name: "HiraKakuProN-W6", size: 45)
        label.numberOfLines = 2
        label.textAlignment = .center
        self.view.addSubview(label)
        // TODO:imageViewに合わせてレイアウトを変える。
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: imageview.bottomAnchor),
            label.heightAnchor.constraint(equalToConstant: 50),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    func setupDescrip() {
        descript.translatesAutoresizingMaskIntoConstraints = false
        let localizedMailAddress = NSLocalizedString("国名コード", comment: "")
        descript.text = localizedMailAddress
        descript.textColor = UIColor(hex: color.subTitle, alpha: 1)
        descript.font = UIFont(name: "HiraKakuProN-W6", size: 36)
        descript.numberOfLines = 2
        descript.textAlignment = .center
        self.view.addSubview(descript)
        // TODO:imageViewに合わせてレイアウトを変える。
        NSLayoutConstraint.activate([
            descript.topAnchor.constraint(equalTo: label.bottomAnchor),
            descript.heightAnchor.constraint(equalToConstant: 50),
            descript.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            descript.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func setupTemp() {
        temp.translatesAutoresizingMaskIntoConstraints = false
        let localizedMailAddress = NSLocalizedString("国名コード", comment: "")
        temp.text = localizedMailAddress
        temp.textColor = UIColor(hex: color.some, alpha: 1)
        temp.font = UIFont(name: "HiraKakuProN-W6", size: 42)
        temp.numberOfLines = 2
        temp.textAlignment = .center
        self.view.addSubview(temp)
        // TODO:imageViewに合わせてレイアウトを変える。
        NSLayoutConstraint.activate([
            temp.topAnchor.constraint(equalTo: descript.bottomAnchor),
            temp.heightAnchor.constraint(equalToConstant: 100),
            temp.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            temp.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4),
        ])
    }
    
    func setupFeellike() {
        feellike.translatesAutoresizingMaskIntoConstraints = false
        let localizedMailAddress = NSLocalizedString("国名コード", comment: "")
        feellike.text = localizedMailAddress
        feellike.textColor = UIColor(hex: color.some, alpha: 1)
        feellike.font = UIFont(name: "HiraKakuProN-W6", size: 42)
        feellike.numberOfLines = 2
        feellike.textAlignment = .center
        self.view.addSubview(feellike)
        // TODO:imageViewに合わせてレイアウトを変える。
        NSLayoutConstraint.activate([
            feellike.topAnchor.constraint(equalTo: temp.topAnchor),
            feellike.heightAnchor.constraint(equalTo: temp.heightAnchor),
            feellike.leadingAnchor.constraint(equalTo: temp.trailingAnchor, constant: 30),
            feellike.widthAnchor.constraint(equalTo: temp.widthAnchor)
        ])
    }
    
    func setupPressure() {
        pressure.translatesAutoresizingMaskIntoConstraints = false
        let localizedMailAddress = NSLocalizedString("国名コード", comment: "")
        pressure.text = localizedMailAddress
        pressure.textColor = UIColor(hex: color.some, alpha: 1)
        pressure.font = UIFont(name: "HiraKakuProN-W6", size: 42)
        pressure.numberOfLines = 2
        pressure.textAlignment = .center
        self.view.addSubview(pressure)
        // TODO:imageViewに合わせてレイアウトを変える。
        NSLayoutConstraint.activate([
            pressure.topAnchor.constraint(equalTo: temp.bottomAnchor),
            pressure.heightAnchor.constraint(equalTo: temp.heightAnchor),
            pressure.leadingAnchor.constraint(equalTo: temp.leadingAnchor),
            pressure.widthAnchor.constraint(equalTo: temp.widthAnchor),
        ])
    }
    
    func setupHumidity() {
        humidity.translatesAutoresizingMaskIntoConstraints = false
        let localizedMailAddress = NSLocalizedString("国名コード", comment: "")
        humidity.text = localizedMailAddress
        humidity.textColor = UIColor(hex: color.some, alpha: 1)
        humidity.font = UIFont(name: "HiraKakuProN-W6", size: 42)
        humidity.numberOfLines = 2
        humidity.textAlignment = .center
        self.view.addSubview(humidity)
        // TODO:imageViewに合わせてレイアウトを変える。
        NSLayoutConstraint.activate([
            humidity.topAnchor.constraint(equalTo: temp.bottomAnchor),
            humidity.heightAnchor.constraint(equalTo: temp.heightAnchor),
            humidity.leadingAnchor.constraint(equalTo: temp.trailingAnchor, constant: 30),
            humidity.widthAnchor.constraint(equalTo: temp.widthAnchor),
        ])
    }
    
}
