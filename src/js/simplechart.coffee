# Shortcut for jQuery
$ = jQuery if window.jQuery

# Add an event listener
#
# el - DOM element
# event - Event function is called upon
# fn - Function
addEvent: (el, event, fn) ->
  $(el).bind(event, fn)

class Point
  # A point object containing coordinates
  #
  # series - Instance of series
  # data - Double values array
  constructor: (@series, @data) ->
    this.parseData()
    @series.chart.pointsCount++

  # Set x and y coordinates from data values
  parseData: ->
    @x = @data[0]
    @y = @data[1]

class Series
  # A series is a collection of points corresponding to the
  # data passed in series' options
  #
  # chart - An instance of chart
  # options - Series' options
  constructor: (@chart, @options={}) ->
    this.getColor()
    this.setData(@options.data)

  # Get the series' color from chart options
  getColor: ->
    colors = @chart.options.colors
    counter = @chart.options.colorCounters
    @color = @options.color || colors[counter++] || '#0000ff'

  # Return an array of point corresponding to the data passed
  # in the options
  #
  # data - An array of values ([[1, 2], [3, 4]])
  setData: (data) ->
    @point.push(new Point(this, d)) for d in data
    # series.cleanData();
		# series.getSegments();
		# series.getAttribs();

class Chart
  # A chart is contructed with data passed in options
  #
  # options - Hash containing all options
  # callback - Function called when chart has been drawed
  constructor: (@options, @callback) ->
    @optionsChart = @options.chart
    @idCounter = 0
    @colorCounters = 0
    @pointsCount = 0
    this.render()

  # Get the container, determine the size and create the inner div
  # that will contain the chart
  getContainer: ->
    renderTo = @optionsChart.renderTo
    containerId = "simplechart-#{@idCounter++}"

    @renderTo = $(renderTo) if typeof(renderTo) is 'string'
    @renderTo.innerHTML = ''

    this.getChartSize()

    @container = $('<div />', {
      id: containerId,
      class: 'simplechart-container'
    }).css({
      position: 'relative',
      oveflow: 'hidden',
      width: @chartWidth,
      height: @chartHeight,
      textAlign: 'left'
    })

    @container.appendTo(renderTo)

  # Get chart size according to options or container size
  getChartSize: ->
    containerWidth = @renderTo.offsetWidth
    containerHeight = @renderTo.offsetHeight
    @chartWidth ||= @optionsChart.width || containerWidth || 600
    @chartHeight ||= @optionsChart.height || containerHeight || 400

  render: ->
    this.getContainer()
    #resetMargins()
    #setChartSize()

    @series.push(new Series(this, serie)) for serie of options.series

    true
    #getAxes()

    # Do render
    #setTitle()
    #getMargins()
    #drawChartBox()

    #axe.render() for axe in chart.axes
    #serie.render() for serie in options.series

    #true
    # callback.apply(chart, [chart]) if callback

ExternalChart = (options, callback) ->
  new Chart(options, callback)

window.Simplechart = {
  Chart: ExternalChart
}