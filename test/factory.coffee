next = app.factory.next

app.factory.post = (attrs) ->
  new app.Post _(
    title : "Post title #{next()}"
    text  : "Post text #{next()}"
  ).extend(attrs)
app.factory.post.create = (attrs) ->
  post = app.factory.post attrs
  post.create() || throw new Error "can't create post!"
  post

app.factory.post.comment = (attrs) ->
  new app.Post.Comment _(
    text  : "Comment text #{next()}"
  ).extend(attrs)