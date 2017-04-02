import Vapor
import HTTP
import Foundation

final class InventoryController: ResourceRepresentable {
    
    // MARK: - Properties
    
    let drop: Droplet
    
    // MARK: - Init
    
    init(droplet: Droplet) {
        drop = droplet
    }
    
    // MARK: - REST
    
    func index(request: Request) throws -> ResponseRepresentable {
        do {
            return try Item.all().makeJSON()
        } catch {
            throw Abort.badRequest
        }
    }
    
    func store(request: Request) throws -> ResponseRepresentable {
        throw Abort.badRequest
    }
    
    func makeResource() -> Resource<Item> {
        return Resource(
            index: index)
    }
}

