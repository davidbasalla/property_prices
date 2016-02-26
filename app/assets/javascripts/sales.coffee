# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  data = {
    labels : $('#sales_chart').data('ticks'),
    datasets : [
      {
        type:'line',
        borderColor: "rgba(151,187,205,1)",
        label: "Average Property Sale Price",
        backgroundColor: "rgba(151,187,205,0.2)",
        pointStrokeColor: "#fff",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(151,187,205,1)",
        data : $('#sales_chart').data('sales')
      },
      {
        type:'bar',
        label: "Units sold (relative, not to scale)",
        borderColor: "rgba(255, 153, 0, 1)",
        backgroundColor: "rgba(255, 153, 0, 0.4)",
        pointStrokeColor: "#fff",
        pointHighlightFill: "#fff",
        pointHighlightStroke: "rgba(151,187,205,1)",
        data : $('#sales_chart').data('counts')
      },
    ]
  }

  ctx = $("#sales_chart").get(0).getContext("2d")
  myNewChart = new Chart(ctx, { type: "bar", data: data, scaleBeginAtZero: true })
