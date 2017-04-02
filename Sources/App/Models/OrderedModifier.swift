//
//  OrderedModifier.swift
//  POSBackendExample
//
//  Created by Dan on 2017-04-01.
//
//

import Foundation
import Vapor
import Fluent

final class OrderedModifier: Model {
    
    
    static var entity: String = "orderedmodifier"
    
    
    var id: Node?
    var name: String
    var image_url: String
    var required: Int
    var unit_type: String
    var unit_bounds: String
    var price_addition: Float
    var description: String
    var quantity: Int
    var ordereditem_id: Int
    
    init(name: String, description: String, image_url: String, required: Int, unit_type: String, unit_bounds: String, price_addition: Float, ordereditem_id: Int, quantity: Int) throws {
        self.id = nil
        self.name = name
        self.description = description
        self.image_url = image_url
        self.required = required
        self.unit_type = unit_type
        self.unit_bounds = unit_bounds
        self.price_addition = price_addition
        self.ordereditem_id = ordereditem_id
        self.quantity = quantity
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        description = try node.extract("description")
        image_url = try node.extract("image_url")
        required = try node.extract("required")
        unit_type = try node.extract("unit_type")
        unit_bounds = try node.extract("unit_bounds")
        price_addition = try node.extract("price_addition")
        quantity = try node.extract("quantity")
        ordereditem_id = try node.extract("ordereditem_id")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "id": id,
            "name": name,
            "description": description,
            "image_url": image_url,
            "required": required,
            "unit_type": unit_type,
            "unit_bounds": unit_bounds,
            "price_addition": price_addition,
            "ordereditem_id": ordereditem_id,
            "quantity": quantity
            ])
    }
    
    static func prepare(_ database: Database) throws {
        try database.create(entity) { modifier in
            modifier.id()
            modifier.string("name")
            modifier.string("description")
            modifier.string("image_url")
            modifier.bool("required")
            modifier.string("unit_type")
            modifier.string("unit_bounds")
            modifier.string("price_addition")
            modifier.int("quantity")
            modifier.parent(OrderedItem.self, optional: false, unique: false, default: nil)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(entity)
    }
    
    func orderedoptions() -> Children<OrderedOption> {
        return children()
    }
}
