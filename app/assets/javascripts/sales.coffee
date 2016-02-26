# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  data = {
    labels : $('#sales_chart').data('ticks'),
    datasets : [
      {
        fillColor : "rgba(220,220,220,0.5)",
        strokeColor : "rgba(220,220,220,1)",
        pointColor : "rgba(220,220,220,1)",
        pointStrokeColor : "#fff",
        data : $('#sales_chart').data('sales')
      }
    ]
  }

  myNewChart = new Chart($("#sales_chart").get(0).getContext("2d")).Line(data, {responsive: true})
