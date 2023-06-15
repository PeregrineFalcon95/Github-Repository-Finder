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
    @IBOutlet weak private var userNameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    //MARK: View Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setStyle()
        setData()
    }
    
    //MARK: IBActions
    @IBAction private func openCommitPressed(_ sender: UIButton) {
        showAlert(msg: "Under Development")
    }
    
    deinit {
        debugPrint("RFRepoDetailsVC Deinit called")
    }
}


//MARK:  Helpers
extension RFRepoDetailsVC {
    private func setStyle(){
        navigationItem.title = "Repo Details"
        avatarImageView.layer.cornerRadius = avatarImageView.bounds.height / 2
        
        userNameLabel.isUserInteractionEnabled = true
        avatarImageView.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onUserTapped))
        let tapGestureTwo = UITapGestureRecognizer(target: self, action: #selector(onUserTapped))
        userNameLabel.addGestureRecognizer(tapGesture)
        avatarImageView.addGestureRecognizer(tapGestureTwo)
        
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
        
        //Note: Would do that with SDWebImage, but tried to do everything without SDK and Using URLsession will take time
        if let url = URL(string: repo.owner?.avatar_url ?? "" ) {
            DispatchQueue.global().async{
                guard let data = try? Data(contentsOf: url) else {return}
                DispatchQueue.main.async {
                    self.avatarImageView.image = UIImage(data: data)
                }
            }
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
    @objc func onUserTapped() {
        showAlert(msg: "Under Development!")
    }    
}

//MARK: Naigation Functionalites
extension RFRepoDetailsVC {
    
}
