import Vapor
import VaporSQLite

let drop = Droplet()

do {
    try drop.addProvider(VaporSQLite.Provider.self)
} catch {
    print("Couldn't initialize VaporSQLite Provider")
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
