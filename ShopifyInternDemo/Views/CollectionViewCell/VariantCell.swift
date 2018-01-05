//
//  CollectionViewCell.swift
//  ShopifyInternDemo
//
//  Created by Ergiz Work on 05/01/2018.
//  Copyright © 2018 Ergiz Gizer. All rights reserved.
//

import UIKit

class VariantCell: UICollectionViewCell, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var variantInfoTable: UITableView!
    
    var variant: Variant?
    let variantInfoKeys = ["Color", "Price", "Weight", "Taxable", "Requires shipping"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return variantInfoKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VariantInfoCell", for: indexPath)
        
        cell.textLabel?.text = variantInfoKeys[indexPath.row]
        
        if let variant = variant {
            switch indexPath.row {
            case 0:
                cell.detailTextLabel?.text = variant.title
            case 1:
                cell.detailTextLabel?.text = "\(variant.price)$"
            case 2:
                cell.detailTextLabel?.text = "\(variant.weight) \(variant.weight_unit)"
            case 3:
                cell.detailTextLabel?.text = variant.taxable ? "YES" : "NO"
            case 4:
                cell.detailTextLabel?.text = variant.requires_shipping ? "YES" : "NO"
            default:
                print("WTF!")
            }
        }
        
        return cell
    }
}
