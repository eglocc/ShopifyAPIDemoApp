//
//  ProductDataSource.swift
//  ShopifyInternDemo
//
//  Created by Ergiz Work on 04/01/2018.
//  Copyright © 2018 Ergiz Gizer. All rights reserved.
//

import Foundation

protocol ProductDataSourceDelegate {
    func productListLoaded(productList: [Product])
    func productListExtracted(productDictionary: [Character: [Product]])
    func productDetailLoaded(product: ProductDetail)
}

extension ProductDataSourceDelegate {
    func productListLoaded(productList: [Product]) {}
    func productListExtracted(productDictionary: [Character: [Product]]) {}
    func productDetailLoaded(product: ProductDetail) {}
}

class ProductDataSource {
 
    var delegate : ProductDataSourceDelegate?
    
    func loadProductList() {
        let session = URLSession.shared
        let request = URLRequest(url: URL(string: "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6")!)
        
        session.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            let jsonData = try! decoder.decode(Dictionary<String, [Product]>.self, from: data!)
            let productList = jsonData["products"]!
            self.delegate?.productListLoaded(productList: productList)
        }.resume()
    }
    
    func extractProductList(productList: [Product]) {
        var dictionary = Dictionary<Character, [Product]>()
        for product in productList {
            if let array = dictionary[product.title.first!] {
                var newArray = array
                newArray.append(product)
                dictionary[product.title.first!] = newArray
            } else {
                dictionary[product.title.first!] = [Product]()
                dictionary[product.title.first!]!.append(product)
            }
        }
        self.delegate?.productListExtracted(productDictionary: dictionary)
    }
    
    func loadProductDetail(id: Int) {
        let session = URLSession.shared
        let request = URLRequest(url: URL(string: "https://shopicruit.myshopify.com/admin/products/\(id).json?access_token=c32313df0d0ef512ca64d5b336a0d7c6")!)
        
        session.dataTask(with: request) { (data, response, error) in
            let decoder = JSONDecoder()
            let jsonData = try! decoder.decode(Dictionary<String, ProductDetail>.self, from: data!)
            let product = jsonData["product"]!
            self.delegate?.productDetailLoaded(product: product)
        }.resume()
    }
}
