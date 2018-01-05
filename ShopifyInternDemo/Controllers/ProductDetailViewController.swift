//
//  DetailViewController.swift
//  ShopifyInternDemo
//
//  Created by Ergiz Work on 04/01/2018.
//  Copyright © 2018 Ergiz Gizer. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    let dataSource = ProductDataSource()

    var productID: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.dataSource.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let id = productID {
            self.dataSource.loadProductDetail(id: id)
        }
    }

}

extension ProductDetailViewController: ProductDataSourceDelegate {
    
    func productDetailLoaded(product: Product) {
        print("loaded")
    }
}

