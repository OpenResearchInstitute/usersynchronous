# built using this example: http://bl.ocks.org/sathomas/11550728

qsocolor = (mode) ->
  console.log("Enter")
  console.log(mode)
  if mode == "voice"
    ncolor = "green"
  else if mode == "data"
    ncolor = "red"
  else
    ncolor = "lightblue"
  console.log("returning")
  console.log(ncolor)
  return ncolor

draw = (data) ->
  nodes = data.stations
  links = data.qsos

  width = 840
  height = 840

  # Create a scale for circle size based on duration of QSO
  minr = 40
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

  nodeg = svg.selectAll('.node')
        .data(nodes)
        .enter()
        .append('g')
  node = nodeg.append('circle').attr('class', 'node')
  label = nodeg.append('text').attr('class', 'label')
  #callsign = label.append('tspan').attr('class', 'label')

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

    label.attr('x', (d) -> d.x)
        .attr('y', (d) -> d.y)
    duration = (d) -> d.duration
    label.append('tspan')
        .text((d) -> d.call)
        .attr('dx', 0)
        .attr('x', (d) -> d.x)
        .attr('dy', -14)
        .attr('text-anchor', "middle")
    label.append('tspan')
        .text((d) -> d.mode)
        .attr('dx', 0)
        .attr('x', (d) -> d.x)
        .attr('dy', 14)
        .attr('text-anchor', "middle")
    label.append('tspan')
        .text((d) -> d.time)
        .attr('dx', 0)
        .attr('x', (d) -> d.x)
        .attr('dy', 14)
        .attr('text-anchor', "middle")
    #label.append('tspan').text((d) -> d.duration).attr('dx', -25).attr('dy', 14).attr('text-anchor', "middle")

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
