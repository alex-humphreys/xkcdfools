Db = require('mongodb').Db
Server = require('mongodb').Server
join = require('path').join
#auth = require join(__dirname, '..', 'libs', 'auth')

setup = (app) ->
  console.log 'TODO: write login method'
  ###
  # determine if the current session is logged in and returns a javascript that 
  # injects the user object into the DOM at whim.user
  app.get '/user', (req, res, next) ->
    response = { status: 'failure' }
    res.contentType 'text/javascript'

    # if the email is present in the session, authenticated
    if req.session.email
      response = auth.getUser req.session.email, (er, response) =>
        # TODO: this will break shit if user NOT found, should handle this ... ;)
        # return javascript that injects the user object into whim.user in the
        # browser so that it can determine if the user is logged in or not
        res.send 'whim.user = ' + JSON.stringify(response.data) + ';'
    else
      res.send 'whim.user = null;'


  # handle auth for whim users
  app.post '/login', (req, res, next) ->
    response = { status: 'failure' }
    res.contentType 'json'
    if req.query.email and req.query.password
      password = req.query.password
      email = req.query.email.trim().toLocaleLowerCase()
      auth.login email, password, (er, response) =>
        if response.status == 'success'
          # password is correct, set up the logged in session variables
          req.session.email = response.data.email
          req.session.name = response.data.name
          req.session.lat = response.data.location.lat
          req.session.lon = response.data.location.lon
          req.session.save()
        # return the JSON response
        res.send JSON.stringify response
    else
      response.reason = 'Please enter your email and password'
      # return the JSON response
      res.send JSON.stringify response
###

module.exports = {setup}