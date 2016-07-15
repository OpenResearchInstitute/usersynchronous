draw = (data) ->
  color = d3.scale.category20b()
  width = 420
  barHeight = 20
  x = d3.scale.linear().range([
    0
    width
  ]).domain([
    0
    d3.max(data)
  ])
  chart = d3.select('#graph').attr('width', width).attr('height', barHeight * data.length)
  bar = chart.selectAll('g').data(data).enter().append('g').attr('transform', (d, i) ->
    'translate(0,' + i * barHeight + ')'
  )
  bar.append('rect').attr('width', x).attr('height', barHeight - 1).style 'fill', (d) ->
    color d
  bar.append('text').attr('x', (d) ->
    x(d) - 10
  ).attr('y', barHeight / 2).attr('dy', '.35em').style('fill', 'white').text (d) ->
    d
  return

error = ->
  console.log 'error'
  return

$.ajax
  type: 'GET'
  contentType: 'application/json; charset=utf-8'
  url: 'data'
  dataType: 'json'
  success: (data) ->
    draw data
    return
  error: (result) ->
    error()
    return
