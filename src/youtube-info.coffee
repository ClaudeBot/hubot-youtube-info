# Description
#   Show video metadata when YouTube URLs are seen.
#   Original: https://github.com/github/hubot-scripts/blob/master/src/scripts/youtube-info.coffee
#
# Dependencies:
#   None
#
# Configuration:
#   You need to specify your GOOGLE_API_KEY as an environment variable when running
#   Hubot, otherwise you will get an invalid key error
#
# Commands:
#   [YouTube video URL] - shows title, time length, and upload time for the URL
#
# Notes:
#   For text-based adapters like IRC.
#
# Author:
#   mmb
#   mbwk

GOOGLE_API_KEY = process.env.GOOGLE_API_KEY

querystring = require 'querystring'
url = require 'url'

module.exports = (robot) ->
  if not GOOGLE_API_KEY?
      return robot.logger.error "hubot-youtube-info: Missing GOOGLE_API_KEY in environment. Please set and try again."

  robot.hear /(https?:\/\/(www|gaming)\.youtube\.com\/watch\?.+?)(?:\s|$)/i, id: "youtube.url.full", (msg) ->
    url_parsed = url.parse(msg.match[1])
    query_parsed = querystring.parse(url_parsed.query)

    if query_parsed.v
      video_hash = query_parsed.v
      showInfo msg, video_hash

  robot.hear /(https?:\/\/youtu\.be\/)([a-z0-9\-_]+)/i, id: "youtube.url.mini", (msg) ->
    video_hash = msg.match[2]
    showInfo msg, video_hash

showInfo = (msg, video_hash) ->
  msg.http("https://www.googleapis.com/youtube/v3/videos?part=contentDetails%2Cstatistics%2Csnippet&id=#{video_hash}&key=#{GOOGLE_API_KEY}")
    .query({
      alt: 'json'
    }).get() (err, res, body) ->
      if res.statusCode is 200
        data = JSON.parse(body)
        video = data.items[0]
        snippet = video.snippet
        statistics = video.statistics
        contentDetails = video.contentDetails
        title = snippet.title
        time = formatTime(contentDetails.duration)
        views = statistics.viewCount
        date = snippet.publishedAt
        date = date.substr(0, date.indexOf("T"))
        likesCount = statistics.likeCount
        dislikesCount = statistics.dislikeCount
        msg.send "YouTube: #{title} (#{time}, #{views} views, uploaded #{date}, #{likesCount} likes, #{dislikesCount} dislikes)"
      else
        msg.send "YouTube: error: #{video_hash} returned #{res.statusCode}: #{body}"

formatTime = (timeStr) ->
  pPos = timeStr.indexOf("P") + 1
  tPos = timeStr.indexOf("T") + 1
  pLen = tPos - pPos - 1
  tLen = timeStr.length - tPos
  p = timeStr.substr(pPos, pLen)
  t = timeStr.substr(tPos, tLen)
  result = "#{t.toLowerCase()}"
  result

