$ = jQuery if window.jQuery

addEvent: (el, event, fn) ->
  $(el).bind(event, fn)

class Point

  constructor: (series, options) ->
    @series = series


class Series

  constructor: (chart, options) ->
    @chart = chart


class Chart

  constructor: (@options, @callback) ->
    @optionsChart = @options.chart
    @idCounter = 0
    this.render()

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

  getChartSize: ->
    containerWidth = @renderTo.offsetWidth
    containerHeight = @renderTo.offsetHeight
    @chartWidth ||= @optionsChart.width || containerWidth || 600
    @chartHeight ||= @optionsChart.height || containerHeight || 400

  render: ->
    this.getContainer()
    #resetMargins()
    #setChartSize()

    #initSeries(serie) for serie of options.series

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