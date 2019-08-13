//
//  ViewController.swift
//  IAPDemo
//
//  Created by Vivek Gajbe on 8/13/19.
//  Copyright © 2019 Intelegain. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {

    @IBOutlet weak var tblIAP: UITableView!
    var arrProductList = [clsIAPProductList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        IAPService.shared.getProducts()
        
        //add 3 object
        var ent = clsIAPProductList()
        ent.strProductName = "Consumable"
        ent.strProductId = IAPProducts.consumable.rawValue
        arrProductList.append(ent)
        
        ent = clsIAPProductList()
        ent.strProductName = "NonConsumable-MiniPack"
        ent.strProductId = IAPProducts.nonConsumableMiniPack.rawValue
        arrProductList.append(ent)
        
        ent = clsIAPProductList()
        ent.strProductName = "NonConsumable-SuperValuePack"
        ent.strProductId = IAPProducts.nonConsumableSuperValuePack.rawValue
        arrProductList.append(ent)
        
        ent = clsIAPProductList()
        ent.strProductName = "Restore Purchase"
        ent.strProductId = ""
        arrProductList.append(ent)
        
        tblIAP.delegate = self
        tblIAP.dataSource = self
        tblIAP.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //MARK: UITableView delegate method
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrProductList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let ent = arrProductList[indexPath.row]
        cell.textLabel?.text = ent.strProductName
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == arrProductList.count - 1
        {
            IAPService.shared.restorePurchases()
        }
        else
        {
            let ent = arrProductList[indexPath.row]
            IAPService.shared.purchase(product: IAPProducts(rawValue: ent.strProductId)!)
        }
    }
}
class clsIAPProductList
{
    var strProductName = String()
    var strProductId = String()
}

