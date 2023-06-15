//
//  ViewController.swift
//  RepoFinder
//
//  Created by Amit Sarker on 15/6/23.
//

import UIKit

class RFHomeVC: UIViewController {
    //MARK: Variables
    let viewModel = RFRepoFinderVM()
    
    
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
        guard let searchText = searchTextField.text , !searchText.isEmpty else {return}
        performSearch(searchText: searchText)
    }
    
    deinit {
        debugPrint("RFHomeVC Deinit Called")
    }
}

//MARK: Helpers
extension RFHomeVC {
    private func performSearch(searchText: String){
        let loaderView = LoaderView()
        loaderView.startAnimating(view: view)
        viewModel.searchRepositories(query: searchText) { result in
            loaderView.stopAnimating()
            switch result {
            case .success(let repositories):
                if repositories.count == 0 {
                    self.showAlert(msg: ErrorMessages.noRepoFound)
                }
                DispatchQueue.main.async {
                    self.searchListTableView.reloadData()
                }
            case .failure(let error):
                self.showAlert(msg: error.localizedDescription )
            }
        }
    }
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
        return viewModel.repoSeachList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RFRepoListTVCell") as! RFRepoListTVCell
        cell.configure(repoName: viewModel.repoSeachList [ indexPath.row ].name , ownerName: viewModel.repoSeachList [ indexPath.row ].owner.login)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectedSearchIndex = indexPath.row
        goToRepoDetailsVC()
    }
}


//MARK: Navigation Functionalities
extension RFHomeVC {
    private func goToRepoDetailsVC(){
        guard let navigationController = navigationController else {return}
        let storyboard = UIStoryboard(storyboard: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: RFRepoDetailsVC.self)
        vc.viewModel = viewModel
        navigationController.pushViewController(vc, animated: true)
    }
}

