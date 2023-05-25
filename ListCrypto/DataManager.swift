//
//  DataManager.swift
//  ListCrypto
//
//  Created by Osmartin Pardomuan Siregar on 25/05/23.
//

import Foundation

class DataManager {
    static func getCryptos() -> [CryptoModel]? {
        let fileName = "cryptos"
        let fileType = "json"
        
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let cryptos = try decoder.decode([CryptoModel].self, from: data)
                
                return cryptos
            } catch {
                print("Error decoding file \(fileName) JSON : \(error.localizedDescription)")
            }
        }
        return nil
    }
}
