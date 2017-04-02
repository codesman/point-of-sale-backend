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


final class Item: Model {
    var id: Node?
    var name: String
    var description: String?
    var image_url: String?
    var base_price: Double
    
    init(name: String, description: String, image_url: String, base_price: Double) throws {
        self.id = nil
        self.name = name
        self.description = description
        self.image_url = image_url
        self.base_price = base_price
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        name = try node.extract("name")
        description = try node.extract("description")
        image_url = try node.extract("image_url")
        base_price = try node.extract("base_price")
    }
    
    func makeNode(context: Context) throws -> Node {
        var node: [String: Node] = [:]
        node["id"] = id
        node["name"] = name.makeNode()
        node["description"] = description?.makeNode() ?? Node.null
        node["image_url"] = image_url?.makeNode() ?? Node.null
        node["base_price"] = base_price.makeNode()
        
        if context is JSONContext {
            let modifiers = try self.modifiers().all().map { (modifier: Modifier) in
                return try modifier.makeNode(context: context)
            }
            
            node["modifiers"] = Node.array(modifiers)
        }
        
        return Node.object(node)
    }
    
    static func prepare(_ database: Database) throws {
        try database.create(entity) { item in
            item.id()
            item.string("name")
            item.string("description", optional: true)
            item.string("image_url", optional: true)
            item.double("base_price")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(entity)
    }
    
    func modifiers() -> Children<Modifier> {
        return children()
    }
}

