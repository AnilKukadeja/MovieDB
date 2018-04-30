//
//  MovieList.swift
//  MovieDB
//
//  Created by Parth Adroja on 30/04/18.
//  Copyright © 2018 Anil Kukadeja. All rights reserved.
//

import UIKit
import ObjectMapper

class ResponseModel: Mappable {
    
    var results: [MovieList]?
    var page: Int?
    var total_resutls: Int?
    var total_pages: Int?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        results <- map["results"]
        page <- map["page"]
        total_resutls <- map["total_results"]
        total_pages <- map["total_pages"]
    }
}

class MovieList: Mappable {
    
    var id: Int?
    var title: String?
    var backdrop_path: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        backdrop_path <- map["backdrop_path"]
    }
}
