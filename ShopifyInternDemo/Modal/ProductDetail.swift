//
//  ProductDetail.swift
//  ShopifyInternDemo
//
//  Created by Ergiz Work on 05/01/2018.
//  Copyright © 2018 Ergiz Gizer. All rights reserved.
//

import Foundation

struct ProductDetail: Codable {
    
    let id : Int
    let title : String
    let body_html : String
    let image : ProductImage
    let vendor : String
    let product_type : String
    let created_at : String
    let updated_at : String
    let published_at : String
    let published_scope : String
    let tags : String
    let variants : [Variant]
    let images : [ProductImage]
}
