//
//  InterfaceController.swift
//  CurelWatch Extension
//
//  Created by HAYATOYAMAMOTo on 2021/03/18.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    fileprivate let fetchProvider = FetchProvider()
    let query = "tokyo"
    let model = Model()
    
    @IBOutlet weak var table: WKInterfaceTable!
    
    @IBAction func buttan() {
        
    }
    
    @IBOutlet weak var label: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
        
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        if model.dataList.count == 0 {
            fetchProvider.fetchAPI(search: query, model: model)
        } else {
            model.dataList.removeAll()
            fetchProvider.fetchAPI(search: query, model: model)
        }
        
        table.setNumberOfRows(model.dataList.count, withRowType: "Row")
        
        for i in 0 ..< table.numberOfRows {
            guard let controller = table.rowController(at: i) as? RowController else { continue }
            
            controller.data = (model.dataList[i], i)
        }
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }
    
    

}
