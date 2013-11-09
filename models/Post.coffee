class app.Post extends app.Model
  @collection 'posts'

  @validations:
    title : (v) -> "can't be blank" if _(v).isBlank()
    text  : (v) -> "can't be blank" if _(v).isBlank()

  constructor: (attrs) ->
    @id = app.Model.generateId()
    @comments = []
    super attrs

# Comment, nested model.
class app.Post.Comment extends app.Model
  @validations:
    text: (v) -> "can't be blank" if _(v).isBlank()

  constructor: (attrs) ->
    @id = app.Model.generateId()
    super attrs

# Persistence for Comments.
app.Post.addComment = (postId, comment) ->
  @collection().update
    id: (postId.id || postId)
  ,
    $push: {comments: comment.toJson()}

app.Post.deleteComment = (postId, commentId) ->
  @collection().update
    id: (postId.id || postId)
  ,
    $pull: {comments: {id: (commentId.id || commentId)}}

# Parsing nested comments.
app.Post::parse = (attrs) ->
  return attrs unless 'comments' of attrs
  attrs = _(attrs).clone()
  attrs.comments = attrs.comments.map (object) -> new app.Post.Comment object
  attrs

# Converting nested comments to JSON.
app.Post::toJsonWithoutComments = app.Post::toJson
app.Post::toJson = ->
  data = @toJsonWithoutComments()
  data.items = data.comments.map (comment) -> comment.toJson()
  data