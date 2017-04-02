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


final class Option: Model, Preparation {
    var id: Node?
    var option_name: String
    var price_addition: Float
    var description: String
    var fk_modifier_id: Int?
    
    init(option_name: String, description: String, price_addition: Float, fk_modifier_id: Int?) {
        self.id = nil
        self.option_name = option_name
        self.price_addition = price_addition
        self.description = description
        self.fk_modifier_id = fk_modifier_id
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("option_id")
        option_name = try node.extract("option_name")
        description = try node.extract("description")
        price_addition = try node.extract("price_addition")
        fk_modifier_id = try node.extract("fk_modifier_id")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "option_id": id,
            "price_addition": price_addition,
            "option_name": option_name,
            "description": description,
            "fk_modifier_id": fk_modifier_id
            ])
    }
    
    static func prepare(_ database: Database) throws {
        //
    }
    
    static func revert(_ database: Database) throws {
        //
    }
}
