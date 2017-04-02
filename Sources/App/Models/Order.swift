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


final class Order: Model {
    var id: Node?
    var order_date: Date
    var order_total: Double
    
    init(order_date: Date, order_total: Double) throws {
        self.id = nil
        self.order_date = order_date
        self.order_total = order_total
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("order_id")
        var timeSince1970:Double = try node.extract("order_date")
        order_date = Date(timeIntervalSince1970: timeSince1970)
        order_total = try node.extract("order_total")
    }
    
    func makeNode(context: Context) throws -> Node {
        return try Node(node: [
            "order_id": id,
            "order_date": order_date.timeIntervalSince1970,
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
