//
//  RepositryDetailsViewController.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/29/21.
//

import UIKit

class RepositryDetailsViewController: UIViewController {
    
    // MARK: - outlets
    @IBOutlet weak var ownerImage: UIImageView!
    @IBOutlet weak var ownerName: UILabel!
    @IBOutlet weak var repoNaeme: UILabel!
    @IBOutlet weak var repoFullName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    
    // MARK: - varaibles
    var repositoryDetailsViewModel: RepositoryDetailsViewModel?
    
    // MARK:- main functions
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    class func instantiate() -> RepositryDetailsViewController {
        return UIStoryboard(name: "RepositoriesViewController", bundle: nil).instantiateViewController(withIdentifier: String(describing: self)) as! RepositryDetailsViewController
    }
}

