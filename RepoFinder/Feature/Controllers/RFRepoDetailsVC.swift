//
//  RFRepoDetailsVC.swift
//  RepoFinder
//
//  Created by Amit Sarker on 15/6/23.
//

import UIKit

class RFRepoDetailsVC: UIViewController {
    //MARK: Variables
    var viewModel : RFRepoFinderVM? 
    
    //MARK: IBOutlets
    @IBOutlet weak private var repoNameLabel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    @IBOutlet weak private var starCountLabel: UILabel!
    @IBOutlet weak private var forkCountLabel: UILabel!
    @IBOutlet weak private var openIssueCountLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak private var avatarImage: UIImageView!
    
    //MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setStyle()
        setData()
    }
    
    //MARK: IBActions
}


//MARK:  Helpers
extension RFRepoDetailsVC {
    private func setStyle(){
        navigationItem.title = "Repo Details"
        avatarImage.layer.cornerRadius = avatarImage.bounds.height / 2
    }
    private func setData(){
        guard let vm = viewModel, vm.repoSearchList.count > vm.selectedSearchIndex else {return}
        let repo = vm.repoSearchList [ vm.selectedSearchIndex ]
        setOptionalStr(label: repoNameLabel, str: repo.name)
        setOptionalStr(label: descriptionLabel, str: repo.description)
        setOptionalStr(label: userNameLabel, str: repo.owner?.login)
        
        setOptionalStr(label: starCountLabel, frontStr: "Star: ", int: repo.stargazers_count)
        setOptionalStr(label: forkCountLabel, frontStr: "Fork: ",int:  repo.forks_count)
        setOptionalStr(label: openIssueCountLabel, frontStr: "Open Issue: ", int: repo.open_issues_count)
        
        
        if let url = URL(string: repo.owner?.avatar_url ?? "" ) {
            let data = try? Data(contentsOf: url)
            avatarImage.image = UIImage(data: data!)
        }

    }
    private func setOptionalStr(label: UILabel, frontStr: String = "", str: String? = nil, int: Int? = nil){
        if let str = str {
            label.text = frontStr + str
        }
        if let int = int {
            label.text = frontStr + String(int)
        }
    }
}

//MARK: Naigation Functionalites
extension RFRepoDetailsVC {
    
}
