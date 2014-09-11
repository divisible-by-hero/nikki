# Description:
#   A dirty way to interact with the Google Images API.
#
# Commands:
#   hubot nsfw me <query> - Queries Google Images for <query> and returns a random, possibly NSFW, top result.
#   hubot jiggle me <query> - The same thing as `nsfw me`, except adds a few parameters to try to return an jiggly GIF instead.

module.exports = (robot) ->
  robot.respond /(nsfw)( me)? (.*)/i, (msg) ->
    imageMe msg, msg.match[3], (url) ->
      msg.send url

  robot.respond /jiggle( me)? (.*)/i, (msg) ->
    imageMe msg, msg.match[2], true, (url) ->
      msg.send url


imageMe = (msg, query, animated, faces, cb) ->
  cb = animated if typeof animated == 'function'
  cb = faces if typeof faces == 'function'
  q = v: '1.0', rsz: '8', q: query, safe: 'off'
  q.imgtype = 'animated' if typeof animated is 'boolean' and animated is true
  q.imgtype = 'face' if typeof faces is 'boolean' and faces is true
  msg.http('http://ajax.googleapis.com/ajax/services/search/images')
    .query(q)
    .get() (err, res, body) ->
      images = JSON.parse(body)
      images = images.responseData?.results
      if images?.length > 0
        image = msg.random images
        cb ensureImageExtension image.unescapedUrl

ensureImageExtension = (url) ->
  ext = url.split('.').pop()
  if /(png|jpe?g|gif)/i.test(ext)
    url
  else
    "#{url}#.png"
