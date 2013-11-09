{app, _} = require 'mono'

app.router.configure (map) ->
  map.get '/', controller: 'Posts', action: 'index'

  map.resource 'posts', (posts) ->
    posts.resource 'comments'