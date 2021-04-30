//
//  RepositoriesVC+Pagination.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/30/21.
//

import Foundation
import UIKit

extension RepositoriesViewController {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.isStartPagination = false
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height){
            if searchWord.count != 0 {
                self.repositoryViewModel.loadDataWithPredicate(searchWord)
                self.tableView.reloadData()
                return
            }
            if !isStartPagination{
                isStartPagination = true
                self.repositoryViewModel.loadModreData()
                self.tableView.reloadData()
            }
        }
    }
    
}
