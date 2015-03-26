# hubot-youtube-info

Shows video metadata when YouTube URLs are seen.

Youtubeのリンクを見た時に動画のメタデータを表示する


## Important

This script was not created by me, I have only made a repository for it and made some
minor changes.  Aside from those, the Copyright for this script lies with GitHub Inc.

Credit for authorship of this script goes to mmb.  The original script may be found
[here](https://github.com/github/hubot-scripts/blob/master/src/scripts/youtube-info.coffee).


## How to install

The [Claudebot repository](https://github.com/ClaudeBot/ClaudeBot) comes with
hubot-youtube-info already set as a script, and you can follow that example.

To add this script to your own version of hubot, edit package.json to contain the
latest version of hubot-youtube-info, and the same for external-scripts.json.
Then simply run `npm update` or `npm install`.


## How to use

The script is often coupled with an irc adapter, and will listen to chat for any valid
youtube links.  Simply paste a link, and the bot will do the rest.


## Summary of changes

1.  Script now exists independently of the hubot-scripts bundle, and may be
    downloaded via npm.
2.  Added date of video publish/upload to the information printed about the video.
3.  Fixed a bug in the script that caused it to crash if a video lacked ratings.
