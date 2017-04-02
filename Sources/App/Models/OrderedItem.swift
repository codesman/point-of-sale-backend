//
//  OrderedItem.swift
//  POSBackendExample
//
//  Created by Dan on 2017-04-01.
//
//

import Foundation
import Vapor
import Fluent

final class OrderedItem: Model, Preparation {
    var id: Node?
    var ordereditem_name: String
    var description: String
    var image_url: String
    var base_price: Float
    var quantity: Int
    
    init(ordereditem_name: String, description: String, image_url: String, base_price: Float, quantity: Int) throws {
        self.id = nil
        self.ordereditem_name = ordereditem_name
        self.description = description
        self.image_url = image_url
        self.base_price = base_price
        self.quantity = quantity
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("ordereditem_id")
        ordereditem_name = try node.extract("ordereditem_name")
        description = try node.extract("description")
        image_url = try node.extract("image_url")
        base_price = try node.extract("base_price")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "item_id": id,
            "ordereditem_name": ordereditem_name,
            "description": description,
            "image_url": image_url,
            "base_price": base_price,
            "quantity": quantity
            ])
    }
    
    static func prepare(_ database: Database) throws {
        //
    }
    
    static func revert(_ database: Database) throws {
        //
    }
}
