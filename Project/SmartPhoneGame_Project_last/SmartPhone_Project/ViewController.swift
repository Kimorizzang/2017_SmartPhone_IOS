//
//  ViewController.swift
//  SmartPhone_Project
//
//  Created by KPUGame on 2017. 5. 20..
//  Copyright © 2017년 KPUGame. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, XMLParserDelegate {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerDataSource:[String] = []
    
    var url : String = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/sido?ServiceKey=3n0ay%2Fk%2BocRtQBOiPEJNJ7hJNqBuoC1%2F2d%2BQY7GDxFynWHRxFJJM2Hm1MYFTyoe%2BVswgU6XVD%2BuDqwrOXOVUjA%3D%3D"
    
    var uprCd : String = "6110000" // 디폴트 = 서울특별시
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //uprCd = uprCd2
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
        
        beginParsing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var orgDown = NSMutableString()
    
    var uprCd2 = NSMutableString()
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf:(URL(string: url))!)!
        parser.delegate = self
        parser.parse()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!){
        if segue.identifier == "Nang" {
            if let secondViewController = segue.destination as? SecondViewController {
                    secondViewController.url2 = uprCd
            }
        }
    }
    
    @IBAction func cancelToSelectController(segue: UIStoryboardSegue) {
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return posts.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if row == 0 {
            uprCd = "6110000"
        }
        else if row == 1 {
            uprCd = "6260000"
        }
        else if row == 2 {
            uprCd = "6270000"
        }
        else if row == 3 {
            uprCd = "6280000"
        }
        else if row == 4 {
            uprCd = "6290000"
        }
        else if row == 5 {
            uprCd = "5690000"
        }
        else if row == 6 {
            uprCd = "6300000"
        }
        else if row  == 7 {
            uprCd = "6310000"
        }
        else if row == 8 {
            uprCd = "6410000"
        }
        else if row == 9 {
            uprCd = "6420000" // 강원도
            print("row9")
        }
        else if row == 10 {
            uprCd = "6430000" // 충청북도
        }
        else if row == 11 {
            uprCd = "6440000" // 충청남도
        }
        else if row == 12 {
            uprCd = "6450000" // 전라북도
        }
        else if row == 13 {
            uprCd = "6460000" // 전라남도
        }
        else if row == 14 {
            uprCd = "6470000" // 경상북도
        }
        else if row == 15 {
            uprCd = "6480000" // 경상남도
        }
        else {
            uprCd = "6500000" // 제주특별시
        }
    }

    
    // parser가 새로운 element를 발견하면 변수를 생성한다.
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            orgDown = NSMutableString()
            orgDown = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String!)
    {
        if element.isEqual(to: "orgdownNm") {
            orgDown.append(string)
            //pickerDataSource.append(string)
            uprCd2.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if (elementName as NSString).isEqual(to: "item") {
            if !orgDown.isEqual(to: "item") {
                elements.setObject(orgDown, forKey: "orgdownNm" as NSCopying)
                pickerDataSource.append(orgDown as String)
            }
            
            posts.add(elements)
        }
    }
        
}
