//
//  Item.swift
//  POSBackendExample
//
//  Created by Dan on 2017-04-01.
//
//

import Foundation
import Vapor
import Fluent


final class Item: Model, Preparation {
    var id: Node?
    var item_name: String
    var description: String
    var image_url: String
    var base_price: Float
    
    init(item_name: String, description: String, image_url: String, base_price: Float) throws {
        self.id = nil
        self.item_name = item_name
        self.description = description
        self.image_url = image_url
        self.base_price = base_price
        
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("item_id")
        item_name = try node.extract("item_name")
        description = try node.extract("description")
        image_url = try node.extract("image_url")
        base_price = try node.extract("base_price")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "item_id": id,
            "item_name": item_name,
            "description": description,
            "image_url": image_url,
            "base_price": base_price
            ])
    }
    
    static func prepare(_ database: Database) throws {
        //
    }
    
    static func revert(_ database: Database) throws {
        //
    }
}
