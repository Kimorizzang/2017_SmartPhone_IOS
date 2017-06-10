//
//  DetailCareTableViewController.swift
//  NyangNyang
//
//  Created by kpugame on 2017. 5. 26..
//  Copyright © 2017년 시현 김. All rights reserved.
//

import UIKit

class DetailCareTableViewController: UITableViewController, XMLParserDelegate {

    @IBOutlet var detailTableView: UITableView!
    
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
    var posts : [String] = ["","","","","","",""]
    
    var element = NSString()
    var happenPlace = NSMutableString()
    var happenDt = NSMutableString()
    var age = NSMutableString()
    var sexCd = NSMutableString()
    var weight = NSMutableString()
    var neuterYn = NSMutableString()
    var specialMark = NSMutableString()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beginParsing()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return postName.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "CareCell")!
        if(cell.isEqual(NSNull.self)) {
            cell = Bundle.main.loadNibNamed("CareCell", owner: self, options: nil)?[0] as! UITableViewCell
        }
        cell.textLabel?.text = postName[indexPath.row]
        cell.detailTextLabel?.text = posts[indexPath.row]
        return cell as UITableViewCell
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
        detailTableView.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        element = elementName as NSString
        if (element as NSString).isEqual(to: "item")
        {
            posts = ["","","","","","",""]
            
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
            
        }
    }
    
    func parser(_ parser:XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "happenPlace"){
            happenPlace.append(string)
            print(happenPlace)
        }
        else if element.isEqual(to: "happenDt"){
            happenDt.append(string)
        }
        else if element.isEqual(to: "age") {
            age.append(string)
        }
        else if element.isEqual(to: "sexCd") {
            sexCd.append(string)
        }
        else if element.isEqual(to: "weight") {
            weight.append(string)
        }
        else if element.isEqual(to: "neuterYn") {
            neuterYn.append(string)
        }
        else if element.isEqual(to: "specialMark") {
            specialMark.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?,qualifiedName qName: String?) {
        if (element as NSString).isEqual(to: "item") {
            if !happenPlace.isEqual(nil) {
                posts[0] = happenPlace as String
            }
            if !happenDt.isEqual(nil) {
                posts[1] = happenDt as String
            }
            if !age.isEqual(nil) {
                posts[2] = age as String
            }
            if !sexCd.isEqual(nil) {
                posts[3] = sexCd as String
            }
            if !weight.isEqual(nil) {
                posts[4] = weight as String
            }
            if !neuterYn.isEqual(nil)
            {
                posts[5] = neuterYn as String
            }
            if !specialMark.isEqual(nil) {
                posts[6] = specialMark as String
            }
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a vvv cc   vvvvvvv  new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
