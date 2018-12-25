App.notifications = App.cable.subscriptions.create "NotificationsChannel",
  connected: ->
    @perform 'subscribed'

  disconnected: ->
    @perform 'unsubscribed'

  received: (data) ->
    $("p#notifications-#{data.twitter_user.id}").text(data.status);
