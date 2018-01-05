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
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
