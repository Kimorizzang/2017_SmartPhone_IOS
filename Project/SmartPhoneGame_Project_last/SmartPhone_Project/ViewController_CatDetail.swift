//
//  ViewController_CatDetail.swift
//  SmartPhone_Project
//
//  Created by kpugame on 2017. 6. 7..
//  Copyright © 2017년 KPUGame. All rights reserved.
//

import UIKit

class ViewController_CatDetail: UIViewController, XMLParserDelegate {

    @IBOutlet weak var detailText: UILabel!

    @IBOutlet weak var catImage: UIImageView!
    
    var resultUrl : String = ""
    var url = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?"
    var url2 : String = ""
    //upr_cd=6110000&org_cd=3240000&care_reg_no=311324201600002
    var key = "&pageNo=1&numOfRows=20&ServiceKey=3n0ay%2Fk%2BocRtQBOiPEJNJ7hJNqBuoC1%2F2d%2BQY7GDxFynWHRxFJJM2Hm1MYFTyoe%2BVswgU6XVD%2BuDqwrOXOVUjA%3D%3D"
    
    var uprCd : String = ""
    var orgCd : String = ""
    var careRegNo : String = ""
    
    var parser = XMLParser()
    let postName : [String] = ["발견지역","접수일","나이","성별","체중","중성화여부","특징"]
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    var happenPlace = NSMutableString()
    var happenPlaces: [NSMutableString] = []
    var happenDt = NSMutableString()
    var happenDts: [NSMutableString] = []
    var age = NSMutableString()
    var ages: [NSMutableString] = []
    var sexCd = NSMutableString()
    var sexCds: [NSMutableString] = []
    var weight = NSMutableString()
    var weights: [NSMutableString] = []
    var neuterYn = NSMutableString()
    var neuterYns: [NSMutableString] = []
    var specialMark = NSMutableString()
    var specialMarks: [NSMutableString] = []
    
    var imageUrl = NSMutableString()    // 비교하기 위한 이미지 유알엘 변수
    var imageUrls: [NSMutableString] = []
    
    var backProfile = NSMutableString()
    
    var selectedRow: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        beginParsing()
        
        
        if let ImageUrl = URL(string: backProfile as String!) {
            if let data = try? Data(contentsOf: ImageUrl) {
                catImage.image = UIImage(data: data)
                catImage.image = resizeImage(image: catImage.image!, newWidth: 150.0)
            }
        }
        
        detailText?.adjustsFontSizeToFitWidth = true
        detailText?.text = "발견 장소 : \(happenPlaces[selectedRow])\n접수일 : \(happenDts[selectedRow])\n나이 : \(ages[selectedRow])\n성별 : \(sexCds[selectedRow])\n체중 : \(weights[selectedRow])\n중성화 여부 : \(neuterYns[selectedRow])\n특징 : \(specialMarks[selectedRow])"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beginParsing()
    {
        posts = []
        url = url + "upr_cd=" + self.uprCd + "&org_cd=" + self.orgCd
        url2 = "&care_reg_no=" + self.careRegNo + key
        resultUrl = url + url2
        
        parser = XMLParser(contentsOf:(URL(string:resultUrl))!)!
        parser.delegate = self
        parser.parse()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName as NSString
        print(element)
        if (element as NSString).isEqual(to: "item")
        {
            
            happenPlace = NSMutableString()
            happenPlace = ""
            happenDt = NSMutableString()
            happenDt = ""
            age = NSMutableString()
            age = ""
            sexCd = NSMutableString()
            sexCd = ""
            weight = NSMutableString()
            weight = ""
            neuterYn = NSMutableString()
            neuterYn = ""
            specialMark = NSMutableString()
            specialMark = ""
            imageUrl = NSMutableString()
            imageUrl = ""
            
        }
    }
    
    func parser(_ parser:XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "happenPlace"){
            happenPlace.append(string)
            happenPlaces.append(happenPlace)
        }
        else if element.isEqual(to: "happenDt"){
            happenDt.append(string)
            happenDts.append(happenDt)
        }
        else if element.isEqual(to: "age") {
            age.append(string)
            ages.append(age)
        }
        else if element.isEqual(to: "sexCd") {
            sexCd.append(string)
            sexCds.append(sexCd)
        }
        else if element.isEqual(to: "weight") {
            weight.append(string)
            weights.append(weight)
        }
        else if element.isEqual(to: "neuterYn") {
            neuterYn.append(string)
            neuterYns.append(neuterYn)
        }
        else if element.isEqual(to: "specialMark") {
            specialMark.append(string)
            specialMarks.append(specialMark)
        }
        else if element.isEqual(to: "popfile"){
            imageUrl.append(string)
            imageUrls.append(imageUrl)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "item")
        {
            if imageUrl.isEqual(to: backProfile as String) {
                if !happenPlace.isEqual(nil) {
                    elements.setObject(happenPlace, forKey: "happenPlace" as NSCopying)
                }
                if !happenDt.isEqual(nil) {
                    elements.setObject(happenDt, forKey: "happenDt" as NSCopying)
                }
                if !imageUrl.isEqual(nil) {
                    elements.setObject(imageUrl, forKey: "popfile" as NSCopying)
                }
                if !age.isEqual(nil) {
                    elements.setObject(age, forKey: "age" as NSCopying)
                }
                if !sexCd.isEqual(nil) {
                    elements.setObject(sexCd, forKey: "sexCd" as NSCopying)
                }
                if !weight.isEqual(nil) {
                    elements.setObject(weight, forKey: "weight" as NSCopying)
                }
                if !neuterYn.isEqual(nil) {
                    elements.setObject(neuterYn, forKey: "neuterYn" as NSCopying)
                }
                
                if !specialMark.isEqual(nil) {
                    elements.setObject(specialMark, forKey: "specialMark" as NSCopying)
                }
                posts.add(elements)
            }
        }
        
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
