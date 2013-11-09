require '../helper'

describe "Post Comments", ->
  it "should show comments", async ->
    comment = @factory.post.comment text: 'some comment text'
    post = @factory.post.create
      text     : 'some post text'
      comments : [comment]
    {data} = @http.get app.postPath(post)
    expect(data).to.contain post.text
    expect(data).to.contain comment.text

  it "should create comment", async ->
    post = @factory.post.create()
    expect(post.comments).to.have.length 0
    @http.post app.postCommentsPath(post), text: 'some comment text'
    post.refresh()
    expect(post.comments).to.have.length 1
    expect(post.comments[0].text).to.eql 'some comment text'

  it "should delete comment", async ->
    comment = @factory.post.comment()
    post = @factory.post.create
      comments : [comment]
    expect(post.comments).to.have.length 1
    @http.delete app.postCommentPath(post, comment)
    post.refresh()
    expect(post.comments).to.have.length 0