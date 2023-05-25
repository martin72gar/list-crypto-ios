//
//  ViewController.swift
//  ListCrypto
//
//  Created by Osmartin Pardomuan Siregar on 02/05/23.
//

import UIKit

struct Crypto: Codable {
    let code: String
    let name: String
    let image: String
    let desc: String
}

struct CryptosData: Codable {
    let cryptos: [Crypto]
}

class ViewController: UIViewController {
    var cryptos: [CryptoModel]?
    var cryptos2: [Crypto] = []

    @IBOutlet weak var cryptoTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        readJSONFile()
        versiConsole()
        
//        cryptoTableView.dataSource = self
//        cryptos = DataManager.getCryptos()
//        cryptoTableView.reloadData()
    }
    
    func versiConsole() {
        if let fileURL = Bundle.main.url(forResource: "cryptos", withExtension: "json") {
                    do {
                        let jsonData = try Data(contentsOf: fileURL)
                        let decoder = JSONDecoder()
                        let cryptosData = try decoder.decode(CryptosData.self, from: jsonData)
                        cryptos2 = cryptosData.cryptos
                    } catch {
                        print("Error decoding file cryptos.json: \(error)")
                    }
                } else {
                    print("cryptos.json file not found")
                }
                
                // Display the data
                for crypto in cryptos2 {
                    print("Code: \(crypto.code)")
                    print("Name: \(crypto.name)")
                    print("Image: \(crypto.image)")
                    print("Description: \(crypto.desc)")
                    print("------------------------")
                }
    }

    func readJSONFile() {
        let fileName = "cryptos"
        let fileType = "json"
        
        if let path = Bundle.main.path(forResource: fileName, ofType: fileType) {
            do {
                let jsonData = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        if let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as? [String:Any] {
                            // data is in dictionary format
                            print("as string")
                            print(jsonResult)
                        } else if let jsonResult = try JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves) as? [Any] {
                            // data is in array format
                            print("as any")
                            print(jsonResult[0])
                        }
            } catch {
                print("Error reading JSON file: \(error)")
            }
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView:UITableView, numberOfRowsInSection section: Int) -> Int{
        return cryptos?.count ?? 0
    }
    
    func tableView(_ tableView:UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CryptoTableViewCell", for: indexPath) as! CryptoTableViewCell
        if let crypto = cryptos?[indexPath.row] {
            cell.codeLabel.text = crypto.code
        }
        return cell
    }
}

