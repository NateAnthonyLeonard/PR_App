//
//  ItemModel.swift
//  PRapp
//
//  Created by Nathaniel Leonard on 8/11/20.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation
import FirebaseFirestore
import Firebase
/*
class ItemModel{
    
    var category: String?
    var name: String?
    var price: Int?
    var quantity: Int?
    
    init(category: String?,name: String?, price: Int?,quantity: Int?){
        self.category = category;
        self.name = name;
        self.price = price;
        self.quantity = quantity;
        
}*/

 /*
protocol DocumentSerializable  {
        init?(dictionary:[String:Any])
    }


struct ItemModel{
   var merchant : Merchant
   
    var dictionary: [String: Any] {
        return [
            "merchant": merchant
        ]
    }
}

extension ItemModel: DocumentSerializable {
    
    init?(dictionary: [String : Any]) {
        guard let merchant = dictionary["merchant"] as? Merchant
            else { return nil }
        
        
        self.init( merchant: merchant)
    }
}


struct Merchant {
        var first: String
        var last: String
    
        
        var dictionary:[String:Any] {
            return [
                "first": first,
                 "last": last
                    ]
        }
}

extension Merchant : DocumentSerializable {
    init?(dictionary: [String : Any]) {
        guard let first = dictionary["first"] as? String,
            let last = dictionary["last"] as? String
            else {return nil}
        self.init(first:first, last:last)
        
    }
}

 */

/*
 USE THIS ONE IF NEEDED FOR TEST
protocol DocumentSerializable  {
    init?(dictionary:[String:Any])
}

struct Item: Codable {
    
    var item_name: String
    var item_no: String
}

struct Receipt {
    var name: String
    var content: [Item]
    var cost: String
    
    var convertDataToJSONforUpload:[String: Any] {
        return [
            "name": name,
            "content": try? content[0].asDictionary(),
            "cost": cost
        ]
    }
}

extension Receipt : DocumentSerializable {
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
            let content = dictionary["content"] as? Dictionary<String, String>,
            let cost = dictionary["cost"] as? String else { return nil }
        
        //Where the Magic Happens During Deserialization - we take each pair in Dictionary<String: Any> and convert to an Item.
        var item = [Item]()
        
        let itemName = content["item_name"] ?? ""
        let itemNumber = content["item_no"] ?? ""
        item.append(Item(item_name: itemName, item_no: itemNumber))
        
        
        self.init(name: name, content: item, cost: cost)
    }
}
*/
 
/*
protocol DocumentSerializable  {
    init?(dictionary:[String:Any])
}

struct Item_Detail: Codable {
    var name: String
    
}

struct Item_Number: Codable {
    var item1: [Item_Detail]
    
    var convertDataToJSONforUpload:[String: Any] {
        return [
            "item1": try? item1[0].asDictionary()
        ]
    }
    
}

struct Receipt {
    var merchant: String
    var items: [Item_Number]
    var total: String
    
    var convertDataToJSONforUpload:[String: Any] {
        return [
            "merchant": merchant,
            "items": items,
            "total": total
        ]
    }
}

extension Receipt : DocumentSerializable {
    init?(dictionary: [String: Any]) {
        guard let merchant = dictionary["merchant"] as? String,
            let items = dictionary["items"] as? Dictionary<String, String>,
            let total = dictionary["total"] as? String else { return nil }
        
        //Where the Magic Happens During Deserialization - we take each pair in Dictionary<String: Any> and convert to an Item.
        var item_list = [Item_List]()
        var itemm = [Item]()
        
        let itemName = items["name"] ?? ""
        
        item_list.append(Item_List(name:itemName))
        
        itemm.append(Item(item1: item_list))
        
      

        
        self.init(merchant: merchant, items:itemm, total: total)
    }
}
*/


/*
protocol DocumentSerializable {
    //A type that can be initialized from a Firebase document
    init?(dictionary:[String: Any])
}

struct Item: Codable {
    var category: String
    var name: String
    var price: String
    var quantity: String
}

//Convert to Dictionary Function
//func convertToDictionary(inputObject: Any) ->

struct Receipt {
    var address_city: String
    var address_line1: String
    var address_line2: String
    var address_state: String
    var address_zip: String
    var merchant: String
    var items: [Item]
    var grandtotal: String
    var subtotal: String
    var tax: String
    var userID: String
    
    var convertDataToJSONforUpload:[String: Any] {
        return [
            "address_city": address_city,
            "address_line1": address_line1,
            "address_line2": address_line2,
            "address_state": address_state,
            "address_zip": address_zip,
            "merchant": merchant,
            "items": ConverterFunctions.convertToArrayOfMaps(inputArray: items), // try? content[0].asDictionary(),
            "grandtotal": grandtotal,
            "subtotal": subtotal,
            "tax": tax,
            "userID": userID
        ]
    }
}

extension Receipt : DocumentSerializable {
    init?(dictionary: [String: Any]) {
        guard let address_city = dictionary["address_city"] as? String,
            let address_line1 = dictionary["address_line1"] as? String,
            let address_line2 = dictionary["address_line2"] as? String,
            let address_state = dictionary["address_state"] as? String,
            let address_zip = dictionary["address_zip"] as? String,
            let merchant = dictionary["merchant"] as? String,
            let items = dictionary["items"] as? [Dictionary<String, String>],
            let grandtotal = dictionary["grandtotal"] as? String,
            let subtotal = dictionary["subtotal"] as? String,
            let tax = dictionary["tax"] as? String,
            let userID = dictionary["userID"] as? String else { return nil }
        
        //Where the Magic Happens During Deserialization - we take each pair in Dictionary<String: Any> and convert to an Item.
        
        var products = [Item]()
        
        for x in items {
            let itemCategory = x["category"] 
            let itemName = x["name"]
            let itemPrice = x["price"]
            let itemQuantity = x["quantity"]
            products.append(Item(category: itemCategory))
        }
        //   items.append(Item(item_name: content[x]["item_name"], item_no: content[x]["item_no"]))
        
        //        let itemName = content["item_name"] ?? ""
        //        let itemNumber = content["item_no"] ?? ""
        //  items.append(Item(item_name: itemName, item_no: itemNumber))
        
        
        self.init(address_city: address_city, address_line1: address_line1, address_line2: address_line2, address_state:address_state, address_zip:address_zip, merchant: merchant, items: products, grandtotal:grandtotal, subtotal:subtotal, tax: tax, userID: userID)
    }
}
*/



 /*
 //WORKING ONE
protocol DocumentSerializable {
    //A type that can be initialized from a Firebase document
    init?(dictionary:[String: Any])
}

struct Item: Codable {
    var item_name: String
    var item_no: String
}

//Convert to Dictionary Function
//func convertToDictionary(inputObject: Any) ->

struct Receipt {
    var name: String
    var content: [Item]
    var cost: String
    
    var convertDataToJSONforUpload:[String: Any] {
        return [
            "name": name,
            "content": ConverterFunctions.convertToArrayOfMaps(inputArray: content), // try? content[0].asDictionary(),
            "cost": cost
        ]
    }
}

extension Receipt : DocumentSerializable {
    init?(dictionary: [String: Any]) {
        guard let name = dictionary["name"] as? String,
            let content = dictionary["content"] as? [Dictionary<String, String>],
            let cost = dictionary["cost"] as? String else { return nil }
        
        //Where the Magic Happens During Deserialization - we take each pair in Dictionary<String: Any> and convert to an Item.
        var items = [Item]()
        
        for x in content {
            let itemName = x["item_name"] ?? ""
            let itemNumber = x["item_no"] ?? ""
            items.append(Item(item_name: itemName, item_no: itemNumber))
        }
        //   items.append(Item(item_name: content[x]["item_name"], item_no: content[x]["item_no"]))
        
        //        let itemName = content["item_name"] ?? ""
        //        let itemNumber = content["item_no"] ?? ""
        //  items.append(Item(item_name: itemName, item_no: itemNumber))
        
        
        self.init(name: name, content: items, cost: cost)
    }
}
 
*/

protocol DocumentSerializable {
    //A type that can be initialized from a Firebase document
    init?(dictionary:[String: Any])
}

struct Item: Codable {
    var item_name: String
    var item_price: String
    var item_category: String
    var item_quantity: String
    
}

//Convert to Dictionary Function
//func convertToDictionary(inputObject: Any) ->

struct Receipt {
    var merchant: String
    var content: [Item]
    var grandtotal: String
    var subtotal: String
    var tax: String
    var address_city: String
    var address_line1: String
    var address_line2: String
    var address_state: String
    var address_zip: String
    var userID: String
    var createdAt: Timestamp
    
    var convertDataToJSONforUpload:[String: Any] {
        return [
            "merchant": merchant,
            "content": ConverterFunctions.convertToArrayOfMaps(inputArray: content), // try? content[0].asDictionary(),
            "grandtotal": grandtotal,
            "subtotal": subtotal,
            "tax":tax,
            "address_city": address_city,
            "address_line1": address_line1,
            "address_line2": address_line2,
            "address_state": address_state,
            "address_zip": address_zip,
            "userID": userID,
            "createdAt": createdAt
            
        ]
    }
}

extension Receipt : DocumentSerializable {
    init?(dictionary: [String: Any]) {
        guard let merchant = dictionary["merchant"] as? String,
            let content = dictionary["content"] as? [Dictionary<String, String>],
            let grandtotal = dictionary["grandtotal"] as? String,
            let subtotal = dictionary["subtotal"] as? String,
            let tax = dictionary["tax"] as? String,
            let address_city = dictionary["address_city"] as? String,
            let address_line1 = dictionary["address_line1"] as? String,
            let address_line2 = dictionary["address_line2"] as? String,
            let address_state = dictionary["address_state"] as? String,
            let address_zip = dictionary["address_zip"] as? String,
            let userID = dictionary["userID"] as? String,
            let createdAt = dictionary["createdAt"] as? Timestamp else { return nil }
        
        //Where the Magic Happens During Deserialization - we take each pair in Dictionary<String: Any> and convert to an Item.
        var items = [Item]()
        
        for x in content {
            let itemName = x["item_name"] ?? ""
            let itemPrice = x["item_price"] ?? ""
            let itemCat = x["item_category"] ?? ""
            let itemQuant = x["item_quantity"] ?? ""
            items.append(Item(item_name: itemName, item_price: itemPrice, item_category:itemCat, item_quantity:itemQuant))
        }
        //   items.append(Item(item_name: content[x]["item_name"], item_no: content[x]["item_no"]))
        
        //        let itemName = content["item_name"] ?? ""
        //        let itemNumber = content["item_no"] ?? ""
        //  items.append(Item(item_name: itemName, item_no: itemNumber))
        
        
        self.init(merchant: merchant, content: items, grandtotal: grandtotal, subtotal: subtotal, tax: tax, address_city: address_city, address_line1: address_line1, address_line2: address_line2, address_state: address_state, address_zip: address_zip, userID: userID, createdAt: createdAt)
    }
}


 
