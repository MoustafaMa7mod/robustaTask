//
//  ViewController.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/28/21.
//

import UIKit

class HomeViewController: UIViewController {

    
    // MARK:- outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- varoiables
    var homeViewModel = HomeViewModel()
    
    
    // MARK:- main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
        loadData()
    }
    
    
    private func tableViewConfig(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerCellNib(cellClass: RepositryCell.self)
    }
    
    private func loadData(){
        homeViewModel.getDataFromAPI { [weak self] errorMessage in
            if let message = errorMessage {
                print(message)
            }
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    
    
    

//    @IBAction func getData(_ sender: Any) {
//        print(CoreDataManager.shared.fetchAllData())
//    }
    

}

