# Lorem RSS

Generates RSS feeds with content updated at regular intervals. I wrote this to
answer a [question I asked on Stack Overflow](http://stackoverflow.com/questions/18202048/are-there-any-constantly-updating-rss-feed-services-to-use-for-testing-or-just).

## API

Visit [http://lorem-rss.herokuapp.com/feed](http://lorem-rss.herokuapp.com/feed), with the following optional parameters:

*   _unit_: one of second, minute, day, month, or year
*   _interval_: an integer to repeat the units at. For seconds and minutes this interval must evenly divide 60, for month it must evenly divide 12, and for day and year it can only be 1.
*   _length_: an integer that determines the number of items in the feed. Must be greater or equal to 0 and smaller or equal to 1000. Defaults to 10 items.

## Examples

*   The default, updates once a minute, with 10 entries: [/feed](http://lorem-rss.herokuapp.com/feed)
*   Update every second instead of minute: [/feed?unit=minute](http://lorem-rss.herokuapp.com/feed?unit=minute)
*   Update every 30 seconds: [/feed?unit=second&interval=30](http://lorem-rss.herokuapp.com/feed?unit=second&interval=30)
*   Update once a day: [/feed?unit=day](http://lorem-rss.herokuapp.com/feed?unit=day)
*   Update every 6 months: [/feed?unit=month&interval=6](http://lorem-rss.herokuapp.com/feed?unit=month&interval=6)
*   Update once a year: [/feed?unit=year](http://lorem-rss.herokuapp.com/feed?unit=year)
*   Default feed with 42 entries: [/feed?length=42"](http://lorem-rss.herokuapp.com/feed?length=42)
*   **Invalid example:** update every 7 minutes (does not evenly divide 60): [/feed?unit=minute&interval=7](http://lorem-rss.herokuapp.com/feed?unit=minute&interval=7)

## Running locally

The project contains a Dockerfile that can be used to run Lorem RSS locally. Build via:

```
docker build . -t lorem-rss
```

Run via:

```
docker run --rm -it -p 5000:5000 lorem-rss
```

With thanks given to [eelkevdbos](https://github.com/eelkevdbos), who contributed the Dockerfile.

## Copyright

### The feed and documentation

Licensed by Michael Bertolacci under a Creative Commons Attribution 3.0 Unported License.

### The code

The MIT License (MIT)

Copyright (c) 2013 Michael Bertolacci

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.