#  {
#    'satellite': 'phase4',
#    'mode': 'voice',
#    'duration': 20,
#    'station': 'N1NLY',
#  }

# create four points for a polygon that is withing a segment, at an offset from the origin,
# which is a percentage of the available width at that point.
# TODO This isn't drawing out to the next segment like it's supposed to
polypoints = (angle, dist, percwidth, height) ->
  console.log('height = ' + height)
  angle = angle/2
  radians = angle * (Math.PI/180)
  return "0," + (dist-height) + "  " +
        (-1*(percwidth/100)*dist*Math.sin(radians)) + "," + dist +
        "  0," + (dist+height) + "  " +
        (dist*(percwidth/100)*Math.sin(radians)) + "," + dist

qsocolor = (mode) ->
  if mode == "voice"
    return "green"
  else if mode == "data"
    return "red"
  else
    return "blue"



draw = (data) ->
  color = d3.scale.category20b()
  width = 420
  height = 420
  margin = 5 # leave room fro stroke widths
  xorg = width / 2
  yorg = height / 2
  numqsos = data.length
  angle = 360.0 / numqsos
  maxlen = (width / 2) - margin
  maxqsotime = Math.max.apply(Math, data.map((o) ->
    o.duration
  ))

  console.log("maxqsotime = " + maxqsotime)

  barHeight = 20

  x = d3.scale.linear().range([ 0, width]).domain([0, d3.max(data) ])

  chart = d3.select('#graph')
        .attr('width', width)
        .attr('height', height)

  chart.append('circle')
        .attr('cx', xorg)
        .attr('cy', yorg)
        .attr('r', maxlen)
        .attr('stroke', "black")
        .attr('fill-opacity', 0)
        .attr('stroke-width', "3")

  # create groups evenly spaced around a cirle, one for each data point
  segment = chart.selectAll('g')
        .data(data)
        .enter()
        .append('g')
        .attr('transform', (d, i) -> 'translate(' + xorg + ',' + yorg + ') rotate(' + i * angle + ',0, 0) ')

  # Now create something interesting in each segment
  segment.append('rect')
        .attr('width', 6)
        .attr('height', maxlen)
        .attr('transform', (d, i) -> 'translate( -3, 0)')
        .style 'fill', (d) ->
          qsocolor(d.mode)

  segment.append('polygon')
        #.attr('points', pp)
        .attr('points', polypoints(angle, maxlen/2, 100, (d) -> (d.duration/maxqsotime)*maxlen))
        .attr('fill', (d) ->
          qsocolor(d.mode))
        #.attr('fill', "red")
        .attr('stroke', "black")
        .attr('stroke-width', "1")



#  segment.append('text')
#        .attr('x', (d) -> x(d) - 10).attr('y', barHeight / 2)
#        .attr('dy', '.35em')
#        .style('fill', 'white').text (d) -> d
  return

error = ->
  console.log 'error'
  return

$.ajax
  type: 'GET'
  contentType: 'application/json; charset=utf-8'
  url: '/graph/data'
  dataType: 'json'
  success: (data) ->
    draw data
    return
  error: (result) ->
    error()
    return
