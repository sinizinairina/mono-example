{app, _} = require 'mono'

app.router.get '/', controller: 'Posts', action: 'index'

app.router.resource 'posts', (posts) ->
  posts.resource 'comments'