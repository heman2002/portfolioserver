import Vapor

let drop = Droplet()
drop.middleware.insert(CORSMiddleware(), at: 0)
drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.get("template2", String.self) { request, name in
  return try drop.view.make("template1", Node(node: ["name": name]))
}

drop.resource("posts", PostController())

drop.run()
