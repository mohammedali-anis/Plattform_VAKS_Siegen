<!DOCTYPE html>
<html xmlns="https://www.thymeleafe.org">
<head>
<meta charset="ISO-8859-1">
<title>High Chart Example - Spring Boot</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<link rel="stylesheet" href="https://code.highcharts.com/css/highcharts.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://code.highcharts.com/highcharts.js"></script>
<script src="https://code.highcharts.com/modules/exporting.js"></script>
<script src="https://code.highcharts.com/modules/export-data.js"></script>
<script src="https://code.highcharts.com/modules/accessibility.js"></script>
</head>
<body>
    <div align="center">
        <h2>Spring Boot Highcharts Example</h2>
    </div>
    <figure class="highcharts-figure">
        <div id="container-bar"></div>
    </figure>
    <script type="text/javascript">
        $(document).ready(
                function() {
                    $.ajax({
                        url : "/get-data",
                        success : function(result) {
                            var yearDtls = [];
                            var countDtls = [];
                            console.log(result);
                            Object.keys(result).forEach(
                                    function(key) {
                                        yearDtls.push(key);
                                        countDtls.push(result[key]);
                                    });
                            drawChart(yearDtls, countDtls);
                        }
                    });
                });
        function drawChart(year, viewCounts) {
            Highcharts.chart('container-bar', {
                chart : {
                    type : 'column',
                    styledMode : true
                },
                title : {
                    text : 'Blog Page view count'
                },
                xAxis : [ {
                    title : {
                        text : 'Gender'
                    },
                    categories : year
                } ],
                yAxis : [ {
                    className : 'highcharts-color-0',
                    title : {
                        text : 'Page View Count'
                    }
                } ],
                series : [ {
                    data : viewCounts
                } ]
            });
        }
    </script>
</body>
</html>