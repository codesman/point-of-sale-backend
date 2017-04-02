//
//  Modifier.swift
//  POSBackendExample
//
//  Created by Dan on 2017-04-01.
//
//

import Foundation
import Vapor
import Fluent

final class Modifier: Model {
    var id: Node?
    var modifier_name: String
    var image_url: String
    var required: Int
    var unit_type: String
    var unit_bounds: String
    var price_addition: Float
    var description: String
    var fk_item_id: Int?
    
    init(modifier_name: String, description: String, image_url: String, required: Int, unit_type: String, unit_bounds: String, price_addition: Float, fk_item_id: Int?) throws {
        self.id = nil
        self.modifier_name = modifier_name
        self.description = description
        self.image_url = image_url
        self.required = required
        self.unit_type = unit_type
        self.unit_bounds = unit_bounds
        self.price_addition = price_addition
        self.fk_item_id = fk_item_id
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("modifier_id")
        modifier_name = try node.extract("modifier_name")
        description = try node.extract("description")
        image_url = try node.extract("image_url")
        required = try node.extract("required")
        unit_type = try node.extract("unit_type")
        unit_bounds = try node.extract("unit_bounds")
        price_addition = try node.extract("price_addition")
        fk_item_id = try node.extract("fk_item_id")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "modifier_id": id,
            "modifier_name": modifier_name,
            "description": description,
            "image_url": image_url,
            "required": required,
            "unit_type": unit_type,
            "unit_bounds": unit_bounds,
            "price_addition": price_addition,
            "fk_item_id": fk_item_id ?? Node.null
            ])
    } 
    
    static func prepare(_ database: Database) throws {
        //
    }
    
    static func revert(_ database: Database) throws {
        //
    }
}
