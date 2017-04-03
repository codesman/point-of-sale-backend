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
    
    var exists: Bool = false
    
    static var entity: String = "order"
    
    var id: Node?
    var order_date: Date
    var order_total: Double
    
    init(order_date: Date, order_total: Double) throws {
        self.id = nil
        self.order_date = order_date
        self.order_total = order_total
    }
    
    init(node: Node, in context: Context) throws {
        id = try node.extract("id")
        let timeSince1970:Double = try node.extract("order_date")
        order_date = Date(timeIntervalSince1970: timeSince1970)
        order_total = try node.extract("order_total")
    }
    
    func makeNode(context: Context) throws -> Node {
        var node: [String: Node] = [:]
        node["id"] = id
        node["order_date"] = order_date.timeIntervalSince1970.makeNode()
        node["order_total"] = order_total.makeNode()
        
        if context is JSONContext {
            let items = try self.ordereditems().all().map {
                return try $0.makeNode(context: context)
            }
            
            node["items"] = Node.array(items)
        }
        
        return Node.object(node)
    }
    
    static func prepare(_ database: Database) throws {
        try database.create(entity) { option in
            option.id()
            option.double("order_date")
            option.double("order_total")
        }
    }
    
    static func revert(_ database: Database) throws {
        try database.delete(entity)
    }
    
    func ordereditems() -> Children<OrderedItem> {
        return children()
    }
}
