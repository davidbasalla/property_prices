# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  data = {
    labels : $('#sales_chart').data('ticks'),
    datasets : [
      {
        fillColor: "rgba(151,187,205,0.2)",
        strokeColor: "rgba(151,187,205,1)",
        pointColor: "rgba(151,187,205,1)",
        pointStrokeColor: "#fff",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(151,187,205,1)",
        data : $('#sales_chart').data('sales')
      }
    ]
  }

  myNewChart = new Chart($("#sales_chart").get(0).getContext("2d")).Line(data, {responsive: true, scaleBeginAtZero: true})
