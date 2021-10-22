//
//  ViewController.swift
//  CurrencyExchange
//
//  Created by Jasmine Shang on 10/21/21.
//

import UIKit
import SwiftSpinner
import SwiftyJSON
import Alamofire

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyList.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyList[row]
    }
    
    let baseURL = "http://api.exchangeratesapi.io/v1/latest?access_key=d0b0bdb84abcf4f2641ebfc6c3ea8ef6&symbols=USD,AUD,CAD,PLN,MXN"

    @IBOutlet weak var fromPicker: UIPickerView!
    @IBOutlet weak var toPicker: UIPickerView!
    @IBOutlet weak var lblResult: UILabel!
    
    var currencyList: [String] = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.fromPicker.delegate = self
        self.fromPicker.dataSource = self
        self.toPicker.delegate = self
        self.toPicker.dataSource = self
        currencyList = ["EUR","USD","AUD","CAD","PLN","MXN"]
    }
    
    @IBAction func convertButton(_ sender: Any) {
        let fromCurrency = currencyList[fromPicker.selectedRow(inComponent: 0)]
        let toCurrency = currencyList[toPicker.selectedRow(inComponent: 0)]
        AF.request(baseURL).responseJSON{ response in
            if response.error != nil{
                print(response.error)
                return;
            }
            let result = JSON(response.data!)
            let EUR:Double = 1.0
            let USD:Double = result["rates"]["USD"].doubleValue
            let AUD:Double = result["rates"]["AUD"].doubleValue
            let CAD:Double = result["rates"]["CAD"].doubleValue
            let PLN:Double = result["rates"]["PLN"].doubleValue
            let MXN:Double = result["rates"]["MXN"].doubleValue
            var first:Double
            var second:Double
            
            if fromCurrency == "EUR"{
                 first = EUR
            }else if fromCurrency == "USD"{
                 first = USD
            }else if fromCurrency == "AUD"{
                 first = AUD
            }else if fromCurrency == "CAD"{
                 first = CAD
            }else if fromCurrency == "PLN"{
                 first = PLN
            }else{
                 first = MXN
            }
            
            if toCurrency == "EUR"{
                 second = EUR
            }else if toCurrency == "USD"{
                 second = USD
            }else if toCurrency == "AUD"{
                 second = AUD
            }else if toCurrency == "CAD"{
                 second = CAD
            }else if toCurrency == "PLN"{
                 second = PLN
            }else{
                 second = MXN
            }
            
            self.lblResult.text = "\(fromCurrency) to \(toCurrency) rate is \(round(1000*(second/first))/1000)"
        }
    }
    
    
}

