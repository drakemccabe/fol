GoogleLineChart = React.createFactory( React.createClass(
  render: ->
    React.DOM.div
      id: @props.graphName
      ref: 'graphDiv'
      style: height: '300px'
  componentDidMount: ->
    @drawCharts()
  componentDidUpdate: ->
    @drawCharts()
  drawCharts: ->
    data = google.visualization.arrayToDataTable(@props.data)
    options = title: 'Sales per year'
    chart = new google.visualization.LineChart(@refs.graphDiv.getDOMNode())
    chart.draw data, options
))

options =
  dataType: 'script'
  cache: true
  url: 'https://www.google.com/jsapi'

setup: () ->
  $('#link5').click (ev) ->
    ev.preventDefault()
    loadDonationChart()

loadDonationChart: () ->
  $.ajax(options).done ->
    google.load 'visualization', '1',
      packages: [ 'corechart' ]
      callback: ->
        React.render GoogleLineChart(
          graphName: 'lineGraph'
          data: [['Year', 'Items Sold'], ['2004', 20], ['2005', 35], ['2006', 25], ['2007', 50]]
        ), document.getElementById('table')
