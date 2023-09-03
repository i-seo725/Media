//
//  Endpoint.swift
//  Media
//
//  Created by 이은서 on 2023/08/26.
//

import Foundation

enum Endpoint {
    case trend
    case credit
    case recommend
    case similar
    case video
    case tv
    case person
    case tvCredit
    case tvRecommend
    case personCredit
    
    func requestURL(type: Endpoint, id: Int? = nil) -> String {
        let idNum = id ?? 1
            switch type {
            case .trend:
                return URL.makeURL("trending/movie/day?language=ko-KR")
            case .credit:
                return URL.makeURL("movie/\(idNum)/credits")
            case .recommend:
                return URL.makeURL("movie/\(idNum)/recommendations")
            case .similar:
                return URL.makeURL("movie/\(idNum)/similar?language=ko-KR")
            case .video:
                return URL.makeURL("movie/\(idNum)/videos")
            case .tv:
                return URL.makeURL("trending/tv/day?language=ko-KR")
            case .person:
                return URL.makeURL("trending/person/day?language=ko-KR")
            case .tvCredit:
                return URL.makeURL("tv/\(idNum)/credits")
            case .tvRecommend:
                return URL.makeURL("tv/\(idNum)/recommendations")
            case .personCredit:
                return URL.makeURL("person/\(idNum)/credits")
                
            }
        }
    

}
