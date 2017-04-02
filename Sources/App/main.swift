import Vapor
import Fluent
import VaporSQLite

let drop = Droplet()

do {
    try drop.addProvider(VaporSQLite.Provider.self)
} catch {
    print("Couldn't initialize VaporSQLite Provider")
}

let preparations: [Preparation.Type] = [Item.self, Modifier.self, Option.self, Order.self, OrderedItem.self, OrderedModifier.self, OrderedOption.self]

for prep in preparations {
    drop.preparations.append(prep)
}


// testing

drop.get("inventory") { request in
    do {
        return try JSON(node: Item.all().makeNode(context: JSONContext()))
    } catch {
        throw Abort.badRequest
    }
}

drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.get("version") { request in
    let result = try drop.database?.driver.raw("SELECT sqlite_version()")
    return try JSON(node: result)
}


drop.run()
