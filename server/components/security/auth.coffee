everyauth = require "everyauth"
bcrypt = require "bcrypt"
debug = require("debug") "app:auth"
users = require "../../repositories/mongo-users"

everyauth.everymodule
  .userPkey("_id") # MongoDB
  .findUserById((id, next) ->
    users.getById id, next
  )
  .performRedirect((res, location) ->
    res.redirect 303, location
  )

everyauth.password
  .loginWith("email")
  .getLoginPath("/account/login")
  .postLoginPath("/account/login")
  .loginView("account/login")
  .loginLocals((req, res) ->
    csrf: req.session._csrf if req.session._csrf
  )
  .authenticate((email, password) ->
    errors = []
    errors.push "Missing email" unless email
    errors.push "Missing password" unless password
    return errors if errors.length

    promise = @Promise()
    users.getOne {email}, (err, user) ->
      if err then promise.fulfill ["Wrong email or password"]
      else bcrypt.compare password, user.hash, (err, success) ->
        debug "Login success? %s", success
        if err or not success then promise.fulfill ["Wrong email or password"]
        else promise.fulfill user

    promise
  )
  .respondToLoginSucceed((res, user, data) ->
    location =
      if user and data.session.redirectTo then data.session.redirectTo
      else "/"
    @redirect res, location
  )

  .getRegisterPath("/account/register")
  .postRegisterPath("/account/register")
  .registerView("account/register")
  .registerLocals((req, res) ->
    csrf: req.session._csrf if req.session._csrf
  )
  .extractExtraRegistrationParams((req) ->
    password_conf: req.body.password_conf
  )
  .validateRegistration((data, errors) ->
    if data.password.length isnt 0 and data.password.length < 5 then errors.push "Password must be at least 5 characters long"
    unless data.password_conf then errors.push "Missing password confirmation"
    else unless data.password_conf is data.password then errors.push "Password and confirmation do not match"
    errors
  )
  .registerUser((data) ->
    debug "Registration data is valid, let's move on!"

    promise = @Promise()

    users.getOne {email: data.email}, (err, user) ->
      if user then promise.fulfill ["Email already taken"]
      else
        password = data.password
        salt = bcrypt.genSaltSync 10
        delete data.password
        delete data.password_conf
        data.hash = bcrypt.hashSync password, salt
        users.createOne data, (err, user) ->
          if err then promise.fulfill ["Failed to create account"]
          else promise.fulfill user

    promise
  )
  .respondToRegistrationSucceed((res, user, data) ->
    location =
      if user and data.session.redirectTo then data.session.redirectTo
      else "/"
    @redirect res, location
  )

exports.middleware = everyauth.middleware
