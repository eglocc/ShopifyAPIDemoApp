//
//  DetailViewController.swift
//  ShopifyInternDemo
//
//  Created by Ergiz Work on 04/01/2018.
//  Copyright © 2018 Ergiz Gizer. All rights reserved.
//

import UIKit

class ProductDetailViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var productInfoTable: UITableView!
    @IBOutlet weak var variantCollection: UICollectionView!
    
    let dataSource = ProductDataSource()
    var productID: Int?
    var product : ProductDetail?
    var currentVariant : Int?
    
    var productInfoKeys = ["Title", "Description", "Vendor", "Tags"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.dataSource.delegate = self
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let id = productID {
            self.dataSource.loadProductDetail(id: id)
        }
        super.viewWillAppear(animated)
    }

}

extension ProductDetailViewController: ProductDataSourceDelegate {
    
    func productDetailLoaded(product: ProductDetail) {
        self.product = product
        DispatchQueue.main.async {
            self.navigationItem.title = product.product_type
            self.pageControl.numberOfPages = product.variants.count
            self.pageControl.isHidden = false
            self.productInfoTable.reloadData()
            self.variantCollection.reloadData()
        }
    }
}

extension ProductDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let variants = product?.variants{
            return variants.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VariantCell", for: indexPath) as! VariantCell
        
        if let variant = product?.variants[indexPath.row] {
            cell.variant = variant
        }
        
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if let variants = self.product?.variants {
            let width = self.variantCollection.contentSize.width / CGFloat(variants.count)
            if velocity.x != 0 {
                let remainder = targetContentOffset.pointee.x.truncatingRemainder(dividingBy: width)
                let truncatedCellNumber : Int = Int((targetContentOffset.pointee.x - remainder) / width)
                if remainder > width / 2 {
                    targetContentOffset.pointee.x = CGFloat(truncatedCellNumber + 1) * width
                    self.currentVariant = (truncatedCellNumber + 1)
                } else {
                    targetContentOffset.pointee.x = CGFloat(truncatedCellNumber) * width
                    self.currentVariant = truncatedCellNumber
                }
            }
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = self.currentVariant!
    }
    
}

extension ProductDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productInfoKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductInfoCell", for: indexPath)
        
        cell.textLabel?.text = productInfoKeys[indexPath.row]
        switch indexPath.row {
        case 0:
            cell.detailTextLabel?.text = product?.title
        case 1:
            cell.detailTextLabel?.text = product?.body_html
        case 2:
            cell.detailTextLabel?.text = product?.vendor
        case 3:
            cell.detailTextLabel?.text = product?.tags
        default:
            print("OOPS")
        }
        
        return cell
    }
    
    
}
