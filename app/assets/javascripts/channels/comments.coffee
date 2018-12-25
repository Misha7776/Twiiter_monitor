App.comments = App.cable.subscriptions.create "CommentsChannel",
  connected: ->
    setTimeout =>
      @perform 'follow'
    , 1000

  disconnected: ->

  received: (data) ->
    if (data.action == 'create')
      append_comment(data)
    else 
      delete_comment(data)

append_comment = (data) ->
  $("div.comments[data-tweet-id='#{data.comment.tweet_id}']").append(data.html)
  $("#body_input-#{data.comment.tweet_id}").val('');

delete_comment = (data) ->
  $("#comment_#{data.comment.id}").fadeOut(200);


    