//
//  ViewController.swift
//  Curel
//
//  Created by HAYATOYAMAMOTo on 2021/03/03.
//

import UIKit
import PKHUD
import WatchConnectivity

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
    →snapshotsをとる時は、UITestにはSnapshot("スナップショット名")とmage schemeにUItestを新たに入れてtestとrunとshared等にチェックを入れる。uitestにレコードしておく
    →bundle exec fastlane screenshotではなく、fastlane screenshotsだと上手く行った
    →gymの時にbuild settings versioning current project version 1にする version systemをappleGenericにする　bundle exec fastlane buildでいける
    →screenshotsの写真サイズがappleのデフォルトサイズと変わってしまったので、パッケージ2.176.0だと上手くいかないので、2.177.0がリリースされるのを待つ。
    figma
 
    bitrise
    workflowでSlackを追加（iOSではなく、All）→VariableにSlkack WEBhook URLを追加。variableには少し時間がかかる。
    */

class ViewController: UIViewController , UITableViewDelegate {
    
    fileprivate var apiButton = UIButton(frame: .zero)
    fileprivate var tableview = UITableView(frame: .zero, style: .insetGrouped)
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate let fetchProvider = FetchProvider()
    fileprivate let color = Color()
    let model = Model()
    let APIKeyManager = localApiKeyManager()
    // TODO:写真を入れ替える
    let image = UIImage(named: "noalpha.appicon_120")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        APIKeyManager.getAPIKeyLocal()
        APIKeyManager.setAPIKeyLocal(model: model)
        Environment.getFlavertype()
        setupApiButton()
        setupTableView()
        
        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController!.navigationBar.shadowImage = UIImage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(update(_:)), name: .WeatherNotification, object: nil)
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if model.dataList.count == 0 {
            return 0
        } else {
            print("天気の数は、　\(model.dataList[0].list.count)")
            return model.dataList[0].list.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeCell
        cell.backgroundColor = UIColor(hex: color.cellBac, alpha: 1.0)
        cell.setupMainContents(iPath: model.dataList[0].list[indexPath.row].weather[0].icon, plaseHolderImage: image!, text: model.dataList[0].list[indexPath.row].weather[0].main)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO:詳細画面の遷移メソッドを入れる
        let nextVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailViewController
        nextVC.data = model.dataList[0]
        nextVC.index = indexPath.row
        self.navigationController?.pushViewController(nextVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @objc func apiAction(sender: UIButton) {
        print("Api通信ボタンをタップしました。")
        HUD.show(.progress)
        if model.dataList.count == 0 {
            fetchProvider.fetchAPI(search: model.query, model: model)
            WCSession.default.transferUserInfo(["Location": "tokyo"])
            if WCSession.default.isReachable {
                //WatchConnectivity.WCSession.default.transferUserInfo(["number": 12345]
                //WatchConnectivity.WCSession.default.sendMessage(["Message": "Hello world!"], replyHandler: nil, errorHandler: nil)
                print("apiAction WCSession enable)")
                WCSession.default.sendMessage(["Location": "tokyo"], replyHandler: nil) {
                    error in
                    print(error)
                }
            } else {
                print("apiAction WCSession unenable")
            }
        } else {
            model.dataList.removeAll()
            fetchProvider.fetchAPI(search: model.query, model: model)
            if WCSession.default.isReachable {
                //WatchConnectivity.WCSession.default.transferUserInfo(["number": 12345]
                //WatchConnectivity.WCSession.default.sendMessage(["Message": "Hello world!"], replyHandler: nil, errorHandler: nil)
                WCSession.default.sendMessage(["Location": "tokyo"], replyHandler: nil) {
                    error in
                    print(error)
                }
            }
        }
        
    }
    
    @objc func loadWeather(sender: UIRefreshControl) {
        print("Api通信をロードします。")
        model.dataList.removeAll()
        let query = "london"
        fetchProvider.fetchAPI(search: query, model: model)
        self.refreshControl.endRefreshing()
    }
    
    @objc func update(_ notification: Notification) {
        print("tableviewのデータをリロードします。")
        self.tableview.reloadData()
        HUD.hide()
    }
    
    func setupApiButton() {
        apiButton.translatesAutoresizingMaskIntoConstraints = false
        let localizedSignin = NSLocalizedString("今週の天気", comment: "")
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
        apiButton.backgroundColor = UIColor(hex: color.background, alpha: 1.0)
        apiButton.addTarget(self, action: #selector(apiAction(sender:)), for: .touchUpInside)
        self.view.addSubview(apiButton)
        NSLayoutConstraint.activate([
            apiButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.2),
            apiButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            apiButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }
    
    func setupTableView() {
        tableview.translatesAutoresizingMaskIntoConstraints = false
        tableview.register(UINib(nibName: "HomeCell", bundle: nil), forCellReuseIdentifier: "cell")
        tableview.rowHeight = 100
        tableview.backgroundColor = UIColor(hex: color.background, alpha: 1.0)
        tableview.separatorColor = .darkGray
        tableview.bounces = true
        tableview.isScrollEnabled = true
        tableview.dataSource = self
        tableview.delegate = self
        tableview.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(loadWeather(sender:)), for: .valueChanged)
        self.view.addSubview(tableview)
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: apiButton.bottomAnchor),
            tableview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}
