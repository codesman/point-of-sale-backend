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

final class OrderedItem: Model {
    
    static var entity: String = "ordereditem"
    
    var id: Node?
    var name: String
    var description: String
    var image_url: String
    var base_price: Float
    var quantity: Int
    var order_id: Int
    
    init(name: String, description: String, image_url: String, base_price: Float, quantity: Int, order_id: Int) throws {
        self.id = nil
        self.name = name
        self.description = description
        self.image_url = image_url
        self.base_price = base_price
        self.quantity = quantity
        self.order_id = order_id
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        description = try node.extract("description")
        image_url = try node.extract("image_url")
        quantity = try node.extract("quantity")
        base_price = try node.extract("base_price")
        order_id = try node.extract("order_id")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "name": name,
            "description": description,
            "image_url": image_url,
            "base_price": base_price,
            "quantity": quantity,
            "order_id": order_id
            ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create(entity) { item in
            item.id()
            item.string("name")
            item.string("description")
            item.string("image_url")
            item.double("base_price")
            item.int("quantity")
            item.parent(Order.self, optional: false, unique: false, default: nil)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(entity)
    }
    
    func orderedmodifiers() -> Children<OrderedModifier> {
        return children()
    }
}
