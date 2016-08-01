# built using this example: http://bl.ocks.org/sathomas/11550728

qsocolor = (mode) ->
  if mode == "voice"
    ncolor = "green"
  else if mode == "data"
    ncolor = "red"
  else
    ncolor = "lightblue"
  return ncolor

draw = (data) ->
  nodes = data.stations
  links = data.qsos

  width = 520
  height = 520

  # Create a scale for circle size based on duration of QSO
  minr = 50
  maxr = 90
  durscale = d3.scale.linear()
        .domain d3.extent(nodes.slice(1), (d) -> d.duration)
        .range([minr, maxr])

  title = d3.select("#qsotitle")
        .text("AMSAT Phase 4 QSO from " + nodes[0].call + " To Radio " + nodes[1].call)

  table = d3.select("#qsotable")

  tblhdr = table.append('tr')
  tblhdr.append('td').text("Day")
  tblhdr.append('td').text("Month")
  tblhdr.append('td').text("Year")
  tblhdr.append('td').text("Time (UTC)")
  tblhdr.append('td').text("Duration (S)")
  tblhdr.append('td').text("Mode")

  numqsos = nodes.length
  console.log(numqsos)
  i = 1
  while i < numqsos
    qrow = table.append('tr')
    qrow.append('td').text(nodes[i].time.split('/')[1]) # day
    qrow.append('td').text(nodes[i].time.split('/')[0]) # month
    qrow.append('td').text(nodes[i].time.split('/')[2].split(' ')[0]) # year
    qrow.append('td').text(nodes[i].time.split('/')[2].split(' ')[1]) # time
    qrow.append('td').text(nodes[i].duration)
    qrow.append('td').text(nodes[i].mode)
    i++

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
