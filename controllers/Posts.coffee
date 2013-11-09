class app.Posts extends app.ApplicationController
  @before except: ['index', 'show'], -> app.http.authorize @request, @response

  index: ->
    @posts = app.Post.all()
    @render()

  show: ({id}) ->
    @post = app.Post.first id: id
    @render()

  new: ->
    @post = new app.Post()
    @render()

  edit: ({id}) ->
    @post = app.Post.first id: id
    @render()

  create: ->
    @post = new app.Post @params
    if @post.create()
      @flash notice: 'Post was successfully created.'
      @redirectTo app.postPath(@post)
    else @render action: 'new'

  update: ({id}) ->
    @post = app.Post.first id: id
    @post.set @params
    if @post.update()
      @flash notice: 'Post was successfully updated.'
      @redirectTo app.postPath(@post)
    else @render action: 'edit'

  destroy: ({id}) ->
    @post = app.Post.first id: id
    @post.delete()
    @redirectTo app.postsPath()