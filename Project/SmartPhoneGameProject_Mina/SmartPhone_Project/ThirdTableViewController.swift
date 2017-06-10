//
//  ThirdTableViewController.swift
//  SmartPhone_Project
//
//  Created by KPUGame on 2017. 6. 3..
//  Copyright © 2017년 KPUGame. All rights reserved.
//

import UIKit

class ThirdTableViewController: UITableViewController, XMLParserDelegate {

    @IBOutlet var nData: UITableView!
    var list1: [NSMutableString] = []
    
    var url1:String = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?serviceKey=3n0ay%2Fk%2BocRtQBOiPEJNJ7hJNqBuoC1%2F2d%2BQY7GDxFynWHRxFJJM2Hm1MYFTyoe%2BVswgU6XVD%2BuDqwrOXOVUjA%3D%3D&bgnde=20160101&endde=20170601&upkind=422400&upr_cd="
    
    var uprCd:String!
    
    var url2:String = "&org_cd="
    
    var orgCd:String!
    
    var url3:String = "&state=notice&pageNo=1&startPage=1&numOfRows=10&pageSize=10"
    
    var parser = XMLParser()
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var happenPlace = NSMutableString()
    var happenDate = NSMutableString()
    
    var profile = NSMutableString() // 고양이사진
    
    var indexNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        beginParsing()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beginParsing()
    {
        url1 = url1 + uprCd + url2 + orgCd + url3
        posts = []
        parser = XMLParser(contentsOf:(URL(string:url1))!)!
        parser.delegate = self
        parser.parse()
        nData!.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any!){
        if segue.identifier == "Nang3" {
            if let catTMIVeiwController = segue.destination as? CatTMIVeiwControllerViewController {
                catTMIVeiwController.url = url1 + uprCd + url2 + orgCd + url3
                catTMIVeiwController.backProfile = list1[indexNum] as String
                catTMIVeiwController.indexNum = indexNum
            }
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
            happenPlace = NSMutableString()
            happenPlace = ""
            happenDate = NSMutableString()
            happenDate = ""
            
            profile = NSMutableString()
            profile = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String!)
    {
        if element.isEqual(to: "happenPlace") {
            happenPlace.append(string)
        } else if element.isEqual(to: "happenDt") {
            happenDate.append(string)
        } else if element.isEqual(to: "popfile") {
            profile.append(string)
            list1.append(profile)
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
            posts.add(elements)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)->Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example
        
        indexNum = (indexPath?.row)!
        
        self.performSegue(withIdentifier: "Nang3", sender: self)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        
        if(cell.isEqual(NSNull.self)) {
            cell = Bundle.main.loadNibNamed("Cell", owner: self, options: nil)?[0] as! UITableViewCell;
        }
        
        cell.textLabel?.text = "발견장소 : \((posts[indexPath.row] as AnyObject).value(forKey: "happenPlace") as! NSString as String)"
        cell.detailTextLabel?.text = "발견일자 : \((posts[indexPath.row] as AnyObject).value(forKey: "happenDt") as! NSString as String)"
        
        if let url = URL(string: (posts.object(at: indexPath.row) as AnyObject).value(forKey: "popfile") as! NSString as String) {
            if let data = try? Data(contentsOf: url) {
                cell.imageView!.image = UIImage(data: data)
            }
        }
        
        return cell as UITableViewCell
    }
}
