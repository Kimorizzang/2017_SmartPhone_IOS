//
//  ViewController.swift
//  NyangNyang
//
//  Created by kpugame on 2017. 5. 10..
//  Copyright © 2017년 시현 김. All rights reserved.
//

import UIKit

class ViewController_Sora: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerDataSource = ["서울특별시","부산광역시","대구광역시","인천광역시","광주광역시","세종특별자치시","대전광역시","울산광역시",
                            "경기도","강원도","충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주특별자치도"]
    
    var url : String = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/sigungu?upr_cd=6110000&ServiceKey="
    
    var  uprCd : String = "6110000" // 디폴트 = 서울특별시
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
        if segue.identifier == "segueToViewController" {
            if let guViewController = segue.destination as? GuViewController {
                guViewController.uprCd = uprCd
            }
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
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
            uprCd = "6420000"
        }
        else if row == 10 {
            uprCd = "6430000"
        }
        else if row == 11 {
            uprCd = "6440000"
        }
        else if row == 12 {
            uprCd = "6450000"
        }
        else if row == 13 {
            uprCd = "6460000"
        }
        else if row == 14 {
            uprCd = "6470000"
        }
        else if row == 15 {
            uprCd = "6480000"
        }
        else {
            uprCd = "6500000"
        }
    }

}

