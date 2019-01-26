//
//  Repository.swift
//  swift-rindoku-sample
//
//  Created by SCI01552 on 2018/10/11.
//  Copyright © 2018年 hicka04. All rights reserved.
//

import Foundation
import RealmSwift

class Repository: Object, Decodable {
    
    @objc dynamic private(set) var id: Int = 0
    @objc dynamic private(set) var name: String = ""
    @objc dynamic private(set) var fullName: String = ""
    @objc dynamic private(set) var htmlUrl: String = ""
    @objc dynamic private(set) var language: String?
    @objc dynamic private(set) var repoDescription: String?
    @objc dynamic private(set) var updatedAt: String = ""
    @objc dynamic private(set) var stargazersCount: Int = 0
    @objc dynamic private(set) var watchersCount: Int = 0
    
    @objc dynamic private(set) var  owner: User!
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case htmlUrl = "html_url"
        case language
        case updatedAt = "updated_at"
        case repoDescription = "description"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case owner
    }
    
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:ss:mmZ"
        return dateFormatter
    }()
    
    var dateOfUpdate: Date? {
        return dateFormatter.date(from: updatedAt)
    }
}
