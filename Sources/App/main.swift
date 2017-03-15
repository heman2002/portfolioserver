import Vapor

let drop = Droplet()
drop.middleware.insert(CORSMiddleware(), at: 0)
drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
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

drop.post("entry") { request in
  guard let jobtitle = request.data["jobtitle"]?.string else {
    throw Abort.badRequest
  }
  guard let company = request.data["company"]?.string else {
    throw Abort.badRequest
  }
  guard let startdate = request.data["startdate"]?.string else {
    throw Abort.badRequest
  }
  guard let enddate = request.data["enddate"]?.string else {
    throw Abort.badRequest
  }
  return try drop.view.make("entry", Node(node: ["jobtitle": jobtitle
                                              ,"company": company
                                              ,"startdate": startdate
                                              ,"enddate": enddate]))
}

drop.post("education") { request in
  guard let cousename = request.data["coursename"]?.string else {
    throw Abort.badRequest
  }
  guard let institute = request.data["institute"]?.string else {
    throw Abort.badRequest
  }
  guard let startdate = request.data["startdate"]?.string else {
    throw Abort.badRequest
  }
  guard let enddate = request.data["enddate"]?.string else {
    throw Abort.badRequest
  }
  return try drop.view.make("education", Node(node: ["coursename": coursename
                                              ,"institute": institute
                                              ,"startdate": startdate
                                              ,"enddate": enddate]))
}

drop.resource("posts", PostController())

drop.run()
