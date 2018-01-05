//
//  MasterViewController.swift
//  ShopifyInternDemo
//
//  Created by Ergiz Work on 04/01/2018.
//  Copyright © 2018 Ergiz Gizer. All rights reserved.
//

import UIKit
import Kingfisher

class ProductListViewController: UITableViewController {

    var detailViewController: ProductDetailViewController? = nil
    
    let dataSource = ProductDataSource()
    var productDictionary = Dictionary<Character, [Product]>()
    var titles = [String]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource.delegate = self
        self.navigationItem.title = "Products"
        
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? ProductDetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        self.dataSource.loadProductList()
        super.viewWillAppear(animated)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let controller = (segue.destination as! UINavigationController).topViewController as! ProductDetailViewController
                let char = Character(self.titles[indexPath.section])
                controller.productID = productDictionary[char]?[indexPath.row].id
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.titles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let char = Character(self.titles[section])
        if let productList = self.productDictionary[char] {
            return productList.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.titles[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath)
        
        let char = Character(self.titles[indexPath.section])
        if let productList = productDictionary[char] {
            let product = productList[indexPath.row]
            cell.textLabel?.text = product.title
            cell.detailTextLabel?.text = product.body_html
            let url = URL(string: product.image.src)
            let placeholder = UIImage(named: "icons8-price_tag")
            cell.imageView?.kf.setImage(with: url, placeholder: placeholder)
            
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.imageView?.kf.cancelDownloadTask()
    }
}

extension ProductListViewController: ProductDataSourceDelegate {
    
    func productListLoaded(productList: [Product]) {
        self.dataSource.extractProductList(productList: productList)
    }
    
    func productListExtracted(productDictionary: [Character : [Product]]) {
        self.productDictionary = productDictionary
        self.titles = getTitles(dictionary: productDictionary)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func getTitles(dictionary: Dictionary<Character,[Product]>) -> [String] {
        var titles = [String]()
        for key in dictionary.keys {
            titles.append(String(key))
        }
        return titles.sorted()
    }
}

