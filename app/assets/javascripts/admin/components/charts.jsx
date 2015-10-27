var React = require('react');
var Highcharts = require('react-highcharts');
var monthDonations = "";
$authkey = $('#tokendiv').attr('data-idtoken');

$.ajax({
      type: "GET",
      beforeSend: function (request)
      {
        request.setRequestHeader("authorization", $authkey);
      },
      url: "/stats",
      dataType: 'json',
      cache: true,
      success: function(data) {
        chartMonthFunction(data)
      }
    });

function chartMonthFunction(data) {
  monthDonations = data['stats']
  for(i = 0; i < monthDonations.length; i++) {
    donationsMonth.series[0].data.push(monthDonations[i][1])
    donationsMonth.xAxis.categories.push(monthDonations[i][0])
  }
  renderDonationChart();
}

var donationsMonth = {
  title : {
    text : 'Donations: Last 30'
  },

  xAxis: {
    categories: []
  },
  series: [{
    data: []
  }]
};

function renderDonationChart() {
  React.render(<Highcharts config = {donationsMonth}></Highcharts>, document.getElementById('sidebar1'));
}

$.ajax({
      type: "GET",
      beforeSend: function (request)
      {
        request.setRequestHeader("authorization", $authkey);
      },
      url: "/stats/1",
      dataType: 'json',
      cache: true,
      success: function(data) {
        chartYearFunction(data)
      }
    });

function chartYearFunction(data) {
  yearDonations = data['stats']
  for(i = 0; i < yearDonations.length; i++) {
    donationsYear.series[0].data.push(yearDonations[i][1])
    donationsYear.xAxis.categories.push(yearDonations[i][0])
  }
  renderDonationYearChart();
}

var donationsYear = {
  title : {
    text : 'Donations: Last 365'
  },

  xAxis: {
    categories: []
  },
  series: [{
    data: []
  }]
};

function renderDonationYearChart() {
  React.render(<Highcharts config = {donationsYear}></Highcharts>, document.getElementById('sidebar2'));
}
