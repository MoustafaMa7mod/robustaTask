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
    var isStartPagination = false
    var searchWord: String = ""
    
    // MARK:- main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewConfig()
        searchBarConfig()
        loadData()

    }
    
    // MARK:- table view setting
    private func tableViewConfig(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        tableView.registerCellNib(cellClass: RepositryCell.self)
    }
    
    // MARK:- search controller setting
    private func searchBarConfig(){
        let searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Repositry"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }
    
    // MARK:- get data to show in table view
     func loadData(){
        repositoryViewModel.getDataFromAPI { [weak self] errorMessage in
            if let message = errorMessage {
                DispatchQueue.main.async {
                    self?.showAlertError(message)
                }
            }
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func showAlertError(_ message: String){
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)

    }
}

// MARK:- start search
extension RepositoriesViewController: UISearchControllerDelegate , UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = (searchController.searchBar.text ?? "")
        searchWord = searchText
        self.repositoryViewModel.searchRepositryName(searchText)
        self.tableView.reloadData()
    }
}
