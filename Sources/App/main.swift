import Vapor

let drop = Droplet()
drop.middleware.insert(CORSMiddleware(), at: 0)
drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.get("entry") { request in
  return try drop.view.make("entry")
}

drop.post("template2") { request in
  guard let firstname = request.data["firstname"]?.string else {
    throw Abort.badRequest
  }
  guard let lastname = request.data["lastname"]?.string else {
    throw Abort.badRequest
  }
  guard let emailid = request.data["emailid"]?.string else {
    throw Abort.badRequest
  }
  guard let phoneno = request.data["phoneno"]?.string else {
    throw Abort.badRequest
  }
  guard let address = request.data["address"]?.string else {
    throw Abort.badRequest
  }
  return try drop.view.make("template1", Node(node: ["firstname": firstname
                                              ,"lastname": lastname
                                              ,"emailid": emailid
                                              ,"phoneno": phoneno
                                              ,"address": address ]))
}

drop.resource("posts", PostController())

drop.run()
