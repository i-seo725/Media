//
//  URL+Extenstion.swift
//  Media
//
//  Created by 이은서 on 2023/08/26.
//

import Foundation

extension URL {
    static let baseURL = "https://api.themoviedb.org/3/"
    static func makeURL(_ endpoint: String) -> String {
        return baseURL + endpoint
    }
}
