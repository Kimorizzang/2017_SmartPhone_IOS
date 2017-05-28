//
//  ViewController_CatImage.swift
//  NyangNyang
//
//  Created by kpugame on 2017. 5. 28..
//  Copyright © 2017년 시현 김. All rights reserved.
//

import UIKit

class ViewController_CatImage: UIViewController, XMLParserDelegate {

    @IBOutlet weak var taData: UITableView!
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var url = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?"
    //upr_cd=6110000&org_cd=3240000&care_reg_no=311324201600002
    var key = "&pageNo=1&numOfRows=20&ServiceKey=3n0ay%2Fk%2BocRtQBOiPEJNJ7hJNqBuoC1%2F2d%2BQY7GDxFynWHRxFJJM2Hm1MYFTyoe%2BVswgU6XVD%2BuDqwrOXOVUjA%3D%3D"
    var resultUrl = ""
    var uprCd : String = ""
    var orgCd : String = ""
    var careRegNo : String = ""
    
    var imageurl = NSMutableString()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beginParsing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func beginParsing()
    {
        posts = []
        
        //url = url + "upr_cd=" + self.uprCd + "&org_cd=" + self.orgCd + "&care_reg_no=" + self.careRegNo + key
        resultUrl = url + "upr_cd=" + self.uprCd + "&org_cd=" + self.orgCd + key
        
        parser = XMLParser(contentsOf:(URL(string:resultUrl))!)!
        parser.delegate = self
        parser.parse()
        taData!.reloadData()
        
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            imageurl = NSMutableString()
            imageurl = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String!)
    {
        if element.isEqual(to: "popfile"){
            imageurl.append(string)
            print(imageurl)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String!, namespaceURI: String!, qualifiedName qName: String!)
    {
        if (elementName as NSString).isEqual(to: "item")
        {
            if !imageurl.isEqual(nil)
            {
                elements.setObject(imageurl, forKey: "popfile" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CatCell")!
        if(cell.isEqual(NSNull)) {
            cell = Bundle.main.loadNibNamed("CatCell", owner: self, options: nil)?[0] as! UITableViewCell
        }
        
        if let url = URL(string: (posts.object(at: indexPath.row) as AnyObject).value(forKey: "popfile") as! NSString as String) {
            if let data = try? Data(contentsOf: url) {
                cell.imageView!.image = UIImage(data: data)
            }
        }
        
        return cell as UITableViewCell
    }
}
