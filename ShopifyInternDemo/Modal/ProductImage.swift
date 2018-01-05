//
//  ShopifyImage.swift
//  ShopifyInternDemo
//
//  Created by Ergiz Work on 04/01/2018.
//  Copyright © 2018 Ergiz Gizer. All rights reserved.
//

import Foundation

struct ProductImage: Codable {
    
    let id : Int
    let product_id : Int
    let position : Int
    let created_at : String
    let updated_at : String
    let width : Int
    let height : Int
    let src : String
    
}
