//
//  DetailViewController.swift
//  Curel
//
//  Created by HAYATOYAMAMOTo on 2021/03/03.
//

import UIKit


class DetailViewController: UIViewController {
    
    fileprivate var backButton = UIButton(type: .system)
    fileprivate var label: UILabel!
    var data: WeatherData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupBackButton()
        setupEmailLabel()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        label.text = data?.sys.country
    }
    
    @objc func backAction(sender: UIButton) {
        // TODO:ViewControllerに戻る遷移
        print("バックボタンをタップしました。")
    }
    
    func setupBackButton() {
        backButton.frame = CGRect(x: screenWidth * 0.0, y: screenHeight * 0.0, width: screenWidth * 1, height: screenHeight * 0.1)
        let localizedSignin = NSLocalizedString("バックボタン", comment: "")
        backButton.setTitle(localizedSignin, for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        backButton.titleLabel?.numberOfLines = 2
        let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 12),
        .foregroundColor: UIColor.white,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: localizedSignin,
                                                        attributes: attributes)
        backButton.setAttributedTitle(attributeString, for: .normal)
        backButton.backgroundColor = .black
        backButton.addTarget(self, action: #selector(backAction(sender:)), for: .touchUpInside)
        self.view.addSubview(backButton)
    }
    
    func setupEmailLabel() {
        label = UILabel()
        label.frame = CGRect(x: screenWidth * 0.1, y: screenHeight * 0.3, width: screenWidth * 0.8, height: screenHeight * 0.1)
        let localizedMailAddress = NSLocalizedString("国名コード", comment: "")
        label.text = localizedMailAddress
        label.textColor = .white
        label.font = UIFont(name: "HiraKakuProN-W6", size: 32)
        label.numberOfLines = 2
        label.textAlignment = .left
        self.view.addSubview(label)
    }
    
}
