require '../helper'

describe "Posts", ->
  it "should show posts", async ->
    post = @factory.post.create text: 'some text'
    {data} = @http.get app.postsPath()
    expect(data).to.contain 'some text'

  it "should show post", async ->
    post = @factory.post.create text: 'some text'
    {data} = @http.get app.postPath(post)
    expect(data).to.contain 'some text'

  it "should show new form", async ->
    {data} = @http.get app.newPostPath()
    expect(data).to.contain 'New post'

  it "should show edit form", async ->
    post = @factory.post.create text: 'some text'
    {data} = @http.get app.editPostPath(post)
    expect(data).to.contain 'Editing post'
    expect(data).to.contain 'some text'

  it "should create post", async ->
    post = @factory.post text: 'some text'
    {headers} = @http.post app.postsPath(), post.toJson()
    expect(app.Post.count()).to.eql 1
    post = app.Post.first()
    expect(post)
      .to.have.property('text')
      .to.eql('some text')
    expect(headers.location).to.eql app.postPath(post)

  it "should update post", async ->
    post = @factory.post.create text: 'some text'
    {headers} = @http.put app.postPath(post), text: 'another text'
    expect(app.Post.count()).to.eql 1
    post = app.Post.first()
    expect(post)
      .to.have.property('text')
      .to.eql('another text')
    expect(headers.location).to.eql app.postPath(post)

  it "should delete post", async ->
    post = @factory.post.create()
    expect(app.Post.count()).to.eql 1
    {headers} = @http.delete app.postPath(post)
    expect(app.Post.count()).to.eql 0
    expect(headers.location).to.eql app.postsPath()