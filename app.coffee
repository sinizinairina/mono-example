{app, _, p} = require 'mono'

# Handy globals, comment it out if not needed.
global.app = app
global.p   = p
global._   = _

# Configuring mono, use environment variables to override defaults.
app.configure __dirname

# Configuring application, use environment variables to override it.
env = process.env
app.brand         = env.brand         || 'Blog'
app.dbPath        = env.dbPath        || "mongodb://localhost/mono-example-#{app.environment}"
app.sessionKey    = env.sessionKey    || 'Blog'
app.sessionSecret = env.sessionSecret || 'dummy secret'
app.login         = env.login         || 'admin'
app.password      = env.password      || 'admin'

# Assembling application.
app.requireDirectory "#{__dirname}/controllers", watch: true, onDemand: true
app.requireDirectory "#{__dirname}/models",      watch: true, onDemand: true
# app.requireDirectory "#{__dirname}/helpers",     watch: true
app.render.directories.push "#{__dirname}/templates"

# Configuring http, lazy loading.
app.after 'http', (http) ->
  # Setting middleware.
  http.useCommonMiddleware()

  # Setting routes.
  require './routes'

# Defining basic authorization, lazy loading.
app.after 'http', (http) ->
  basicAuth = app.http.express.basicAuth app.login, app.password
  app.http.authorize = (req, res, next) ->
    if app.environment == 'test' then next() else basicAuth req, res, next
  app.sync app.http, 'authorize'

# Starting http server.
app.http.run() if process.argv[1] == __filename

# # Catching uncaught eerrors if any.
# process.on 'uncaughtException', (error) ->
#   console.log error.message || error
#   console.log error.stack