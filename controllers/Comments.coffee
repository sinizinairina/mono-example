class app.Comments extends app.ApplicationController
  @before -> app.http.authorize @request, @response

  create: ({postId, id}) ->
    @comment = new app.Post.Comment @params
    app.Post.addComment postId, @comment if @comment.isValid()
    @redirectTo app.postPath postId

  destroy: ({postId, id}) ->
    app.Post.deleteComment postId, id
    @redirectTo app.postPath(postId)