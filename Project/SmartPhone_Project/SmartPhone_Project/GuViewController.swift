//
//  GuViewController.swift
//  NyangNyang
//
//  Created by kpugame on 2017. 5. 20..
//  Copyright © 2017년 시현 김. All rights reserved.
//

import UIKit

class GuViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, XMLParserDelegate {

    @IBOutlet weak var guPickerView: UIPickerView!

    
    // ViewController로부터 segue를 통해 전달받은 시 코드
    var uprCd : String = ""
    
    var url : String = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/sigungu?upr_cd="
    
    var key : String = "&ServiceKey=3n0ay%2Fk%2BocRtQBOiPEJNJ7hJNqBuoC1%2F2d%2BQY7GDxFynWHRxFJJM2Hm1MYFTyoe%2BVswgU6XVD%2BuDqwrOXOVUjA%3D%3D"
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var orgCd : String = ""
    var orgdownNm = NSMutableString()
    
    var list: [String] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if uprCd == "6110000" { // 서울 특별시
                self.orgCd = "6119999"
        }
        else if uprCd == "6260000" { // 부산 광역시
                self.orgCd = "3360000"
        }
        else if uprCd == "6270000" { // 대구 광역시
                self.orgCd = "3340000"
        }
        else if uprCd == "6280000" {    // 인천 광역시
                self.orgCd = "3570000"
        }
        else if uprCd == "6290000" {    // 광주 광역시
                self.orgCd = "3630000"
        }
        else if uprCd == "6300000" {    // 대전 광역시
                self.orgCd = "3680000"
        }
        else if uprCd == "6310000" {    // 울산 광역시
                self.orgCd = "3700000"
        }
        else if uprCd == "6410000" {    // 경기도
                self.orgCd = "4160000"
        }
        else if uprCd == "6420000" { // 강원도
                self.orgCd = "4200000"
        }
        else if uprCd == "6430000" { // 충청북도
                self.orgCd = "4460000"
        }
        else if uprCd == "6440000" { // 충청남도
                self.orgCd = "5580000"
        }
        else if uprCd == "6450000" { // 전라북도
                self.orgCd = "4780000"
        }
        else if uprCd == "6460000" { // 전라남도
                self.orgCd = "4920000"
        }
        else if uprCd == "6470000" { // 경상북도
                self.orgCd = "5130000"
        }
        else if uprCd == "6480000" { // 경상남도
                self.orgCd = "5130000"
        }
        else if uprCd == "6500000" { // 제주특별시
                self.orgCd = "6520000"
        }
 
        
        self.guPickerView.dataSource = self
        self.guPickerView.delegate = self
        
        beginParsing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!){
        if segue.identifier == "segueToCareNmViewController" {
            if let careNameViewController = segue.destination as? CareNameTableViewController {
                careNameViewController.uprCd = uprCd
                careNameViewController.orgCd = orgCd
                
                print("[2] uprCd: \(uprCd)")
                print("[2] orgCd: \(orgCd)")
            }
        }
    }
    
    func beginParsing()
    {
        url = url + uprCd + key
        posts = []
        parser = XMLParser(contentsOf:(URL(string:url))!)!
        parser.delegate = self
        parser.parse()
        
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            orgdownNm = NSMutableString()
            orgdownNm = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "orgdownNm"){
            orgdownNm.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "item")
        {
            if !orgdownNm.isEqual(to: "item")
            {
                elements.setObject(orgdownNm, forKey: "orgdownNm" as NSCopying)
                list.append(orgdownNm as String)
            }
            
            posts.add(elements)
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return posts.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return list[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        
        if uprCd == "6110000" { // 서울 특별시
            if row == 0 {
                self.orgCd = "6119999"
            }
            else if row == 1 {
                self.orgCd = "3220000"
            }
            else if row == 2 {
                self.orgCd = "3240000"
            }
            else if row == 3 {
                self.orgCd = "3080000"
            }
            else if row == 4 {
                self.orgCd = "3150000"
            }
            else if row == 5 {
                self.orgCd = "6119998"
            }
            else if row == 6 {
                self.orgCd = "3200000"
            }
            else if row == 7 {
                self.orgCd = "3040000"
            }
            else if row == 8 {
                self.orgCd = "3160000"
            }
            else if row == 9 {
                self.orgCd = "3170000"
            }
            else if row == 10 {
                self.orgCd = "3100000"
            }
            else if row == 11 {
                self.orgCd = "3090000"
            }
            else if row == 12 {
                self.orgCd = "3050000"
            }
            else if row == 13 {
                self.orgCd = "3190000"
            }
            else if row == 14 {
                self.orgCd = "3130000"
            }
            else if row == 15 {
                self.orgCd = "3120000"
            }
            else if row == 16 {
                self.orgCd = "3210000"
            }
            else if row == 17 {
                self.orgCd = "3030000"
            }
            else if row == 18 {
                self.orgCd = "3070000"
            }
            else if row == 19 {
                self.orgCd = "3230000"
            }
            else if row == 20 {
                self.orgCd = "3140000"
            }
            else if row == 21 {
                self.orgCd = "3180000"
            }
            else if row == 22 {
                self.orgCd = "3020000"
            }
            else if row == 23 {
                self.orgCd = "3110000"
            }
            else if row == 24 {
                self.orgCd = "3000000"
            }
            else if row == 25 {
                self.orgCd = "3010000"
            }
            else if row == 26 {
                self.orgCd = "3060000"
            }

        }
        
        else if uprCd == "6260000" { // 부산 광역시
            if row == 0 {
                self.orgCd = "3360000"
            }
            else if row == 1 {
                self.orgCd = "3350000"
            }
            else if row == 2 {
                self.orgCd = "3400000"
            }
            else if row == 3 {
                self.orgCd = "3310000"
            }
            else if row == 4 {
                self.orgCd = "3270000"
            }
            else if row == 5 {
                self.orgCd = "3300000"
            }
            else if row == 6 {
                self.orgCd = "3290000"
            }
            else if row == 7 {
                self.orgCd = "3320000"
            }
            else if row == 8 {
                self.orgCd = "3390000"
            }
            else if row == 9 {
                self.orgCd = "3340000"
            }
            else if row == 10 {
                self.orgCd = "3260000"
            }
            else if row == 11 {
                self.orgCd = "3380000"
            }
            else if row == 12 {
                self.orgCd = "3370000"
            }
            else if row == 13 {
                self.orgCd = "3280000"
            }
            else if row == 14 {
                self.orgCd = "3250000"
            }
            else if row == 15 {
                self.orgCd = "3330000"
            }
        }
        
        else if uprCd == "6270000" { // 대구 광역시
            if row == 0 {
                self.orgCd = "3340000"
            }
            else if row == 1 {
                self.orgCd = "3470000"
            }
            else if row == 2 {
                self.orgCd = "3480000"
            }
            else if row == 3 {
                self.orgCd = "3420000"
            }
            else if row == 4 {
                self.orgCd = "3450000"
            }
            else if row == 5 {
                self.orgCd = "3430000"
            }
            else if row == 6 {
                self.orgCd = "3460000"
            }
            else if row == 7 {
                self.orgCd = "3410000"
            }
        }
        
        else if uprCd == "6280000" {    // 인천 광역시
            if row == 0 {
                self.orgCd = "3570000"
            }
            else if row == 1 {
                self.orgCd = "3550000"
            }
            else if row == 2 {
                self.orgCd = "3510000"
            }
            else if row == 3 {
                self.orgCd = "3530000"
            }
            else if row == 4 {
                self.orgCd = "3500000"
            }
            else if row == 5 {
                self.orgCd = "3540000"
            }
            else if row == 6 {
                self.orgCd = "3560000"
            }
            else if row == 7 {
                self.orgCd = "3520000"
            }
            else if row == 8 {
                self.orgCd = "3580000"
            }
            else if row == 9 {
                self.orgCd = "3490000"
            }
        }
        
        else if uprCd == "6290000" {    // 광주 광역시
            if row == 0 {
                self.orgCd = "3630000"
            }
            else if row == 1 {
                self.orgCd = "3610000"
            }
            else if row == 2 {
                self.orgCd = "3590000"
            }
            else if row == 3 {
                self.orgCd = "3620000"
            }
            else if row == 4 {
                self.orgCd = "3600000"
            }
        }
        
        else if uprCd == "6300000" {    // 대전 광역시
            if row == 0 {
                self.orgCd = "3680000"
            }
            else if row == 1 {
                self.orgCd = "3640000"
            }
            else if row == 2 {
                self.orgCd = "3660000"
            }
            else if row == 3 {
                self.orgCd = "3670000"
            }
            else if row == 4 {
                self.orgCd = "3650000"
            }
        }
        
        else if uprCd == "6310000" {    // 울산 광역시
            if row == 0 {
                self.orgCd = "3700000"
            }
            else if row == 1 {
                self.orgCd = "3710000"
            }
            else if row == 2 {
                self.orgCd = "3720000"
            }
            else if row == 3 {
                self.orgCd = "3730000"
            }
            else if row == 4 {
                self.orgCd = "3690000"
            }
        }
        
        else if uprCd == "6410000" {    // 경기도
            if row == 0 {
                self.orgCd = "4160000"
            }
            else if row == 1 {
                self.orgCd = "3940000"
            }
            else if row == 2 {
                self.orgCd = "3970000"
            }
            else if row == 3 {
                self.orgCd = "3900000"
            }
            else if row == 4 {
                self.orgCd = "5540000"
            }
            else if row == 5 {
                self.orgCd = "3980000"
            }
            else if row == 6 {
                self.orgCd = "4020000"
            }
            else if row == 7 {
                self.orgCd = "49090000"
            }
            else if row == 8 {
                self.orgCd = "3990000"
            }
            else if row == 9 {
                self.orgCd = "3920000"
            }
            else if row == 10 {
                self.orgCd = "3860000"
            }
            else if row == 11 {
                self.orgCd = "3780000"
            }
            else if row == 12 {
                self.orgCd = "3740000"
            }
            else if row == 13 {
                self.orgCd = "4010000"
            }
            else if row == 14 {
                self.orgCd = "3930000"
            }
            else if row == 15 {
                self.orgCd = "4080000"
            }
            else if row == 16 {
                self.orgCd = "3830000"
            }
            else if row == 17 {
                self.orgCd = "5590000"
            }
            else if row == 18 {
                self.orgCd = "4170000"
            }
            else if row == 19 {
                self.orgCd = "5700000"
            }
            else if row == 20 {
                self.orgCd = "4140000"
            }
            else if row == 21 {
                self.orgCd = "4000000"
            }
            else if row == 22 {
                self.orgCd = "4050000"
            }
            else if row == 23 {
                self.orgCd = "5630000"
            }
            else if row == 24 {
                self.orgCd = "4030000"
            }
            else if row == 25 {
                self.orgCd = "3820000"
            }
            else if row == 26 {
                self.orgCd = "4070000"
            }
            else if row == 27 {
                self.orgCd = "4060000"
            }
            else if row == 28 {
                self.orgCd = "3910000"
            }
            else if row == 29 {
                self.orgCd = "5600000"
            }
            else if row == 30 {
                self.orgCd = "4040000"
            }
            else if row == 31 {
                self.orgCd = "5530000"
            }
        }
        
        else if uprCd == "6420000" { // 강원도
            if row == 0 {
                self.orgCd = "4200000"
            }
            else if row == 1 {
                self.orgCd = "4340000"
            }
            else if row == 2 {
                self.orgCd = "4210000"
            }
            else if row == 3 {
                self.orgCd = "4240000"
            }
            else if row == 4 {
                self.orgCd = "4230000"
            }
            else if row == 5 {
                self.orgCd = "4320000"
            }
            else if row == 6 {
                self.orgCd = "4350000"
            }
            else if row == 7 {
                self.orgCd = "4270000"
            }
            else if row == 8 {
                self.orgCd = "4190000"
            }
            else if row == 9 {
                self.orgCd = "4330000"
            }
            else if row == 10 {
                self.orgCd = "4290000"
            }
            else if row == 11 {
                self.orgCd = "4300000"
            }
            else if row == 12 {
                self.orgCd = "4180000"
            }
            else if row == 13 {
                self.orgCd = "4220000"
            }
            else if row == 14 {
                self.orgCd = "4280000"
            }
            else if row == 15 {
                self.orgCd = "4250000"
            }
            else if row == 16 {
                self.orgCd = "4310000"
            }
            else if row == 17 {
                self.orgCd = "4260000"
            }
        }
        else if uprCd == "6430000" { // 충청북도
            if row == 0 {
                self.orgCd = "4460000"
            }
            else if row == 1 {
                self.orgCd = "4480000"
            }
            else if row == 2 {
                self.orgCd = "4420000"
            }
            else if row == 3 {
                self.orgCd = "4440000"
            }
            else if row == 4 {
                self.orgCd = "4430000"
            }
            else if row == 5 {
                self.orgCd = "4470000"
            }
            else if row == 6 {
                self.orgCd = "4400000"
            }
            else if row == 7 {
                self.orgCd = "5570000"
            }
            else if row == 8 {
                self.orgCd = "4450000"
            }
            else if row == 9 {
                self.orgCd = "5710000"
            }
            else if row == 10 {
                self.orgCd = "4390000"
            }
        }
            
        else if uprCd == "6440000" { // 충청남도
            if row == 0 {
                self.orgCd = "5580000"
            }
            else if row == 1 {
                self.orgCd = "4500000"
            }
            else if row == 2 {
                self.orgCd = "4550000"
            }
            else if row == 3 {
                self.orgCd = "4540000"
            }
            else if row == 4 {
                self.orgCd = "5680000"
            }
            else if row == 5 {
                self.orgCd = "4510000"
            }
            else if row == 6 {
                self.orgCd = "4570000"
            }
            else if row == 7 {
                self.orgCd = "4530000"
            }
            else if row == 8 {
                self.orgCd = "4580000"
            }
            else if row == 9 {
                self.orgCd = "4520000"
            }
            else if row == 10 {
                self.orgCd = "4560000"
            }
            else if row == 11 {
                self.orgCd = "4610000"
            }
            else if row == 12 {
                self.orgCd = "4490000"
            }
            else if row == 13 {
                self.orgCd = "4590000"
            }
            else if row == 14 {
                self.orgCd = "4620000"
            }
            else if row == 15 {
                self.orgCd = "4600000"
            }
        }
            
        else if uprCd == "6450000" { // 전라북도
            if row == 0 {
                self.orgCd = "4780000"
            }
            else if row == 1 {
                self.orgCd = "4670000"
            }
            else if row == 2 {
                self.orgCd = "4710000"
            }
            else if row == 3 {
                self.orgCd = "4700000"
            }
            else if row == 4 {
                self.orgCd = "4740000"
            }
            else if row == 5 {
                self.orgCd = "4790000"
            }
            else if row == 6 {
                self.orgCd = "4770000"
            }
            else if row == 7 {
                self.orgCd = "4720000"
            }
            else if row == 8 {
                self.orgCd = "4680000"
            }
            else if row == 9 {
                self.orgCd = "4760000"
            }
            else if row == 10 {
                self.orgCd = "4750000"
            }
            else if row == 11 {
                self.orgCd = "4640000"
            }
            else if row == 12 {
                self.orgCd = "4690000"
            }
            else if row == 13 {
                self.orgCd = "4730000"
            }
        }
            
        else if uprCd == "6460000" { // 전라남도
            if row == 0 {
                self.orgCd = "4920000"
            }
            else if row == 1 {
                self.orgCd = "4880000"
            }
            else if row == 2 {
                self.orgCd = "4860000"
            }
            else if row == 3 {
                self.orgCd = "4840000"
            }
            else if row == 4 {
                self.orgCd = "4870000"
            }
            else if row == 5 {
                self.orgCd = "4830000"
            }
            else if row == 6 {
                self.orgCd = "4850000"
            }
            else if row == 7 {
                self.orgCd = "4800000"
            }
            else if row == 8 {
                self.orgCd = "4950000"
            }
            else if row == 9 {
                self.orgCd = "4890000"
            }
            else if row == 10 {
                self.orgCd = "4820000"
            }
            else if row == 11 {
                self.orgCd = "5010000"
            }
            else if row == 12 {
                self.orgCd = "4810000"
            }
            else if row == 13 {
                self.orgCd = "4970000"
            }
            else if row == 14 {
                self.orgCd = "4940000"
            }
            else if row == 15 {
                self.orgCd = "4990000"
            }
            else if row == 16 {
                self.orgCd = "4980000"
            }
            else if row == 17 {
                self.orgCd = "4910000"
            }
            else if row == 18 {
                self.orgCd = "5000000"
            }
            else if row == 19 {
                self.orgCd = "4960000"
            }
            else if row == 20 {
                self.orgCd = "4930000"
            }
            else if row == 21 {
                self.orgCd = "4900000"
            }
        }
            
        else if uprCd == "6470000" { // 경상북도
            if row == 0 {
                self.orgCd = "5130000"
            }
            else if row == 1 {
                self.orgCd = "5050000"
            }
            else if row == 2 {
                self.orgCd = "5200000"
            }
            else if row == 3 {
                self.orgCd = "5080000"
            }
            else if row == 4 {
                self.orgCd = "5140000"
            }
            else if row == 5 {
                self.orgCd = "5060000"
            }
            else if row == 6 {
                self.orgCd = "5120000"
            }
            else if row == 7 {
                self.orgCd = "5240000"
            }
            else if row == 8 {
                self.orgCd = "5110000"
            }
            else if row == 9 {
                self.orgCd = "5210000"
            }
            else if row == 10 {
                self.orgCd = "5070000"
            }
            else if row == 11 {
                self.orgCd = "5180000"
            }
            else if row == 12 {
                self.orgCd = "5170000"
            }
            else if row == 13 {
                self.orgCd = "5090000"
            }
            else if row == 14 {
                self.orgCd = "5100000"
            }
            else if row == 15 {
                self.orgCd = "5230000"
            }
            else if row == 16 {
                self.orgCd = "5260000"
            }
            else if row == 17 {
                self.orgCd = "5250000"
            }
            else if row == 18 {
                self.orgCd = "5150000"
            }
            else if row == 19 {
                self.orgCd = "5190000"
            }
            else if row == 20 {
                self.orgCd = "5160000"
            }
            else if row == 21 {
                self.orgCd = "5220000"
            }
            else if row == 22 {
                self.orgCd = "5020000"
            }
        }
            
        else if uprCd == "6480000" { // 경상남도
            if row == 0 {
                self.orgCd = "5370000"
            }
            else if row == 1 {
                self.orgCd = "5470000"
            }
            else if row == 2 {
                self.orgCd = "5420000"
            }
            else if row == 3 {
                self.orgCd = "5350000"
            }
            else if row == 4 {
                self.orgCd = "5430000"
            }
            else if row == 5 {
                self.orgCd = "5360000"
            }
            else if row == 6 {
                self.orgCd = "5340000"
            }
            else if row == 7 {
                self.orgCd = "5450000"
            }
            else if row == 8 {
                self.orgCd = "5380000"
            }
            else if row == 9 {
                self.orgCd = "5390000"
            }
            else if row == 10 {
                self.orgCd = "5310000"
            }
            else if row == 11 {
                self.orgCd = "5410000"
            }
            else if row == 12 {
                self.orgCd = "5280000"
            }
            else if row == 13 {
                self.orgCd = "5670000"
            }
            else if row == 14 {
                self.orgCd = "5320000"
            }
            else if row == 15 {
                self.orgCd = "5330000"
            }
            else if row == 16 {
                self.orgCd = "5440000"
            }
            else if row == 17 {
                self.orgCd = "5400000"
            }
            else if row == 18 {
                self.orgCd = "5460000"
            }
            else if row == 19 {
                self.orgCd = "5480000"
            }
        }
        else if uprCd == "6500000" { // 제주특별시
            if row == 0 {
                self.orgCd = "6520000"
            }
            else if row == 1 {
                self.orgCd = "6510000"
            }
            else if row == 2 {
                self.orgCd = "6500000"
            }
        }
    }



}
