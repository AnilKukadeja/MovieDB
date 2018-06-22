//
//  ResponseModel.swift
//  MovieDB
//
//  Created by Webinfinium Technologies on 22/06/18.
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
