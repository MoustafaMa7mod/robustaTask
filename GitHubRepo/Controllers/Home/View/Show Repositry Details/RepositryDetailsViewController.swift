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
    @IBOutlet weak var repoName: UILabel!
    @IBOutlet weak var repoFullName: UILabel!
    @IBOutlet weak var repoDescription: UILabel!
    
    // MARK: - varaibles
    var repositoryDetailsViewModel: RepositoryDetailsViewModel?
    
    // MARK:- main functions
    override func viewDidLoad() {
        super.viewDidLoad()
        showRepositryDetails()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain , target: self, action: #selector(dismissDetails))

    }
    
    class func instantiate() -> RepositryDetailsViewController {
        return UIStoryboard(name: "RepositoriesViewController", bundle: nil).instantiateViewController(withIdentifier: String(describing: self)) as! RepositryDetailsViewController
    }
    
    @objc func dismissDetails(){
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK:- show data of each repositry
    private func showRepositryDetails(){
        guard let avterImage = NSURL(string: repositoryDetailsViewModel?.repositryDetails.ownerAvaterUrl ?? "") else {
            return
        }
        ownerImage.downloadImage(url: avterImage)
        ownerName.text = repositoryDetailsViewModel?.repositryDetails.ownerName
        repoName.text = repositoryDetailsViewModel?.repositryDetails.repositoryName
        repoFullName.text = repositoryDetailsViewModel?.repositryDetails.repositoryFullName
        repoDescription.text = repositoryDetailsViewModel?.repositryDetails.repositryDescription
    }
    
}

