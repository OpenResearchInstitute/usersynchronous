#  {
#    'satellite': 'phase4',
#    'mode': 'voice',
#    'duration': 20,
#    'station': 'N1NLY',
#  }

draw = (data) ->
  color = d3.scale.category20b()
  width = 420
  height = 420
  xorg = width / 2
  yorg = height / 2
  numqsos = data.length
  angle = 360.0 / numqsos
  maxlen = width / 2

  barHeight = 20

  x = d3.scale.linear().range([ 0, width]).domain([0, d3.max(data) ])

  chart = d3.select('#graph')
        .attr('width', width)
        .attr('height', height)

  # create groups evenly spaced around a cirle, one for each data point
  segment = chart.selectAll('g')
        .data(data)
        .enter()
        .append('g')
        .attr('transform', (d, i) -> 'translate(' + xorg + ',' + yorg + ') rotate(' + i * angle + ',0, 0) ')

  # Now create something interesting in seach segment
  segment.append('rect')
        .attr('width', 6)
        .attr('height', maxlen)
        .attr('transform', (d, i) -> 'translate( -3, 0)')
        .style 'fill', (d) -> color d

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
