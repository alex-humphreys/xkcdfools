# the API backend, written with nodejs, streamlinejs, and expressjs

fs = require 'fs'
join = require('path').join
express = require 'express'
RedisStore = require('connect-redis')(express)
moment = require 'moment'

log = (msg, others...) ->
  for o in others
    msg += (' ' + JSON.stringify(o))
  # add timestamp, output to console
  console.log moment().format() + '  ' + msg

# provide clean output on exceptions rather than dumping a stack trace
process.on 'uncaughtException', (error) ->
  log error + '\n'
  process.exit 1

app = express()

global.cfg = require '/etc/web/conf.d/xkcdfools.json'

# session support in expressjs, using a Redis backend
# access session variables via req.session.varname
app.use express.cookieParser()
app.use express.session({ secret: 'keybored cat', store: new RedisStore({ host: cfg.SESSION_REDIS_HOST, port: parseInt(cfg.SESSION_REDIS_PORT) }) })

# enable parsing the body of requests
app.use express.bodyParser()

app.use express.methodOverride()

app.use app.router


# Define error-handling behavior
app.use express.errorHandler
  # Exceptions to stderr on console (not to client)
  dumpExceptions: true
  # Include stack trace in exceptions (not to client)
  showStack: true

# route API calls
[
  'auth'
  'main'
].map (controllerName) ->
  controller = require join(__dirname, 'controllers', controllerName)
  controller.setup app

app.use express.static join __dirname, 'public'

# all 404's route to the index page
app.use (req, res, next) ->
  console.log 'got a 404:', req.url
  res.sendfile join(__dirname, 'public', 'index.html')

app.listen 8000

log "starting the web server\n"
