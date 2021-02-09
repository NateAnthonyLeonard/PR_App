//
//  receipt_TableViewController.swift
//  PRapp
//
//  Created by Nathaniel Leonard on 8/11/20.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation
import UIKit
import Firebase


class receipt_TableViewController: UITableViewController {
    
    var db:Firestore!
    
    
    @IBOutlet weak var tbvReceipt: UITableView!
    //create array to fetch data
    var receiptList = [ItemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
        loadData()
        
    }
    
    func loadData() {
        db.collection("receipts").getDocuments() {
            querySnapshot, error in
            if let error = error {
                print("\(error.localizedDescription)")
            }else{
                self.receiptList = querySnapshot!.documents.compactMap({ItemModel(dictionary: $0.data())})
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return receiptList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let purchaseblock = tableView.dequeueReusableCell(withIdentifier: "purchaseblock", for: indexPath)
        
        let ItemModel = receiptList[indexPath.row]
        
        purchaseblock.textLabel?.text = "\(ItemModel.name)"
        purchaseblock.detailTextLabel?.text = "\(ItemModel.price)"
        
        return purchaseblock
    }
    
}

