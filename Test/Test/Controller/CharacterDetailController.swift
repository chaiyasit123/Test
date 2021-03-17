//
//  CharacterDetailController.swift
//  Test
//
//  Created by S-Planet01 on 17/3/2564 BE.
//  Copyright © 2564 S-Planet. All rights reserved.
//

import UIKit

class CharacterDetailController: UIViewController {
    
    @IBOutlet weak var coverImage: ImageView!
    @IBOutlet weak var nameLabel: Label!
    @IBOutlet weak var statusLabel: Label!
    @IBOutlet weak var speciesLabel: Label!
    @IBOutlet weak var typeLabel: Label!
    @IBOutlet weak var genderLabel: Label!
    
    public var data: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initWidget()
    }
    
    private func initWidget() {
        coverImage.sd_setImage(with: URL(string: data.imageUrl), completed: nil)
        nameLabel.text = "Name : \(data.name!)"
        statusLabel.text = "Status : \(data.status!)"
        speciesLabel.text = "Species : \(data.species!)"
        typeLabel.text = "Type : \(data.type!)"
        genderLabel.text = "Gender : \(data.gender!)"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
