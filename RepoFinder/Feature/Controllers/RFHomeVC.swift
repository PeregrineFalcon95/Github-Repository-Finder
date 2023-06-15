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
    
    
    //MARK: View's Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
            self.goToRepoDetailsVC()
        })
    }
    
    
    //MARK: IBActions


}

//MARK: UI Functionalities
extension RFHomeVC {
    
}


//MARK: TableView Functionalites
extension RFHomeVC {
    
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

