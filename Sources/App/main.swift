import Vapor

let drop = Droplet()
var fname:String = String()
var lname:String = String()
var eid:String = String()
var pno:String = String()
var add:String = String()
var jtitle:String = String()
var comp:String = String()
var esd:String = String()
var eed:String = String()
var cname:String = String()
var iname:String = String()
var eded:String = String()
var edsd:String = String()
var skil:String = String()
drop.middleware.insert(CORSMiddleware(), at: 0)
drop.get { req in
    return try drop.view.make("welcome", [
    	"message": drop.localization[req.lang, "welcome", "title"]
    ])
}

drop.get("resume") { req in
    return try drop.view.make("resume", Node(node: ["firstname": fname
                                                ,"lastname": lname
                                                ,"emailid": eid
                                                ,"phoneno": pno
                                                ,"address": add
                                                ,"jobtitle": jtitle
                                                ,"company": comp
                                                ,"sdate": esd
                                                ,"edate": eed
                                                ,"course": cname
                                                ,"institute": iname
                                                ,"startdate": edsd
                                                ,"enddate": eded
                                                ,"skill": skil
    ]))
}

drop.post("template2") { request in
  guard let firstname = request.data["firstname"]?.string else {
    throw Abort.badRequest
  }
  fname = firstname
  guard let lastname = request.data["lastname"]?.string else {
    throw Abort.badRequest
  }
  lname = lastname
  guard let emailid = request.data["emailid"]?.string else {
    throw Abort.badRequest
  }
  eid = emailid
  guard let phoneno = request.data["phoneno"]?.string else {
    throw Abort.badRequest
  }
  pno = phoneno
  guard let address = request.data["address"]?.string else {
    throw Abort.badRequest
  }
  add = address
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
  jtitle = jobtitle
  guard let company = request.data["company"]?.string else {
    throw Abort.badRequest
  }
  guard let startdate = request.data["startdate"]?.string else {
    throw Abort.badRequest
  }
  esd = startdate
  guard let enddate = request.data["enddate"]?.string else {
    throw Abort.badRequest
  }
  eed = enddate
  return try drop.view.make("entry", Node(node: ["jobtitle": jobtitle
                                              ,"company": company
                                              ,"startdate": startdate
                                              ,"enddate": enddate]))
}

drop.post("education") { request in
  guard let coursename = request.data["coursename"]?.string else {
    throw Abort.badRequest
  }
  cname = coursename
  guard let institute = request.data["institute"]?.string else {
    throw Abort.badRequest
  }
  iname = institute
  guard let startdate = request.data["startdate"]?.string else {
    throw Abort.badRequest
  }
  edsd = startdate
  guard let enddate = request.data["enddate"]?.string else {
    throw Abort.badRequest
  }
  eded = enddate
  return try drop.view.make("education", Node(node: ["coursename": coursename
                                              ,"institute": institute
                                              ,"startdate": startdate
                                              ,"enddate": enddate]))
}

drop.post("skills") { request in
  guard let skill = request.data["skill"]?.string else {
    throw Abort.badRequest
  }
  skil = skill
  return skill
}

drop.resource("posts", PostController())

drop.run()
