# built using this example: http://bl.ocks.org/sathomas/11550728

qsocolor = (mode) ->
  if mode == "voice"
    return "green"
  else if mode == "data"
    return "red"
  else if mode == "root"
    return "lightblue"
  else
    return "blue"

draw = (data) ->
  nodes = data.stations
  links = data.qsos

  console.log(nodes)
  console.log(links)

  width = 840
  height = 840

  # Create a scale for circle size based on duration of QSO
  minr = 30
  maxr = 100
  durscale = d3.scale.linear()
        .domain d3.extent(nodes.slice(1), (d) -> d.duration)
        .range([minr, maxr])

  svg = d3.select('#graph')
        .attr('width', width)
        .attr('height', height)

  force = d3.layout.force()
        .gravity(0.05)
        .distance(100)
        .charge(-100)
        .size([width,height])
        .nodes(nodes)
        .links(links)

  force.linkDistance width / 3

  link = svg.selectAll('.link')
        .data(links)
        .enter()
        .append('line')
        .attr('class', 'link')

  node = svg.selectAll('.node')
        .data(nodes)
        .enter()
        .append('circle')
        .attr('class', 'node')

  force.on 'tick', ->
    nodes[0].x = width / 2
    nodes[0].y = height / 2
    return
        
  force.on 'end', ->
    node.attr('r', (d) -> durscale(d.duration))
        .attr('cx', (d) -> d.x)
        .attr('cy', (d) -> d.y)
        .attr('stroke', "black")
        .attr('stroke-width', 2)
        .attr('fill', (d) -> qsocolor(d.mode))
        .attr('fill-opacity', "0.4")
    node.append('text')
        #.attr('dx', 20)
        #.attr('dy', ".35em")
        #.text((d) -> d.call)
        .text("foo")

    link.attr('x1', (d) -> d.source.x)
        .attr('y1', (d) -> d.source.y)
        .attr('x2', (d) -> d.target.x)
        .attr 'y2', (d) -> d.target.y
        .attr('stroke', "black")
        .attr('stroke-width', 4)
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
