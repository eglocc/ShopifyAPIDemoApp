//
//  Variant.swift
//  ShopifyInternDemo
//
//  Created by Ergiz Work on 05/01/2018.
//  Copyright © 2018 Ergiz Gizer. All rights reserved.
//

import Foundation

struct Variant: Codable {
    let id : Int
    let product_id : Int
    let title : String
    let price : Double
    let taxable : Bool
    let weight : Double
    let weight_unit : String
    let inventory_item_id : Int
    let old_inventory_quantity : Int
    let requires_shipping : Bool
}
