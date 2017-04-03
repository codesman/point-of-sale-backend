//
//  OrderedOption.swift
//  POSBackendExample
//
//  Created by Dan on 2017-04-01.
//
//

import Foundation
import Vapor
import Fluent


final class OrderedOption: Model {
    
    var exists: Bool = false
    
    static var entity: String = "orderedoption"
    
    var id: Node?
    var name: String
    var price_addition: Double
    var description: String?
    var quantity: Int
    var orderedmodifier_id: Int
    
    init(name: String, description: String?, quantity: Int, price_addition: Double, orderedmodifier_id: Int) {
        self.id = nil
        self.name = name
        self.quantity = quantity
        self.price_addition = price_addition
        self.description = description
        self.orderedmodifier_id = orderedmodifier_id
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        description = try node.extract("description")
        price_addition = try node.extract("price_addition")
        quantity = try node.extract("quantity")
        orderedmodifier_id = try node.extract("orderedmodifier_id")
    }
    
    func makeNode(context: Context) throws -> Node {
        var node: [String: Node] = [:]
        node["id"] = id
        node["price_addition"] = price_addition.makeNode()
        node["name"] = name.makeNode()
        node["description"] = description?.makeNode() ?? Node.null
        node["quantity"] = try quantity.makeNode()
        
        if context is DatabaseContext {
            node["orderedmodifier_id"] = try orderedmodifier_id.makeNode()
        }
        
        return Node.object(node)
    }
    
    static func prepare(_ database: Database) throws {
        try database.create(entity) { option in
            option.id()
            option.string("name")
            option.string("description", optional: true)
            option.double("price_addition")
            option.int("quantity")
            option.parent(OrderedModifier.self, optional: false, unique: false, default: nil)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(entity)
    }
}
