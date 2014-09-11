# Description:
#   Returns a random imgur image
#
# Commands:
#   hubot riskit - Returns a random imgur image


module.exports = (robot) ->
  robot.respond /(riskit)? (.*)/i, (msg) ->
    makeUrl msg, (url) ->
      msg.send url



makeUrl = ->
  string = ""
  possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
  i = 0

  while i < 5
    string += possible.charAt(Math.floor(Math.random() * possible.length))
    i++
  
  "http://i.imgur.com/#{string}#.jpg"