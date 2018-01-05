//
//  Product.swift
//  ShopifyInternDemo
//
//  Created by Ergiz Work on 04/01/2018.
//  Copyright © 2018 Ergiz Gizer. All rights reserved.
//

import Foundation

struct Product : Codable {
    
    let id : Int
    let title : String
    let body_html : String
    let image : ProductImage
}
