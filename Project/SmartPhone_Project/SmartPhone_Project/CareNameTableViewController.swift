//
//  CareNameTableViewController.swift
//  NyangNyang
//
//  Created by kpugame on 2017. 5. 20..
//  Copyright © 2017년 시현 김. All rights reserved.
//

import UIKit

class CareNameTableViewController: UITableViewController, XMLParserDelegate {

    @IBOutlet var taData: UITableView!
    
    var uprCd : String = ""
    var orgCd : String = ""
    
    var careAddr = ""
    var careAddr_utf8 = ""
    var careTel = ""
    
    var url : String = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/shelter?upr_cd="
    //"6110000&org_cd=3220000"
    
    var key : String = "&ServiceKey=3n0ay%2Fk%2BocRtQBOiPEJNJ7hJNqBuoC1%2F2d%2BQY7GDxFynWHRxFJJM2Hm1MYFTyoe%2BVswgU6XVD%2BuDqwrOXOVUjA%3D%3D"

    var parser = XMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    // 저장 문자열 변수
    var careNm = NSMutableString()
    var careRegNo = NSMutableString()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.taData.dataSource = self
        self.taData.delegate = self
        
        beginParsing()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any!) {
 
            if segue.identifier == "segueToCatImageUrlViewController" {

                if let viewController_CatImage = segue.destination as? ViewController_CatImage {
                    viewController_CatImage.orgCd = self.orgCd
                    viewController_CatImage.uprCd = self.uprCd
                    }
                }
                
                /*
                if let detailCareTableViewController = segue.destination as? DetailCareTableViewController {
                    detailCareTableViewController.orgCd = self.orgCd
                    detailCareTableViewController.uprCd = self.uprCd
                    detailCareTableViewController.careRegNo = self.careRegNo as String
                }
                 */
            
        
        }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        if(cell.isEqual(NSNull.self)) {
            cell = Bundle.main.loadNibNamed("Cell", owner: self, options: nil)?[0] as! UITableViewCell
        }
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "careNm") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "careRegNo") as! NSString as String
        return cell as UITableViewCell
    }
    
    func beginParsing()
    {
        url = url + uprCd + "&org_cd=" + orgCd + key
        posts = []
        parser = XMLParser(contentsOf: (URL(string:url))!)!
        parser.delegate = self
        parser.parse()
        taData.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            careNm = NSMutableString()
            careNm = ""
            careRegNo = NSMutableString()
            careRegNo = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "careNm"){
            careNm.append(string)
        }
        else if element.isEqual(to: "careRegNo"){
            careRegNo.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?)
    {
        if (elementName as NSString).isEqual(to: "item")
        {
            if !careNm.isEqual(to: "item")
            {
                elements.setObject(careNm, forKey: "careNm" as NSCopying)
            }
            if !careRegNo.isEqual(to: "item")
            {
                elements.setObject(careRegNo, forKey: "careRegNo" as NSCopying)
            }
        
            posts.add(elements)
        }
    }

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
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
