//
//  ViewController.swift
//  RepoFinder
//
//  Created by Amit Sarker on 15/6/23.
//

import UIKit

class RFHomeVC: UIViewController {
    //MARK: Variables
    
    
    //MARK: IBOutlets
    @IBOutlet weak private var searchTextField: UITextField!
    @IBOutlet weak private var searchListTableView: UITableView!
    
    
    //MARK: View's Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
    }
    
    
    //MARK: IBActions
    @IBAction func searchPressed(_ sender: UIButton) {
    }
    

}

//MARK: UI Functionalities
extension RFHomeVC {
    
}


//MARK: TableView Functionalites
extension RFHomeVC : UITableViewDataSource, UITableViewDelegate{
    private func setTableView (){
        searchListTableView.dataSource = self
        searchListTableView.delegate = self
        searchListTableView.rowHeight = UITableView.automaticDimension
        searchListTableView.estimatedRowHeight = 44
        searchListTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RFRepoListTVCell") as! RFRepoListTVCell
        cell.configure(repoName: "Repo Name", ownerName: "Owner Name")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}


//MARK: Navigation Functionalities
extension RFHomeVC {
    private func goToRepoDetailsVC(){
        guard let navigationController = navigationController else {return}
        let storyboard = UIStoryboard(storyboard: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: RFRepoDetailsVC.self)
        navigationController.pushViewController(vc, animated: true)

    }
}

