//
//  CatTMIVeiwControllerViewController.swift
//  SmartPhone_Project
//
//  Created by KPUGame on 2017. 6. 3..
//  Copyright © 2017년 KPUGame. All rights reserved.
//

import UIKit

class CatTMIVeiwControllerViewController: UIViewController, XMLParserDelegate  {
    
    @IBOutlet weak var catImage: UIImageView!
    
    @IBOutlet weak var catInfo: UILabel!
    
    var url:String!
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var elementBack = NSString()
    
    var backProfile:String!
    
    var happenPlace = NSMutableString()
    var happenDate = NSMutableString()
    
    var profile = NSMutableString() // 고양이사진
    
    //----------------------------------------------------------
    var careNm = NSMutableString()
    var careTel = NSMutableString()
    
    var kindCd = NSMutableString()
    var colorCd = NSMutableString()
    var age = NSMutableString()
    var weight = NSMutableString()
    var sexCd = NSMutableString()
    var specialMark = NSMutableString()
    //----------------------------------------------------------
    
    var indexNum:Int!
    
    var listHP: [NSMutableString] = []
    var listHD: [NSMutableString] = []
    var listPOP: [NSMutableString] = []
    var listCN: [NSMutableString] = []
    var listCT: [NSMutableString] = []
    var listKC: [NSMutableString] = []
    var listCC: [NSMutableString] = []
    var listAge: [NSMutableString] = []
    var listWeight: [NSMutableString] = []
    var listSex: [NSMutableString] = []
    var listSM: [NSMutableString] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        // Do any additional setup after loading the view
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf:(URL(string:url))!)!
        parser.delegate = self
        parser.parse()
        
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            happenPlace = NSMutableString()
            happenPlace = ""
            happenDate = NSMutableString()
            happenDate = ""
            
            profile = NSMutableString()
            profile = ""
            
            careNm = NSMutableString()
            careNm = ""
            careTel = NSMutableString()
            careTel = ""
            
            kindCd = NSMutableString()
            kindCd = ""
            colorCd = NSMutableString()
            colorCd = ""
            age = NSMutableString()
            age = ""
            weight = NSMutableString()
            weight = ""
            sexCd = NSMutableString()
            sexCd = ""
            specialMark = NSMutableString()
            specialMark = ""
        }
    }
    
    
    func parser(_ parser: XMLParser, foundCharacters string: String!)
    {
            if element.isEqual(to: "happenPlace") {
                happenPlace.append(string)
                listHP.append(happenPlace)
            } else if element.isEqual(to: "happenDt") {
                happenDate.append(string)
                listHD.append(happenDate)
            } else if element.isEqual(to: "popfile") {
                profile.append(string)
                listPOP.append(profile)
            } else if element.isEqual(to: "careNm") {
                careNm.append(string)
                listCN.append(careNm)
            } else if element.isEqual(to: "careTel") {
                careTel.append(string)
                listCT.append(careTel)
            } else if element.isEqual(to: "kindCd") {
                kindCd.append(string)
                listKC.append(kindCd)
            } else if element.isEqual(to: "colorCd") {
                colorCd.append(string)
                listCC.append(colorCd)
            } else if element.isEqual(to: "age") {
                age.append(string)
                listAge.append(age)
            } else if element.isEqual(to: "weight") {
                weight.append(string)
                listWeight.append(weight)
            } else if element.isEqual(to: "sexCd") {
                sexCd.append(string)
                listSex.append(sexCd)
            } else if element.isEqual(to: "specialMark") {
                specialMark.append(string)
                listSM.append(specialMark)
            }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if (elementName as NSString).isEqual(to: "item") {
                if !happenPlace.isEqual(nil) {
                    elements.setObject(happenPlace, forKey: "happenPlace" as NSCopying)
                }
                if !happenDate.isEqual(nil) {
                    elements.setObject(happenDate, forKey: "happenDt" as NSCopying)
                }
                if !profile.isEqual(nil) {
                    elements.setObject(profile, forKey: "popfile" as NSCopying)
                }
                if !careNm.isEqual(nil) {
                    elements.setObject(careNm, forKey: "careNm" as NSCopying)
                }
                if !careTel.isEqual(nil) {
                    elements.setObject(careTel, forKey: "careTel" as NSCopying)
                }
                if !kindCd.isEqual(nil) {
                    elements.setObject(kindCd, forKey: "kindCd" as NSCopying)
                }
                if !colorCd.isEqual(nil) {
                    elements.setObject(colorCd, forKey: "colorCd" as NSCopying)
                }
                if !age.isEqual(nil) {
                    elements.setObject(age, forKey: "age" as NSCopying)
                }
                if !weight.isEqual(nil) {
                    elements.setObject(weight, forKey: "weight" as NSCopying)
                }
                if !sexCd.isEqual(nil) {
                    elements.setObject(sexCd, forKey: "sexCd" as NSCopying)
                }
                if !specialMark.isEqual(nil) {
                    elements.setObject(specialMark, forKey: "specialMark" as NSCopying)
                }
                posts.add(elements)
            }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        beginParsing()
        
        if let ImageUrl = URL(string: listPOP[indexNum] as String!) {
            if let data = try? Data(contentsOf: ImageUrl) {
                catImage.image = UIImage(data: data)
                catImage.image = resizeImage(image: catImage.image!, newWidth: 150.0)
            }
        }
        
        catInfo.adjustsFontSizeToFitWidth = true
        catInfo.text = "보호소: " + (listCN[indexNum] as String!) + "\n보호소 번호: " + (listCT[indexNum] as String!)
            + "\n발견지역: " + (listHP[indexNum] as String!) + "\n발견일자: " + (listHD[indexNum] as String!)
            + "\n품종: " + (listKC[indexNum] as String!) + "\n색상: " + (listCC[indexNum] as String!) + "\n성별: " + (listSex[indexNum] as String!)
            + "\n추정나이: " + (listAge[indexNum] as String!) + "\n체중: " + (listWeight[indexNum] as String!) + "\n특징: " + (listSM[indexNum] as String!)
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

}
