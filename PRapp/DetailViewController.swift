//
//  DetailViewController.swift
//  PRapp
//
//  Created by Nathaniel Leonard on 8/30/20.
//  Copyright © 2020 PR. All rights reserved.
//

import UIKit

//Review 
class DetailTBCell: UITableViewCell {
    
    @IBOutlet weak var products: UILabel!
    
    @IBOutlet weak var prices: UILabel!
    
    @IBOutlet weak var category: UILabel!
    

    override func layoutSubviews() {
        super.layoutSubviews()
        
        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 1.8, left: 0, bottom: 1.8, right: 0))
    }
    
}

class DetailSpaceTBCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 1.8, left: 0, bottom: 1.8, right: 0))
    }
    override func awakeFromNib() {
          super.awakeFromNib()
      }

    //override func setSelected(_ selected: Bool, animated: Bool) {
          //super.setSelected(selected, animated: animated)
      //}
    
}

class DetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tview: UITableView!
    
    @IBOutlet weak var purchaseTax: UILabel!
    @IBOutlet weak var purchaseGrandtotal: UILabel!
    
    @IBOutlet weak var flipGrandtotal: UILabel!
    @IBOutlet weak var purchaseSubtotal: UILabel!
    
    @IBOutlet weak var receiptDate: UILabel!
    
    @IBOutlet weak var address_zip: UILabel!
    @IBOutlet weak var address_citystate: UILabel!
    @IBOutlet weak var address_line1: UILabel!
    
    @IBOutlet weak var totalfullView: UIView!
    @IBOutlet weak var totalView: UIView!
    
    @IBAction func tapFlipTotal(_ sender: UIButton) {
            UIView.transition(from: totalView, to: totalfullView, duration: 0.5, options: .transitionFlipFromRight)
    }
    @IBAction func tapFlipfullTotal(_ sender: UIButton) {
        UIView.transition(from: totalfullView, to: totalView, duration: 0.5, options: .transitionFlipFromLeft)
    }
    var receipt: Receipt?
    
// Expand receipt content array with spaces to create fake spaces in UITableView
    var expandedItems = [Any]()

    func expandArray() {
        //creating an empty dictionary to use for appending with spaces
        var temporaryExpandedItems = [Any]()
        //store contents of receipt in contenarray
        let contentarray = receipt?.content
        //count number of items in receipt - content count
        let count = contentarray!.count
        
        for item in 0..<(count){
            /* almost like in Python where in a for loop you would do receipt?.content(i) */
            let items = receipt?.content[item]
            //Add item to empty list
            temporaryExpandedItems.append(items!)
            /* then add a space - the for loop repeats after and creates the effect
             where there is a space after each item */
            temporaryExpandedItems.append("")
        }
        expandedItems = temporaryExpandedItems
        //print("HI")
        //print((expandedItems[0] as! Item).item_name)
        //print(expandedItems[1])
    }
    
   func formatdate (_ date: Date) -> String {
       let formatter = DateFormatter()
       formatter.dateFormat = "MMM dd yyyy" //MMM dd yyyy HH:mm
       return formatter.string(from: date)
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tview.dataSource = self
        tview.delegate = self

        // Do any additional setup after loading the view.
        purchaseGrandtotal.text = "\(receipt?.grandtotal ?? "NULL")"
        flipGrandtotal.text = "\(receipt?.grandtotal ?? "NULL")"
        purchaseSubtotal.text = "\(receipt?.subtotal ?? "NULL")"
        purchaseTax.text = "\(receipt?.tax ?? "NULL")"
        let createdAt_date =  (receipt?.createdAt.dateValue() ?? nil)
        let createdAt_datef = formatdate(createdAt_date!)
        //receiptDate.text = "\(String(describing: createdAt_date))"
        receiptDate.text = "\(createdAt_datef)"
        address_line1.text = "\(receipt?.address_line1 ?? "NULL")"
        //address_line1.sizeToFit()
        address_citystate.text = "\(receipt?.address_city ?? "NULL"), \(receipt?.address_state ?? "NULL") "
        //address_citystate.sizeToFit()
        address_zip.text = "\(receipt?.address_zip ?? "NULL")"
         //cell.textLabel?.text = "name: \(displayReceipt.name), item name: \(displayReceipt.content[1].item_name)"
        expandArray()
    }
    
    
    //func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return 80
    //}
 
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(_ tableView: UITableView,
    heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        if indexPath.row % 2 != 0
        {
            return 10
        }
        else {
            return 70
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //let content_array = receipt?.content
        //let count = content_array!.count
        //print(count)
        return expandedItems.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let index = indexPath.row
        //let currentItem = expandedItems[index]
        
        //let indexsection = indexPath.section
        
        if index % 2 == 0
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "productsblock") as! DetailTBCell
        
        
        //let receipt = receiptList[indexPath.row]
        //let displayReceipt = receiptList[indexPath.row]
        
        //cell.products?.text = "\(String(describing: receipt?.name))"
        //cell.prices?.text = " \(receipt?.cost ?? "0")"
        //cell.detailTextLabel?.text = "item name: \(displayReceipt.content[0].item_name)"
        //print(receipt ?? 0)
        
        
        //cell.products.text = "\(receipt?.content[indexPath.row].item_name ?? "NULL")"
        //cell.prices?.text = " \(receipt?.content[indexPath.row].item_no ?? "NULL")"
        //cell.prices.text = "WOW"
       
        //cell.layer.borderColor = UIColor.gray.cgColor
        //cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
            //cell.frame.height / 2
        cell.clipsToBounds = true
        //cell.layer.masksToBounds = false
        
        //cell.contentView.backgroundColor = UIColor.clear

        //let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.width - 20, height: 149))

       // whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.8])
       // whiteRoundedView.layer.masksToBounds = false
        //whiteRoundedView.layer.cornerRadius = 10.0
       // whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        //whiteRoundedView.layer.shadowOpacity = 0.2

       // cell.contentView.addSubview(whiteRoundedView)
       // cell.contentView.sendSubviewToBack(whiteRoundedView)
        
        // The subview inside the collection view cell
       //cell.layer.cornerRadius = 20.0
      // cell.layer.shadowColor = UIColor.gray.cgColor
      // cell.layer.shadowOffset = CGSize(width: 0.0, height: 10.0)
      // cell.layer.shadowRadius = 12.0
      // cell.layer.shadowOpacity = 0.7

        //cell.products.text = "\(receipt?.content[indexPath.row].item_name ?? "NULL")"
            cell.products.text = "\((expandedItems[indexPath.row] as! Item).item_name)"
            cell.prices?.text = "\((expandedItems[indexPath.row] as! Item).item_price)"
            cell.category?.text = "\((expandedItems[indexPath.row] as! Item).item_category)"
        
        if cell.category?.text == "Food & Drinks"{
            cell.contentView.backgroundColor =  UIColor(red: (221/255.0), green: (129/255.0), blue: (207/255.0), alpha: 0.25)
                
        }
        else if cell.category?.text == "Shopping"{
            cell.contentView.backgroundColor = UIColor(red: (27/255.0), green: (194/255.0), blue: (47/255.0), alpha: 0.25)
        }
        else if cell.category?.text == "Services"{
            cell.contentView.backgroundColor = UIColor(red: (36/255.0), green: (121/255.0), blue: (213/255.0), alpha: 0.25)
        }
        else if cell.category?.text == "Travel"{
            cell.contentView.backgroundColor = UIColor(red: (219/255.0), green: (119/255.0), blue: (47/255.0), alpha: 0.25)
        }
        else if cell.category?.text == "Transportation"{
            cell.contentView.backgroundColor = UIColor(red: (252/255.0), green: (191/255.0), blue: (33/255.0), alpha: 0.25)
        }
        else if cell.category?.text == "Entertainment"{
            cell.contentView.backgroundColor = UIColor(red: (137/255.0), green: (89/255.0), blue: (236/255.0), alpha: 0.25)
        }
        else if cell.category?.text == "Health"{
            cell.contentView.backgroundColor = UIColor(red: (210/255.0), green: (16/255.0), blue: (16/255.0), alpha: 0.25)
        }
        else {
            cell.contentView.backgroundColor = UIColor.white
        }
        

            return cell
         
        }
   
    else {
        
              let spacecell = tableView.dequeueReusableCell(withIdentifier: "spacingcell", for: indexPath ) as! DetailSpaceTBCell
            
            return spacecell
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
