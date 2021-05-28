//
//  InterfaceController.swift
//  CurelWatch Extension
//
//  Created by HAYATOYAMAMOTo on 2021/03/18.
//

import WatchKit
import Foundation

protocol NotifySetDataDelegate {
    func setModel()
}


class InterfaceController: WKInterfaceController, NotifySetDataDelegate {
    
    fileprivate let fetchProvider = FetchProvider()
    let query = "tokyo"
    let model = Model()
    
    @IBOutlet weak var table: WKInterfaceTable!
        
    @IBOutlet weak var label: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        model.delegate = self
                        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        
    }
    
    override func didAppear() {
        if model.dataList.count == 0 {
            fetchProvider.fetchAPI(search: query, model: model)
        } else {
            model.dataList.removeAll()
            fetchProvider.fetchAPI(search: query, model: model)
        }
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    
    func setModel() {
        print("willActivate model.dataList.count \(model.dataList[0].list.count)個です。")
        table.setNumberOfRows(model.dataList[0].list.count, withRowType: "Row")
        
        for i in 0 ..< table.numberOfRows {
            guard let controller = table.rowController(at: i) as? RowController else { continue }
            controller.data = (model.dataList[0].list[i], i)
        }
    }
    
}
