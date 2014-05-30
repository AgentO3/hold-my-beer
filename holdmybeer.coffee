# Description:
#   Hold My Beer
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot <hmb|hold my beer> - Gets a random url from the my recent from http://www.reddit.com/r/holdmybeer/
#   hubot <hmb|hold my beer> <number> - Explosion of random recents post, defaults to 5.
#
# Author:
#   AgentO3


url = 'http://www.reddit.com/r/holdmybeer/top/.json?sort=top&t=week'

module.exports = (robot) ->
  robot.respond /(?:hmb|hold my beer)$/i, (msg) ->
    reqPics(url, msg, 1)

  robot.respond /(?:hmb|hold my beer) ((\d+))?/i, (msg) ->
  	count = msg.match[1] || 5
  	reqPics(url, msg, count)

reqPics = (url, msg, count) ->
  msg.http(url)
  .get() (err, res, body) ->
  	(sendMessage(JSON.parse(body).data.children, msg)) for i in [1..count]

sendMessage = (posts, msg) ->
  pick = msg.random(posts)
  msg.send pick.data.url
  msg.send pick.data.title
