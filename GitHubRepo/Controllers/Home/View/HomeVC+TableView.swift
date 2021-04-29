//
//  HomeVC+TableView.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/29/21.
//

import Foundation
import UIKit


extension HomeViewController: UITableViewDataSource , UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.homeViewModel.getCountOfRepositryArray()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue() as RepositryCell
        let object = self.homeViewModel.getDetailsOfEachRepositry(indexPath.row)
        cell.configCell(object)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115
    }
  
    
}
