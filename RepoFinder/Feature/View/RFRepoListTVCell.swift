//
//  RFRepoListTVCell.swift
//  RepoFinder
//
//  Created by Amit Sarker on 15/6/23.
//

import UIKit

class RFRepoListTVCell: UITableViewCell {

    @IBOutlet weak private var OwnerNameLabel: UILabel!
    @IBOutlet weak private var repoNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        layoutIfNeeded()
        contentView.layer.borderColor = UIColor.darkGray.cgColor
        contentView.layer.borderWidth = 2
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    func configure(repoName: String?, ownerName: String?){
        if let repoName = repoName {
            repoNameLabel.text = repoName
        }else {
            repoNameLabel.text = ErrorMessages.repoNameNotFound
        }
        if let ownerName = ownerName {
            OwnerNameLabel.text = ownerName
        }else {
            OwnerNameLabel.text = ErrorMessages.ownerNameNotFound
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
