#  {
#    'satellite': 'phase4',
#    'mode': 'voice',
#    'duration': 20,
#    'station': 'N1NLY',
#  }

# built using this example: http://bl.ocks.org/sathomas/11550728

#qsocolor = (mode) ->
#  if mode == "voice"
#    return "green"
#  else if mode == "data"
#    return "red"
#  else
#    return "blue"

draw = (data) ->
  nodes = data.stations
  links = data.qsos

  console.log(nodes)
  console.log(links)

  width = 420
  height = 420

  svg = d3.select('#graph')
        .attr('width', width)
        .attr('height', height)

  force = d3.layout.force().size([
    width
    height
  ]).nodes(nodes).links(links)

  force.linkDistance width / 3

  link = svg.selectAll('.link').data(links).enter().append('line').attr('class', 'link')

  node = svg.selectAll('.node').data(nodes).enter().append('circle').attr('class', 'node')

  force.on 'end', ->
    node.attr('r', width / 25).attr('cx', (d) ->
      d.x
    ).attr 'cy', (d) ->
      d.y

    link.attr('x1', (d) -> d.source.x)
    .attr('y1', (d) -> d.source.y)
    .attr('x2', (d) -> d.target.x)
    .attr 'y2', (d) -> d.target.y
    return

  force.start()

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
