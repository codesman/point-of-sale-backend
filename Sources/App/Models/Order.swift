//
//  Order.swift
//  POSBackendExample
//
//  Created by Dan on 2017-04-01.
//
//

import Foundation
import Vapor
import Fluent


final class Order: Model, Preparation {
    var id: Node?
    var order_date: Date
    var order_total: Float
    
    init(order_date: Date, order_total: Float) throws {
        self.id = nil
        self.order_date = order_date
        self.order_total = order_total
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("order_id")
        order_date = try node.extract("order_date")
        order_total = try node.extract("order_total")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "order_id": id,
            "order_date": order_date,
            "order_total": order_total
            ])
    }
    
    static func prepare(_ database: Database) throws {
        //
    }
    
    static func revert(_ database: Database) throws {
        //
    }
}
