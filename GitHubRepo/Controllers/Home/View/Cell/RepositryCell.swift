//
//  RepositryCell.swift
//  GitHubRepo
//
//  Created by Mostafa Mahmoud on 4/29/21.
//

import UIKit

class RepositryCell: UITableViewCell {

    @IBOutlet weak var repositryNameLabel: UILabel!
    @IBOutlet weak var reposityOwnerNameLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var repositryOwnerImage: UIImageView!
    
    var creationData: String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        let result = formatter.string(from: date)
        return result
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configCell(_ data: Repository) {
        self.repositryNameLabel.text = data.repositoryName
        self.reposityOwnerNameLabel.text = data.ownerName
        self.creationDateLabel.text = creationData
        guard let avterImage = NSURL(string: data.ownerAvaterUrl ?? "") else {
            return
        }
        self.repositryOwnerImage.downloadImage(url: avterImage)
    }
}
