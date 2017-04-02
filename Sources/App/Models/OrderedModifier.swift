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
    var id: Node?
    var orderedmodifier_name: String
    var image_url: String
    var required: Int
    var unit_type: String
    var unit_bounds: String
    var price_addition: Float
    var description: String
    var quantity: Int
    var fk_ordereditem_id: Int?
    
    init(orderedmodifier_name: String, description: String, image_url: String, required: Int, unit_type: String, unit_bounds: String, price_addition: Float, fk_ordereditem_id: Int?, quantity: Int) throws {
        self.id = nil
        self.orderedmodifier_name = orderedmodifier_name
        self.description = description
        self.image_url = image_url
        self.required = required
        self.unit_type = unit_type
        self.unit_bounds = unit_bounds
        self.price_addition = price_addition
        self.fk_ordereditem_id = fk_ordereditem_id
        self.quantity = quantity
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("orderedmodifier_id")
        orderedmodifier_name = try node.extract("orderedmodifier_name")
        description = try node.extract("description")
        image_url = try node.extract("image_url")
        required = try node.extract("required")
        unit_type = try node.extract("unit_type")
        unit_bounds = try node.extract("unit_bounds")
        price_addition = try node.extract("price_addition")
        quantity = try node.extract("quantity")
        fk_ordereditem_id = try node.extract("fk_ordereditem_id")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "orderedmodifier_id": id,
            "orderedmodifier_name": orderedmodifier_name,
            "description": description,
            "image_url": image_url,
            "required": required,
            "unit_type": unit_type,
            "unit_bounds": unit_bounds,
            "price_addition": price_addition,
            "fk_ordereditem_id": fk_ordereditem_id,
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
