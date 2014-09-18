# Description:
#   A quick way to clear the chat log
#
# Commands:
#   hubot clear - Queries Google Images for <query> and returns a random, possibly NSFW, top result.

module.exports = (robot) ->
  robot.respond /clear? (.*)/i, (msg) ->

    longString = """
    
    




















































    """

    msg.send longString
