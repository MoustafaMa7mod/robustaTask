//
//  ViewController.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/28/21.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Networking.shared.getData { loadData in
            print("load data from api")
        }
        
        
    }

    @IBAction func getData(_ sender: Any) {
        print(CoreDataManager.shared.fetchAllData())
    }
    

}

