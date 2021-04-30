//
//  ViewController.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/28/21.
//

import UIKit

class RepositoriesViewController: UIViewController {

    
    // MARK:- outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK:- varoiables
    var repositoryViewModel = RepositoryViewModel()
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    
    // MARK:- main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
        searchBarConfig()
        loadData()

    }
    private func tableViewConfig(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.prefetchDataSource = self
        tableView.tableFooterView = UIView()
        tableView.registerCellNib(cellClass: RepositryCell.self)
    }
    
    private func searchBarConfig(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Repositry"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }
    
    
     func loadData(){
        repositoryViewModel.getDataFromAPI { [weak self] errorMessage in
            if let message = errorMessage {
                print(message)
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }


}


extension RepositoriesViewController: UISearchControllerDelegate , UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = (searchController.searchBar.text ?? "")
        self.repositoryViewModel.searchRepositryName(searchText)
        self.tableView.reloadData()
    }
}
