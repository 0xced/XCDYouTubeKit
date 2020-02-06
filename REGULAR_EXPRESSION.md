## Regular Expression Guide 

### Overview 

Some YouTube videos require regular expressions for the XCDYouTubeKit to successfully parse them get a valid streaming URL. XCDYouTubeKit handles this automatically with hard-coded regular expression patterns, however, due to the changing nature of YouTube sometimes these patterns become out of date. Since version 2.9.0 clients have been given the ability to use custom patterns in favor of the hard-coded patterns used internally by the library. Before using custom patterns please note:

* The regular expressions are based on those used by the [YouTube extractor module](https://github.com/ytdl-org/youtube-dl/blob/master/youtube_dl/extractor/youtube.py) of the *youtube-dl* project. See the list of expressions [here](https://github.com/ytdl-org/youtube-dl/blob/master/youtube_dl/extractor/youtube.py#L1344)
* The order of the expressions are very important, adding the expressions to an array in an incorrect order can lead to some videos being unable to play. 
* The strings contained in the array passed to the `customPatterns` argument should be [ICU regular expressions](http://userguide.icu-project.org/strings/regexp).

### Best Practices  

Generally speaking, the only time you would use the custom patterns is so that you can push new changes to your users faster and remotely, this would be done by using a server. Here are some best practices when using custom patterns :

* Make sure that you're using the latest version of  `XCDYouTubeKit`. 
* Check the current patterns being used by the library under the section titled "Current Patterns"
* Update the patterns accordingly on your server, this will allow users who haven't updated to the latest version of your app to use the latest patterns.

### Current Patterns

These are the patterns used in version 2.9.0 of XCDYouTubeKit:

```
\\b[cs]\\s*&&\\s*[adf]\\.set\\([^,]+\\s*,\\s*encodeURIComponent\\s*\\(\\s*([a-zA-Z0-9$]+)\\(

\\b[a-zA-Z0-9]+\\s*&&\\s*[a-zA-Z0-9]+\\.set\\([^,]+\\s*,\\s*encodeURIComponent\\s*\\(\\s*([a-zA-Z0-9$]+)\\(

\\b([a-zA-Z0-9$]{2})\\s*=\\s*function\\(\\s*a\\s*\\)\\s*\\{\\s*a\\s*=\\s*a\\.split\\(\\s*\"\"\\s*\\)

([a-zA-Z0-9$]+)\\s*=\\s*function\\(\\s*a\\s*\\)\\s*\\{\\s*a\\s*=\\s*a\\.split\\(\\s*\"\"\\s*\\)
```

**Note**: Sometimes videos may still fail due to stream even if the patterns are up to date and would require an updated version of XCDYouTubeKit. Updated patterns won't always fix issues when YouTube changes its API, however, when the change merely requires new patterns using custom patterns should be sufficient.
