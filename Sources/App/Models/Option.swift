//
//  Option.swift
//  POSBackendExample
//
//  Created by Dan on 2017-04-01.
//
//

import Foundation
import Vapor
import Fluent


final class Option: Model {
    
    var exists: Bool = false
    
    static var entity: String = "option"
    
    var id: Node?
    var name: String
    var price_addition: Float
    var description: String?
    var modifier_id: Int
    
    init(name: String, description: String?, price_addition: Float, modifier_id: Int) {
        self.id = nil
        self.name = name
        self.price_addition = price_addition
        self.description = description
        self.modifier_id = modifier_id
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        description = try node.extract("description")
        price_addition = try node.extract("price_addition")
        modifier_id = try node.extract("modifier_id")
    }
    
    func makeNode(context: Context) throws -> Node {
        var node: [String: Node] = [:]
        node["id"] = id
        node["price_addition"] = price_addition.makeNode()
        node["name"] = name.makeNode()
        node["description"] = description?.makeNode() ?? Node.null
        
        if context is DatabaseContext {
            node["modifier_id"] = try modifier_id.makeNode()
        }
        
        return Node.object(node)
    }
    
    static func prepare(_ database: Database) throws {
        try database.create(entity) { option in
            option.id()
            option.string("name")
            option.string("description", optional: true)
            option.double("price_addition")
            option.parent(Modifier.self, optional: false, unique: false, default: nil)
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(entity)
    }
}
