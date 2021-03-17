//
//  SplashController.swift
//  Test
//
//  Created by S-Planet01 on 17/3/2564 BE.
//  Copyright © 2564 S-Planet. All rights reserved.
//

import UIKit

class SplashController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        initWidget()
    }
    
    private func initWidget() {
        let rootController = storyboard!.instantiateViewController(withIdentifier: "CharacterListController")
        let controllerList = [rootController]
        
        self.setViewControllers(controllerList, animated: true)
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
