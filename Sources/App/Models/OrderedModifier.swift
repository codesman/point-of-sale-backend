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
    
    var exists: Bool = false
    
    static var entity: String = "orderedmodifier"
    
    
    var id: Node?
    var name: String
    var image_url: String?
    var required: Bool
    var unit_type: String
    var unit_bounds: String?
    var price_addition: Double?
    var description: String?
    var quantity: Int
    var ordereditem_id: Int
    
    init(name: String, description: String?, image_url: String?, required: Bool, unit_type: String, unit_bounds: String?, price_addition: Double?, ordereditem_id: Int, quantity: Int) throws {
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
        var node: [String: Node] = [:]
        node["id"] = id
        node["name"] = name.makeNode()
        node["description"] = description?.makeNode() ?? Node.null
        node["image_url"] = image_url?.makeNode() ?? Node.null
        node["required"] = required.makeNode()
        node["unit_type"] = unit_type.makeNode()
        node["unit_bounds"] = unit_bounds?.makeNode() ?? Node.null
        node["price_addition"] = price_addition?.makeNode() ?? Node.null
        
        if context is DatabaseContext {
            node["ordereditem_id"] = try ordereditem_id.makeNode()
        }
        
        if context is JSONContext {
            let options = try self.orderedoptions().all().map { (option: OrderedOption) -> Node in
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
            modifier.string("description", optional: true)
            modifier.string("image_url", optional: true)
            modifier.bool("required")
            modifier.string("unit_type")
            modifier.string("unit_bounds", optional: true)
            modifier.string("price_addition", optional: true)
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
