//
//  MovieList.swift
//  MovieDB
//
//  Created by Parth Adroja on 30/04/18.
//  Copyright © 2018 Anil Kukadeja. All rights reserved.
//

import UIKit
import ObjectMapper

class MovieList: Mappable {
    
    var id: Int?
    var title: String?
    var backdropPath: String?
    var isVideoAvailable : Bool?
    var voteAverage : Double?
    var popularity : String?
    var posterPath : String?
    var originalLangauage : String?
    var isAdult : Bool?
    var overView : String?
    var releaseDate : String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        backdropPath <- map["backdrop_path"]
        isVideoAvailable <- map["video"]
        voteAverage <- map["vote_average"]
        popularity <- map["popularity"]
        posterPath <- map["poster_path"]
        originalLangauage <- map["original_language"]
        isAdult <- map["adult"]
        overView <- map["overview"]
        releaseDate <- map["release_date"]
    }
}
