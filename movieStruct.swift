//
//  movieStruct.swift
//  Media
//
//  Created by 이은서 on 2023/08/15.
//

import Foundation

struct Movie {
    static let imagePath = "https://image.tmdb.org/t/p/original/"
    static let genreList = [28: "Action", 12: "Adventure", 16: "Animation", 35: "Comedy", 80: "Crime", 99: "Documentary", 18: "Drama", 10751: "Family", 14: "Fantasy", 36: "History", 27: "Horror", 10402: "Music", 9648: "Mystery", 10749: "Romance", 878: "Science Fiction", 10770: "TV Movie", 53: "Thriller", 10752: "War", 37: "Western"]

    let id: Int
    let title: String
    let release: String
    let overview: String
    let posterImage: String
    let backdropImage: String
    let rate: Double
    var genre: String = Movie.genreList.randomElement()!.value
    
    
    
}


