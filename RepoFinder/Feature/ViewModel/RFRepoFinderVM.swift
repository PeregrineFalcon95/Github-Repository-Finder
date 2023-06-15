//
//  RepoFinderViewModel.swift
//  RepoFinder
//
//  Created by Amit Sarker on 15/6/23.
//

import Foundation

class RFRepoFinderVM {
    //MARK: Variables
    var repoSeachList : [Repository] = []
    var selectedSearchIndex = 0
    
    //MARK: API Consumtion
    func searchRepositories(query: String, completion: @escaping (Result<[Repository], APIError>) -> Void) {
        let endpoint = "/search/repositories"
        let queryParams = [ "q": query ]

        GitHubAPI.shared.performGetRequest(endpoint: endpoint, queryParams: queryParams) { (result: Result<SearchResult<Repository>, APIError>) in
            switch result {
            case .success(let searchResult):
                let repositories = searchResult.items
                self.repoSeachList = repositories
                completion(.success(repositories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
