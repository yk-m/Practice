//
//  Repository.swift
//  swift-rindoku-sample
//
//  Created by SCI01552 on 2018/10/11.
//  Copyright © 2018年 hicka04. All rights reserved.
//

import Foundation

struct Repository: Decodable {
    
    let id: Int
    let name: String
    let fullName: String  // 詳細ページ表示用に追加
    let htmlUrl: String
    let language: String
    let description: String
    let updatedAt: String
    let stargazersCount: Int
    let watchersCount: Int
    
    let owner: User
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case htmlUrl = "html_url"
        case language
        case updatedAt = "updated_at"
        case description
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case owner
    }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:ss:mmZ"
        return dateFormatter
    }()
    
    var dateOfUpdate: Date? {
        return dateFormatter.date(from: updatedAt)
    }
}
