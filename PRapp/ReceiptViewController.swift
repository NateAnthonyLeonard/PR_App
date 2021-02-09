//
//  ReceiptViewController.swift
//  PRapp
//
//  Created by Nathaniel Leonard on 10/14/20.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import CoreNFC

class ReceiptCell: UITableViewCell {
    
    @IBOutlet weak var merchantName: UILabel!
    
    @IBOutlet weak var merchantTotal: UILabel!
}

class ReceiptViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var ReceiptTableView: UITableView!
    
    @IBOutlet weak var NFCbutton: UIButton!
    
    
    
    let helper = NFCHelper()
    
    var db:Firestore!
    
    //create array to fetch data
    var receiptList = [Receipt]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
            ReceiptTableView.dataSource = self
            ReceiptTableView.delegate = self

            db = Firestore.firestore()
            loadData()
            checkForUpdates()
    }
    
    func loadData() {
        db.collection("receipt_test").order(by: "createdAt", descending: true).getDocuments(){
             querySnapshot, error in
             if let error = error {
                 print("\(error.localizedDescription)")
             }else{
                 self.receiptList = querySnapshot!.documents.compactMap({Receipt(dictionary: $0.data())})
                 DispatchQueue.main.async {
                     self.ReceiptTableView.reloadData()
                 }
             }
         }
         
         
     }
     
     func checkForUpdates() {
         db.collection("receipt_test").addSnapshotListener {
                 querySnapshot, error in
                 guard let snapshot = querySnapshot else {return}
                 //snapshot.documentChanges.forEach {
                     //diff in
                     //if diff.type == .added {
                         //self.receiptList.append(Receipt(dictionary: diff.document.data())!)
                         DispatchQueue.main.async {
                             self.ReceiptTableView.reloadData()
                         }
                     }
                 }
                 
         //}
     //}
     
    @IBAction func didTapNFC(_ sender: Any) {
        print("didTapReadNFC")
        helper.restartSession()
    }
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?){
         if let indexPath = ReceiptTableView.indexPathForSelectedRow{
             let selectedRow = indexPath.row
             let destVC = segue.destination as! DetailViewController
             destVC.receipt = receiptList[selectedRow]
             ReceiptTableView.deselectRow(at: indexPath, animated: true)
         }
     }
    /*
    func tableView(_ tableView: UITableView, titleForFooterInSection
                                section: Int) -> String? {
       return "Footer"
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
*/
    
    func numberOfSections(in tableView: UITableView) -> Int {
           
           return 1
       }
     
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         
         //let content_array = receipt?.content
         //let count = content_array!.count
         //print(count)
         //return receiptList.count
        return receiptList.count
         
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
              let cell = tableView.dequeueReusableCell(withIdentifier: "receiptstartview", for: indexPath) as! ReceiptCell
              
           
              let displayReceipt = receiptList[indexPath.row]
              //cell.merchantName?.text = "EOE"
              //cell.detailTextLabel?.text = "WOW"
              
              cell.merchantName?.text = "\(displayReceipt.merchant)"
              cell.merchantTotal?.text = " \(displayReceipt.grandtotal)"
              //cell.detailTextLabel?.text = "item name: \(displayReceipt.content[0].item_name)"
              
              return cell
          

         }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
           let receipt = receiptList[indexPath.row]
           print(receipt)
           performSegue(withIdentifier: "MasterToDetail", sender: receipt)
       }
     
     
}
