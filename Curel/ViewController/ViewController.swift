//
//  ViewController.swift
//  Curel
//
//  Created by HAYATOYAMAMOTo on 2021/03/03.
//

import UIKit

    /**
    アーキテクチャ：MVVM
    HTTP通信
    VM・View・Model
    View　一覧→表示・操作　スクロール機能　VMに通知？　Diffable？
    View2 詳細→モデルから配列のindexを頼りに表示。
    VM→HTTP通信　get　生のデータをモデルに渡す。　V Mの変化をViewに通知。→通知すると何が起こる？表示系統
    Model→Jasonの形式をSwiftの構造体に変形させる→構造体にする。→モデルの配列に格納
 
    Autolaytout
    faltlane
    figma
    */

class ViewController: UIViewController , UITableViewDelegate {

    fileprivate var apiButton = UIButton(type: .system)
    fileprivate var tableview: UITableView!
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate let fetchProvider = FetchProvider()
    // TODO:クエリを国名で英語に合わせる
    let query = "london"
    let model = Model()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
        setupApiButton()
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .WeatherNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(rotate(_:)), name: .RotateNotification, object: nil)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return model.dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        // TODO:パラメーター値をAPIに合わせる
            cell.textLabel?.text = model.dataList[indexPath.row].sys.country
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("詳細画面へ遷移します。")
        // TODO:詳細画面の遷移メソッドを入れる
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        nextVC.data = model.dataList[indexPath.row]
        self.navigationController?.pushViewController(nextVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func apiAction(sender: UIButton) {
        print("Api通信ボタンをタップしました。")
        if model.dataList.count == 0 {
            fetchProvider.fetchAPI(search: query, model: model)
        } else {
            model.dataList.removeAll()
            fetchProvider.fetchAPI(search: query, model: model)
        }
    }
    
    @objc func loadWeather() {
        print("Api通信をロードします。")
        // TODO:Dispath関係をHEYHOから入れる　SemiModalViewController
        fetchProvider.fetchAPI(search: query, model: model)
        self.refreshControl.endRefreshing()
    }
    
    @objc func update(_ notification: Notification) {
        print("tableviewのデータをリロードします。")
            self.tableview.reloadData()
    }
    
    @objc func rotate(_ notification: Notification) {
        print("デバイスの回転を検知しました")
            
    }
    
    func setupTableView() {
        tableview = UITableView(frame: CGRect(x: 0, y: screenHeight * 0.2, width: screenWidth, height: screenHeight - (screenHeight * 0.1)))
        tableview.tableFooterView = UIView(frame: .zero)
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableview.rowHeight = screenHeight * 0.05
        tableview.backgroundColor = .blue
        tableview.separatorColor = .darkGray
        tableview.bounces = false
        tableview.isScrollEnabled = false
        tableview.dataSource = self
        tableview.delegate = self
        tableview.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(loadWeather), for: .valueChanged)
        self.view.addSubview(tableview)
    }
    
    func setupApiButton() {
        apiButton.frame = CGRect(x: screenWidth * 0.0, y: screenHeight * 0.1, width: screenWidth * 1, height: screenHeight * 0.1)
        let localizedSignin = NSLocalizedString("API通信", comment: "")
        apiButton.setTitle(localizedSignin, for: .normal)
        apiButton.setTitleColor(.white, for: .normal)
        apiButton.titleLabel?.numberOfLines = 2
        let attributes: [NSAttributedString.Key: Any] = [
        .font: UIFont.systemFont(ofSize: 36),
        .foregroundColor: UIColor.white,
        .underlineStyle: NSUnderlineStyle.single.rawValue]
        let attributeString = NSMutableAttributedString(string: localizedSignin,
                                                        attributes: attributes)
        apiButton.setAttributedTitle(attributeString, for: .normal)
        apiButton.backgroundColor = .darkGray
        apiButton.addTarget(self, action: #selector(apiAction(sender:)), for: .touchUpInside)
        self.view.addSubview(apiButton)
    }
    
}

