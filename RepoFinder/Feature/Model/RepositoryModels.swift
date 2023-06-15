//
//  RepositoryModels.swift
//  RepoFinder
//
//  Created by Amit Sarker on 15/6/23.
//

import Foundation

struct Repository: Codable {
    let name: String?
    let html_url: String?
    let description: String?
    let owner: Owner?
    let stargazers_count: Int?
    let forks_count: Int?
    let open_issues_count: Int?
}

struct Owner: Codable {
    let login: String?
    let avatar_url: String?
}

struct Commit: Codable {
    let sha: String?
    let commit: CommitDetails?
    let author: CommitAuthor?
}

struct CommitDetails: Codable {
    let message: String?
    let author: CommitAuthor?
    let committer: CommitAuthor?
}

struct CommitAuthor: Codable {
    let name: String?
    let email: String?
}
struct User: Codable {
    let login: String?
    let id: Int?
    let avatar_url: String?
    let name: String?
    let followers: Int?
    let following: Int?
    let public_repos: Int?
}

struct SearchResult<T: Codable>: Codable {
  let items: [T]
}
