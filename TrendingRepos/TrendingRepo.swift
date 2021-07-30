//
//  TrendingRepo.swift
//  TrendingRepos
//
//  Created by kerim on 28.07.2021.
//

import Foundation

struct Response: Decodable {
    let total_count: Int
    let incomplete_results: Bool
    let items: [TrendingRepo]
}

struct ownerResponse: Decodable {
    let avatar_url: String
}

struct TrendingRepo : Decodable {
    let full_name: String
    let description: String?
    let stargazers_count: Int
    let  owner: ownerResponse
    let html_url: String
}
