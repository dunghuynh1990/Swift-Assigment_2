//
//  SearchResult.swift
//  Yelp
//
//  Created by Huynh Tri Dung on 7/17/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import Foundation

class SearchResult: NSObject {
    let total: Int?
    let businesses: [Business]!
    
    init(total: Int, businesses: [Business]!) {
        self.total = total
        self.businesses = businesses
    }
}
