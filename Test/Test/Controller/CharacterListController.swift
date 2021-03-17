//
//  characterListController.swift
//  Test
//
//  Created by S-Planet01 on 17/3/2564 BE.
//  Copyright © 2564 S-Planet. All rights reserved.
//

import UIKit
import SDWebImage
import MRProgress

class CharacterListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var dataView: UITableView!
    
    public var dataList: [Character]!
    
    public var seletedPosition = 0
    
    private var progressOverlayView: MRProgressOverlayView!

    override func viewDidLoad() {
        super.viewDidLoad()
        requestCharacterList()
    }
    
    // MARK: - UITableView datasource & delegate
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList == nil ? 0 : dataList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = "CharacterCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath as IndexPath) as! CharacterCell
        let data = dataList[indexPath.row]
        
        cell.coverImage.sd_setImage(with: URL(string: data.imageUrl), completed: nil)
                 
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        seletedPosition = indexPath.row
        
        //  Change controller
        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    
    // MARK: - Request api
    
    func requestCharacterList() {
        //  Start reques
        let connection = ConnectionPrompt(url: WebAPI.character)
        connection.requestMethod = "GET"
        connection.onComplete({ (result) -> Void in
            let resultData = result.data(using: String.Encoding.utf8)
            let json = JSON(data: resultData!, options: JSONSerialization.ReadingOptions(rawValue: 0), error: nil)
            if self.dataList == nil {
                self.dataList = []
            } else {
                self.dataList.removeAll()
            }
            
            let resultsJArr = json["results"].arrayValue
            if resultsJArr.count > 0 {
                for i in 0..<resultsJArr.count {
                    let resultJObj = resultsJArr[i]
                    let name = resultJObj["name"].stringValue
                    let status = resultJObj["status"].stringValue
                    let species = resultJObj["species"].stringValue
                    let type = resultJObj["type"].stringValue
                    let gender = resultJObj["gender"].stringValue
                    let imageUrl = resultJObj["image"].stringValue
                    
                    //  Create instance
                    let data = Character()
                    data.name = name
                    data.status = status
                    data.species = species
                    data.type = type
                    data.gender = gender
                    data.imageUrl = imageUrl
        
                    //  Add to list
                    self.dataList.append(data)
                }
                
                //  Reload data
                self.dataView.reloadData()
            }
            
            //  Dismiss dialog
            self.progressOverlayView.dismiss(true)
        })
        connection.onLostConnection({ () -> Void in
            //  Dismiss dialog
            self.progressOverlayView.dismiss(true)
        
            //  Show alert
            AlertDialog().show(title: "dialog_error_title".localized()
                , message: "network_lost_connection".localized()
                , callback: {_ in})
        })
        connection.execute()
        //  Show indicator
        self.progressOverlayView = MRProgressOverlayView.showOverlayAdded(to: self.view
            , title: ""
            , mode: .indeterminateSmall
            , animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let data = dataList[seletedPosition]
            let controller = segue.destination as! CharacterDetailController
            controller.data = data
        }
    }
}

// MARK: - UITableViewCell

class CharacterCell: UITableViewCell {
    
    @IBOutlet var coverImage: ImageView!
    
}


class Character {
    
    var name: String! = ""
    var status: String! = ""
    var species: String! = ""
    var type: String! = ""
    var gender: String! = ""
    var imageUrl: String! = ""
    
}

