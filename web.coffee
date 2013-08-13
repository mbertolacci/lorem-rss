express = require 'express'
Feed = require 'feed'
moment = require 'moment'
_ = require 'lodash'

loremIpsum = require 'lorem-ipsum'
seedRandom = require 'seed-random'

app = express()

app.use express.logger()

units = {
    second: {
        nextUp: 'minute',
        mustDivide: 60
    }
    minute: {
        nextUp: 'hour'
        mustDivide: 60
    }
    hour: {
        nextUp: 'day'
        mustDivide: 24
    }
    day: {
        nextUp: 'year'
        mustDivide: 1
    }
    month: {
        nextUp: 'year'
        mustDivide: 12
    }
    year: {
        mustDivide: 1
    }
}

getNearest = (interval, unit) ->
    if interval == 1
        return moment().utc().startOf(unit)
    else
        unitOptions = units[unit]
        if unitOptions.mustDivide % interval != 0
            throw "When using #{unit}s the interval must divide #{unitOptions.mustDivide}"

        now = moment().utc()
        returnDate = now.clone().startOf(unitOptions.nextUp || unit)

        returnDate[unit](now[unit]() - now[unit]() % interval)

        return returnDate

app.get '/feed', (request, response) ->
    if request.query.interval?
        interval = parseInt request.query.interval
    else
        interval = 1

    if not interval
        response.send(500, "Interval must be an integer")
        return
    if interval <= 0
        response.send(500, "Interval must be greater than 0")
        return

    unit = request.query.unit || 'minute'

    if not units[unit]
        response.send(500, "Unit must be one of #{_.keys(units).join(', ')}")
        return

    feed = new Feed({
        title: "Lorem ipsum feed for an interval of #{interval} #{unit}s",
        description: 'This is a constantly updating lorem ipsum feed'
        link: 'http://example.com/',
        image: 'http://example.com/image.png',
        copyright: 'Public domain',

        author: {
            name: 'Michael Bertolacci',
            email: '',
            link: 'https://mgnbsoftware.com'
        }
    })

    pubDate = getNearest(interval, unit)

    for i in [0...10]
        feed.item {
            title: "Lorem ipsum #{pubDate.format()}",
            description: loremIpsum(
                random: () ->
                    seedRandom(pubDate.unix())()
            )
            link: "http://example.com/test/#{pubDate.format('X')}"
            date: pubDate.clone().toDate()
        }
        pubDate = pubDate.subtract(interval, unit)

    response.set 'Content-Type', 'application/rss+xml'
    response.send feed.render('rss-2.0');


port = process.env.PORT || 5000;

app.listen port, () ->
  console.log("Listening on " + port);
