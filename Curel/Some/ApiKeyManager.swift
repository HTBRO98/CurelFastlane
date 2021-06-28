//
//  ApiKeyManager.swift
//  Curel
//
//  Created by HAYATOYAMAMOTo on 2021/06/27.
//

import Foundation

class localApiKeyManager {
    
    func getAPIKeyLocal() {
        guard let path = Bundle.main.path(forResource: ".env", ofType: nil) else {
                    fatalError("Not found: '/path/to/.env'.\nPlease create .env file reference from .env.sample")
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let str = String(data: data, encoding: .utf8) ?? "Empty File"
            let clean = str.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "'", with: "")
            let envVars = clean.components(separatedBy:"\n")
            for envVar in envVars {
                let keyVal = envVar.components(separatedBy:"=")
                if keyVal.count == 2 {
                    setenv(keyVal[0], keyVal[1], 1)
                }
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func setAPIKeyLocal(model: Model) {
        let env = ProcessInfo.processInfo.environment
        if let key = env["OPEN_WEATHER_KEY"] {
            print("環境変数の値がセットされました。")
            model.apiKey = key
        } else {
            print("環境変数に値がありません。")
        }
    }
    
}
