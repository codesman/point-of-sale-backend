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
    
    static var entity: String = "modifier"
    
    var id: Node?
    var name: String
    var image_url: String
    var required: Bool
    var unit_type: String
    var unit_bounds: String
    var price_addition: Double
    var description: String
    var item_id: Int
    
    init(name: String, description: String, image_url: String, required: Bool, unit_type: String, unit_bounds: String, price_addition: Double, item_id: Int) throws {
        self.id = nil
        self.name = name
        self.description = description
        self.image_url = image_url
        self.required = required
        self.unit_type = unit_type
        self.unit_bounds = unit_bounds
        self.price_addition = price_addition
        self.item_id = item_id
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
        item_id = try node.extract("item_id")
    }
    
    func makeNode(context: Context) throws -> Node {
        var node: [String: Node] = [:]
        node["id"] = id
        node["name"] = name.makeNode()
        node["description"] = description.makeNode()
        node["image_url"] = image_url.makeNode()
        node["required"] = required.makeNode()
        node["unit_type"] = unit_type.makeNode()
        node["unit_bounds"] = unit_bounds.makeNode()
        node["price_addition"] = price_addition.makeNode()
        
        if context is DatabaseContext {
            node["item_id"] = try item_id.makeNode()
        }
        
        if context is JSONContext {
            let options = try self.options().all().map { (option: Option) -> Node in
                return try option.makeNode(context: context)
            }
            
            node["options"] = Node.array(options)
        }
        
        return Node.object(node)
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
            modifier.parent(Item.self, optional: false, unique: false, default: nil)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(entity)
    }
    
    func options() -> Children<Option> {
        return children()
    }
}
