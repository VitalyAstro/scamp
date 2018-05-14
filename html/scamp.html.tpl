<!DOCTYPE html>
<html>
	<head>
		<title>Processing Summary</title>
		<link 
			rel="stylesheet" 
			href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" 
			integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" 
			crossorigin="anonymous">
		<link 
			rel="stylesheet" 
			href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" 
			integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" 
			crossorigin="anonymous">
        <link 
            rel="stylesheet" 
            href="https://aladin.u-strasbg.fr/AladinLite/api/v2/latest/aladin.min.css" />

        <link 
            rel="stylesheet" 
            href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-table/1.12.1/bootstrap-table.min.css">

	    <style type="text/css">
			@-ms-viewport     { width: device-width; }
			@-o-viewport      { width: device-width; }
			@viewport         { width: device-width; }
            canvas {
                -moz-user-select: none;
                -webkit-user-select: none;
                -ms-user-select: none;
            }

            .chart-container {
                width: 350px;
                margin-left: 40px;
                margin-right: 40px;
                margin-bottom: 40px;
            }
            .container {
                display: flex;
                flex-direction: row;
                flex-wrap: wrap;
                justify-content: center;
            }
    	</style>

		<!--[if lt IE 9]>
      		<script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      		<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    	<![endif]-->
	</head>
	<body>




		<nav class="navbar navbar-inverse " role="navigation">
      		<div class="container-fluid">
        		<div class="navbar-header">
          			<a 
						style="padding-top:4px;" 
						class="navbar-brand" 
						target="_blank" href="http://astromatic.net">
							<img 
								style="height: 50px; margin-top:0px;" 
								alt="astromatic" 
								src="http://astromatic.net/xsl/astromatic.png">
					</a>
				</div>

				<div class="nav navbar-nav navbar-right">
					<p class="navbar-text pull-right">
						<strong>
							<a target="_blank" 
								href="https://github.com/astromatic/scamp">
									<span id="soft" 
										class="label label-primary" 
										style="font-size:50;"></span>
							</a>
						</strong> 
						completed on <strong><span id="date"></span></strong>
						at <strong><span id="time"></span></strong> 
						using <strong><span id="nthreads"></span> </strong>
						threads (run time: <strong><span id="runtime"></span></strong>)
						started by user <strong><span id="username"></span></strong> 
						in <strong><span id="rundir"></span></strong>.
					</p>
        		</div> <!-- navright -->
      		</div> <!--container-fluid-->
    	</nav> <!-- nav -->




		<div class="container-fluid role="main"">
			<div class="row-fluid">
				<div class="col-xs-0 col-sm-6 col-md-3">
					<div class="list-group">
						<a href="#inputFiles" class="list-group-item">Input files</a>
						<a href="#groupProperties" class="list-group-item">Group properties</a>
						<a href="#astroInstru" class="list-group-item">Astrometric Instruments</a>
						<a href="#photoInstru" class="list-group-item">Photometric Instruments</a>
						<a href="#configFile" class="list-group-item">Configuration file</a>
					</div>
				</div> <!-- col-md3 -->

				<div class="col-xs-12 col-sm-6 col-md-9">

                    <div class="panel panel-default">
                        <div class="panel-heading text-center">Catalogs Footprint</div>
                        <div id="aladin-lite-div" class="panel-body" style="width: 100%; height:600px;"></div>
                    </div>
                </div>
            </div>
            <div class="row-fluid">
                <div class="col-md-12">
                    <div class="panel panel-default">
                        <div class="panel-heading text-center">Comparative charts</div>

                        <div class="panel-body">
                            <div class="btn-toolbar" role="toolbar">
                                <div class="btn-group btn-group-xs" role="group">
                                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                        Table <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li>Summary</li>
                                        <li>Groups</li>
                                        <li>Astro.Instru.</li>
                                        <li>Photo.Instru.</li>
                                    </ul>
                                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                        Type <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li>Chart</li>
                                        <li>Plot</li>
                                    </ul>
                                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                        X <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li>b</li>
                                        <li>b</li>
                                        <li>b</li>
                                    </ul>
                                    <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown">
                                        Y <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu">
                                        <li>b</li>
                                        <li>b</li>
                                        <li>b</li>
                                    </ul>
                                </div>
                            </div>

                            <div class="chart-container col-md-4">
                                <canvas width="300" height="150" id="myChart"></canvas>
                            </div>
                        </div>
                    </div>

					<div id="inputFiles" class="panel panel-default">
						<div class="panel-heading text-center">Summary Table on Input Files</div>
						<div class="panel-body table-responsive">
							<table id="fieldsTable" class="table table-hover table-bordered table-striped">
			    				<thead>
									<tr>
										<th data-sortable="true">#</th>
										<th data-sortable="true" data-field="Filename">Filename</th>
										<th>Identifier</th>
										<th>Next</th>
										<th>Ndet</th>
										<th>Flags</th>
										<th>G</th>
										<th>A</th>
										<th>P</th>
										<th>Date</th>
										<th>Exposure Time</th>
										<th>Air Mass</th>
										<th>Right Ascension</th>
										<th>Declination</th>
										<th>Radius</th>
										<th>Pixel scale</th>
										<th class="showmatch">&#916;Pixel scale</th>
										<th class="showmatch">&#916;Position Angle</th>
										<th class="showmatch">A/S contrast</th>
										<th class="showmatch">&#916;X</th>
										<th class="showmatch">&#916;Y</th>
										<th class="showmatch">X/Y contrast</th>
				    					<th>&#967;2int</th>
										<th>&#967;2int High S/N</th>
										<th>&#967;2ref</th>
										<th>&#967;2ref High S/N</th>
										<th>Mag &#916;SP</th>
									</tr>
			    				</thead>
							<tbody>
							</tbody>
						</table>
					</div> <!--panel-body-->
				</div> <!--panel -->

				<div id="groupProperties" class="panel panel-default">
					<div class="panel-heading text-center">Group Properties</div>
					<div class="panel-body table-responsive">
						<table id="groupsTable" class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Group name</th>
									<th class="showplot">Group Plot</th>
									<th>Index</th>
									<th>NFields</th>
									<th>Right Ascension</th>
									<th>Declination</th>
									<th>Pixel scale</th>
									<th>Maximum radius</th>
									<th>Astrom. Ref. Catalog</th>
									<th>Astrom. Ref. Band</th>
									<th class="showplot">&#967;2 Plot</th>
									<th>Astrom. &#963;int</th>
									<th>Astrom. &#961;int</th>
									<th>Astrom. &#967;2int</th>
									<th>Astrom. N2int</th>
									<th>Astrom. &#963;int High S/N</th>
									<th>Astrom. &#961;int High S/N</th>
									<th>Astrom. &#947;2int High S/N</th>
									<th>Astrom. N2int High S/N</th>
									<th class="showplot">Astrom. 1-D Int. Error Plot</th>
									<th class="showplot">Astrom. 2-D Int. Error Plot</th>
									<th>Astrom. &#916;RA ref, &#916; DEC ref</th>
									<th>Astrom. &#963;ref</th>
									<th>Astrom. &#961;ref</th>
									<th>Astrom. &#967;2ref</th>
									<th>Astrom. Nref</th>
									<th>Astrom. &#916;RA ref, &#916; DEC ref High S/N</th>
									<th>Astrom. &#963;ref High S/N</th>
									<th>Astrom. &#961;ref High S/N</th>
									<th>Astrom. &#947;2ref High S/N</th>
									<th>Astrom. Nref High S/N</th>
									<th class="showplot">Astrom. 1-D Ref. Error Plot</th>
									<th class="showplot">Astrom. 2-D Ref. Error Plot</th>
									<th>Photom. instruments</th>
									<th>Photom. &#963;int</th>
									<th>Photom. &#967;2int</th>
									<th>Photom. Nint</th>
									<th>Photom. &#963; High S/N</th>
									<th>Astrom. &#947;2int High S/N</th>
									<th>Photom. Nint High S/N</th>
									<th>Photom. &#963;ref</th>
									<th>Photom. &#967;2ref</th>
									<th>Photom. Nref</th>
									<th>Photom. &#963;ref High S/N</th>
									<th>Photom. &#947;2ref High S/N</th>
									<th>Photom. Nref High S/N</th>
									<th class="showplot">Photom. Internal Error Plot</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div> <!--panel-body-->
				</div> <!--panel -->

				<div class="row">
					<div class="col-md-6"> 
						<div id="astroInstruments" class="panel panel-default">
							<div class="panel-heading text-center">Astrometric Instruments</div>
							<div class="panel-body table-responsive">
								<table id="astrometricInstrumentsTable" class="table table-striped" >
									<thead>
										<tr>
											<th>Name</th>
											<th>Index</th>
											<th>NFields</th>
											<th>Number of Keywords</th>
											<th>Keywords</th>
											<th class="showplot">Distortion Plot</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div> <!--panel-body-->
						</div> <!--panel -->
					</div>
		
					<div class="col-md-6"> 
						<div id="photoInstruments" class="panel panel-default">
							<div class="panel-heading text-center">Photometric Instruments</div>
							<div class="panel-body table-responsive">
		
								<table id="photometricInstrumentsTable" class="table t table-striped">
									<thead>
										<tr>
											<th>Name</th>
											<th>Index</th>
											<th>NFields</th>
											<th>Output ZP</th>
											<th>Number of Keywords</th>
											<th>Keywords</th>
										</tr>
									</thead>
									<tbody>
									</tbody>
								</table>
							</div> <!--panel-body-->
						</div> <!--panel -->
					</div>
				</div>
					<div id ="warningDiv" class="alert alert-warning">
						<h3>Warnings</h3>
						<table id="warningsTable" class="table table-responsive table-striped">
							<thead>
								<tr>
									<th>Date</th>
									<th>Time</th>
									<th>Message</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div> <!--alert -->

				<div id="configFile" class="panel panel-default">
					<div class="panel-heading text-center">Configuration File</div>
					<div class="panel-body table-responsive">
						<table id="configTable" class="table t table-responsive table-striped">
							<thead>
								<tr>
									<th>Config Parameter</th>
									<th>Value</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div> <!--panel-body-->
				</div> <!--panel -->
			</div> <!-- row -->
		</div> <!--container-->



		<!-- SCRIPTS BEGIN -->
        <script
            src="https://code.jquery.com/jquery-3.3.1.min.js"
            integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
            crossorigin="anonymous"></script>
		<script 
			src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" 
			integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" 
			crossorigin="anonymous"></script>
		<script>
			/*! 
			 * IE10 viewport hack for Surface/desktop Windows 8 bug
 			 * Copyright 2014-2015 Twitter, Inc.
 			 * Licensed under MIT (https://github.com/twbs/bootstrap/blob/master/LICENSE)
 			 */

			(
				function () {
  					'use strict';

  					if (navigator.userAgent.match(/IEMobile\/10\.0/)) {
    					var msViewportStyle = document.createElement('style')
    					msViewportStyle.appendChild(
      						document.createTextNode(
        						'@-ms-viewport{width:auto!important}'
      						)
    					)
    					document.querySelector('head').appendChild(msViewportStyle)
  					}
				} 
			)();
		</script>
        <script type="text/javascript" 
            src="https://aladin.u-strasbg.fr/AladinLite/api/v2/latest/aladin.min.js" 
            charset="utf-8"></script>
        <script type="text/javascript"
            src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.7.2/Chart.min.js"
            charset="utf-8"></script>
        <script>
            var ctx = document.getElementById("myChart").getContext('2d');
            new Chart(ctx, {
                responsive: true,
                maintainAspectRation: false,
                type: 'bar',
                data: {
                    labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
                    datasets: [{
                        label: '# of Votes',
                        data: [12, 19, 3, 5, 2, 3],
                        backgroundColor: [
                            'rgba(255, 99, 132, 0.2)',
                            'rgba(54, 162, 235, 0.2)',
                            'rgba(255, 206, 86, 0.2)',
                            'rgba(75, 192, 192, 0.2)',
                            'rgba(153, 102, 255, 0.2)',
                            'rgba(255, 159, 64, 0.2)'
                        ],
                        borderColor: [
                            'rgba(255,99,132,1)',
                            'rgba(54, 162, 235, 1)',
                            'rgba(255, 206, 86, 1)',
                            'rgba(75, 192, 192, 1)',
                            'rgba(153, 102, 255, 1)',
                            'rgba(255, 159, 64, 1)'
                        ],
                        borderWidth: 1
                    }]
                },
                options: {
                    scales: {
                        yAxes: [{
                            ticks: {
                                beginAtZero:true
                            }
                        }]
                    }
                }
            });
        </script>

		<script>
            /* first initialize aladin */
            var aladin = A.aladin('#aladin-lite-div', {
                survey: "P/DSS2/color", 
                fov: 60,
                showReticle: false,
                showZoomControl: true,
                showFullScreenControl: true,
                showLayersControl: true,
                showGotoControl: false,
                showShareControl: false,
                fulscreen: false
                });

            /*                                                                     
             *                                                                     
             * Data contained in "scamp_data" object, is loaded at the very end 
             * of this html file is his own <script> tag.                          
             *                                                                     
             */                                                                    
                                                                                   
            /* from an array of object (data), return the "value" property of   
             * object havinig "str" as "name" property. */   
			function getElemVal(str, data) {
				var value = "";
				$.each(data, function (i, elem) {
					if (elem.name == str) {
						value = elem.value;
						return;
					}
				});
				return value;
			}

			function getFlagValHelper(b, t) {
				if (b)
					return t;
				return "-";
			}

			function getElemAverageValHelper(a) {
				var value = 0.0;
				var n = 0;
				$.each(a, function(i, elem) {
					value += elem;
					n++;
				});
				return value / n;
			}

			function getElemListValHelperFixedHelper(arr, unit, fix) {
				var value = "";
				$.each(arr, function(i, elem) {
					if (fix >= 0) {
						elem = elem.toFixed(fix);
					}
					value += elem + unit + " ";
				});
				return value;
			}

			function getElemListValHelper(arr, unit) {
				return getElemListValHelperFixedHelper(arr, unit, -1);
			}

			function getRaValHelper(value) {
				var a = Math.floor(value[0] / 15.0);
				var b = Math.floor((value[0] * 4) % 60);
				var c = Math.floor((value[0] *240) % 60);
				return a + ":" + b + ":" + c.toFixed(2);
			}

			function getDecValHelper(value) {
				var sign = "";
				if (value[1] < 0) {
					sign = "-";
					value[1] = 0 - value[1];
				}
				var a = Math.floor(value[1]);
				var b = Math.floor((value[1] * 60) % 60);
				var c = Math.floor((value[1] * 3600) % 60);

				return sign + a + ":" + b + ":" + c.toFixed(2);
			}

            function getRandomColor() {
                var letters = '0123456789ABCDEF';
                var color = '#';
                for (var i = 0; i < 6; i++) {
                    color += letters[Math.floor(Math.random() * 16)];
                }
                return color;
            }

            function setAladinPos() {
                var left_max    = 1000;
                var top_max     = -1;
                var right_max   = -1;
                var bottom_max  = 1000;
				$.each(scamp_data.Fields, function(i, field) {
                    for (var i=0; i<field.Set_Polygon.value.length; i++) {
                        var poly = field.Set_Polygon.value[i];
                        if (poly[0][0] < left_max)
                            left_max = poly[0][0];
                        if (poly[0][1] > top_max)
                            top_max = poly[0][1];
                        if (poly[1][0] > right_max)
                            right_max = poly[1][0];
                        if (poly[2][1] < bottom_max)
                            bottom_max = poly[2][1];
                    }
                })

                var center_lng = (left_max + right_max) / 2;
                var center_lat = (top_max + bottom_max) / 2;
                aladin.gotoRaDec(center_lng, center_lat);

                var height_max = Math.abs(top_max - bottom_max);
                aladin.setFov(height_max * 4);
            }

            function aladinDraw(higlight) {
                /* TODO highlight a field */
                $.each(scamp_data.Fields, function(i, field) {
                    var overlay = A.graphicOverlay({color: getRandomColor(), lineWidth: 1});
                    aladin.addOverlay(overlay);

                    for (var i=0; i<field.Set_Polygon.value.length; i++) {
                        var poly = field.Set_Polygon.value[i];
                        var drawline = poly;
                        drawline.push(poly[0]);
                        overlay.add(A.polyline(drawline));
                    }
                })
            }


			$(document).ready(function() {
                aladinDraw();
				console.log(scamp_data);

				/* build status string */
				$('#soft').text(scamp_data.Software.Name.value +" "+scamp_data.Software.Version.value);
				$('#date').text(scamp_data.Software.Date.value);
				$('#time').text(scamp_data.Software.Time.value);
				$('#nthreads').text(scamp_data.Software.NThreads.value);
				$('#runtime').text(scamp_data.Software.Duration.value + " s");
				$('#username').text(scamp_data.Software.User.value);
				$('#rundir').text(scamp_data.Software.Path.value);

				/* show/hide match option and plots */
				var showmatch = getElemVal("MATCH", scamp_data.Configuration);
				var showplot  = getElemVal("CHECK_PLOT_DEV", scamp_data.Configuration);
				showplot = (showplot > "PNG" || showplot > "PNG" ) ? false : true;

				/* 
				 * build fields table 
				 */
				$.each(scamp_data.Fields, function(i, field) {
					var table_row = "";
					table_row += "<tr>";
					table_row += "<td>" +  field.Catalog_Number.value + "</td>";
					table_row += "<td>" +  field.Catalog_Name.value + "</td>";
					table_row += "<td>" +  field.Image_Ident.value + "</td>";
					table_row += "<td>" +  field.NExtensions.value + "</td>";
					table_row += "<td>" +  field.NDetect.value + "</td>";
					table_row += "<td>" +  getFlagValHelper(field.Ext_Header.value, "H")  + getFlagValHelper(field.Photom_Flag, "P") +  "</td>";
					table_row += "<td>" +  field.Group.value + "</td>";
					table_row += "<td>" +  field.Astr_Instrum.value + "</td>";
					table_row += "<td>" +  field.Phot_Instrum.value + "</td>";
					table_row += "<td>" +  field.Observation_Date.value + "</td>";
					table_row += "<td>" +  field.Exposure_Time.value.toFixed(3) + "</td>";
					table_row += "<td>" +  field.Air_Mass.value.toFixed(2) + "</td>";
					table_row += "<td>" +  getRaValHelper(field.Field_Coordinates.value) + "</td>";
					table_row += "<td>" +  getDecValHelper(field.Field_Coordinates.value) + "</td>";
					table_row += "<td>" +  field.Max_Radius.value.toFixed(3) + "'" + "</td>";
					table_row += "<td>" +  getElemAverageValHelper(field.Pixel_Scale.value).toFixed(4) + "''" + "</td>";

					if (showmatch) {
						table_row += "<td>" +  field.DPixel_Scale.value.toFixed(4) + "</td>";
						table_row += "<td>" +  field.DPos_Angle.value + "°" + "</td>";
						table_row += "<td>" +  field.AS_Contrast.value.toFixed(1) + "</td>";
						table_row += "<td>" +  field.DX.value.toExponential() + "°" + "</td>";
						table_row += "<td>" +  field.DY.value.toExponential() + "°" + "</td>";
						table_row += "<td>" +  field.XY_Contrast.value.toFixed(1) + "</td>";
					} else {
						table_row += "<td></td>";
						table_row += "<td></td>";
						table_row += "<td></td>";
						table_row += "<td></td>";
						table_row += "<td></td>";
						table_row += "<td></td>";
					}

					table_row += "<td>" +  field.Chi2_Internal.value.toFixed(2) + "</td>";
					table_row += "<td>" +  field.Chi2_Internal_HighSN.value.toFixed(2) + "</td>";
					table_row += "<td>" +  field.Chi2_Reference.value.toFixed(2) + "</td>";
					table_row += "<td>" +  field.Chi2_Reference_HighSN.value.toFixed(2) + "</td>";
					table_row += "<td>" +  field.ZeroPoint_Corr.value.toFixed(3) + "</td>";
					table_row += "</tr>";
					$(table_row).appendTo("#fieldsTable tbody");
				});

                setAladinPos();

				function generateImageColHelper(imageUrl) {
					value = "";
					value += "<td><a type='button' rel='popover' data-img='"+imageUrl+"'>";
					value += "<img width='100' src='"+imageUrl+"' />";
					value += "</a></td>";
					return value;
				}
				/* 
				 * build fields groups table 
				 */
				$.each(scamp_data.Fgroups, function(i, group) {
					var table_row = "";
					table_row += "<tr>";
					table_row += "<td>" +  group.Name.value + "</td>";
					if (showplot) {
						table_row += "<td>" + group.FgroupsPlot.value + "</td>";
					} else {
						table_row += "<td></td>";
					}
					table_row += "<td>" +  group.Index.value + "</td>";
					table_row += "<td>" +  group.NFields.value + "</td>";
					table_row += "<td>" +  getRaValHelper(group.Field_Coordinates.value) + "</td>";
					table_row += "<td>" +  getDecValHelper(group.Field_Coordinates.value) + "</td>";
					table_row += "<td>" +  getElemAverageValHelper(group.Pixel_Scale.value).toFixed(4) + "''" + "</td>";
					table_row += "<td>" +  group.Max_Radius.value.toFixed(3) + "'" + "</td>";
					table_row += "<td>" +  group.AstRef_Catalog.value + "</td>";
					table_row += "<td>" +  group.AstRef_Band.value + "</td>";
					if (showplot) {
						table_row += generateImageColHelper(group.Chi2Plot.value);
					} else {
						table_row += "<td></td>";
					}
					table_row += "<td>" +  getElemListValHelperFixedHelper(group.AstromSigma_Internal.value, "'' ", 4) + "</td>";
					table_row += "<td>" +  group.AstromCorr_Internal.value.toFixed(5) + "</td>";
					table_row += "<td>" +  group.AstromChi2_Internal.value.toFixed(1) + "</td>";
					table_row += "<td>" +  group.AstromNDets_Internal.value + "</td>";
					table_row += "<td>" +  getElemListValHelperFixedHelper(group.AstromSigma_Internal_HighSN.value, "'' ", 4) + "</td>";
					table_row += "<td>" +  group.AstromCorr_Internal_HighSN.value.toFixed(5)  + "</td>";
					table_row += "<td>" +  group.AstromChi2_Internal_HighSN.value.toFixed(1) + "</td>";
					table_row += "<td>" +  group.AstromNDets_Internal_HighSN.value + "</td>";
					if (showplot) {
						table_row += generateImageColHelper(group.IntErr1DimPlot.value);
						table_row += generateImageColHelper(group.IntErr2DimPlot.value);
					} else {
						table_row += "<td></td>";
						table_row += "<td></td>";
					}
					table_row += "<td>" +  getElemListValHelperFixedHelper(group.AstromOffset_Reference.value, "'' ", 4) + "</td>";
					table_row += "<td>" +  getElemListValHelperFixedHelper(group.AstromSigma_Reference.value, "'' ", 3) + "</td>";
					table_row += "<td>" +  group.AstromCorr_Reference.value.toFixed(4) + "</td>";
					table_row += "<td>" +  group.AstromChi2_Reference.value.toFixed(1) + "</td>";
					table_row += "<td>" +  group.AstromNDets_Reference.value + "</td>";
					table_row += "<td>" +  getElemListValHelperFixedHelper(group.AstromOffset_Reference_HighSN.value, "'' ", 4) + "</td>";
					table_row += "<td>" +  getElemListValHelperFixedHelper(group.AstromSigma_Reference_HighSN.value, "'' ", 3) + "</td>";
					table_row += "<td>" +  group.AstromCorr_Reference_HighSN.value.toFixed(4) + "</td>";
					table_row += "<td>" +  group.AstromChi2_Reference_HighSN.value.toFixed(1) + "</td>";
					table_row += "<td>" +  group.AstromNDets_Reference_HighSN.value + "</td>";
					if (showplot) {
						table_row += generateImageColHelper(group.RefErr1DimPlot.value);
						table_row += generateImageColHelper(group.RefErr2DimPlot.value);
					} else {
						table_row += "<td></td>";
						table_row += "<td></td>";
					}
					table_row += "<td>" +  getElemListValHelper(group.PhotInstru_Name.value,", ") + "</td>";
					table_row += "<td>" +  getElemListValHelperFixedHelper(group.PhotSigma_Internal.value, " ", 6) + "</td>";
					table_row += "<td>" +  getElemListValHelperFixedHelper(group.PhotChi2_Internal.value, " ", 4) + "</td>";
					table_row += "<td>" +  getElemListValHelper(group.PhotNDets_Internal.value, " ") + "</td>";
					table_row += "<td>" +  getElemListValHelperFixedHelper(group.PhotSigma_Internal_HighSN.value, " ", 6) + "</td>";
					table_row += "<td>" +  getElemListValHelperFixedHelper(group.PhotChi2_Internal_HighSN.value, " ", 2) + "</td>";
					table_row += "<td>" +  getElemListValHelper(group.PhotNDets_Internal_HighSN.value, " ") + "</td>";
					table_row += "<td>" +  getElemListValHelperFixedHelper(group.PhotSigma_Reference.value, " ", 6) + "</td>";
					table_row += "<td>" +  getElemListValHelperFixedHelper(group.PhotChi2_Reference.value, " ", 6) + "</td>";
					table_row += "<td>" +  getElemListValHelper(group.PhotNDets_Reference.value, " ") + "</td>";
					table_row += "<td>" +  getElemListValHelperFixedHelper(group.PhotSigma_Reference_HighSN.value, " ", 6) + "</td>";
					table_row += "<td>" +  getElemListValHelperFixedHelper(group.PhotChi2_Reference_HighSN.value, " ", 6) + "</td>";
					table_row += "<td>" +  getElemListValHelper(group.PhotNDets_Reference_HighSN.value, " ") + "</td>";
					if (showplot) {
						table_row += generateImageColHelper(group.PhotErrPlot.value);
					} else {
						table_row += "<td></td>";
					}

					table_row += "</tr>";
					$(table_row).appendTo("#groupsTable tbody");
				});


				/* 
				 * build astrometric instruments table 
				 */
				$.each(scamp_data.AstroInstruments, function(i, astroinstru) {
					var table_row = "";
					table_row += "<tr>";
					table_row += "<td>" +  astroinstru.Name.value + "</td>";
					table_row += "<td>" +  astroinstru.Index.value + "</td>";
					table_row += "<td>" +  astroinstru.NFields.value + "</td>";
					table_row += "<td>" +  astroinstru.NKeys.value + "</td>";
					table_row += "<td>" +  getElemListValHelper(astroinstru.Keys.value, " ") + "</td>";
					if (showplot) {
						table_row += generateImageColHelper(astroinstru.DistPlot.value);
					} else {
						table_row += "<td></td>";
					}
					table_row += "</tr>";
					$(table_row).appendTo("#astrometricInstrumentsTable tbody");
				});


				/* 
				 * build photometric instruments table 
				 */
				$.each(scamp_data.PhotInstruments, function(i, photoinstru) {
					var table_row = "";
					table_row += "<tr>";
					table_row += "<td>" +  photoinstru.Name.value + "</td>";
					table_row += "<td>" +  photoinstru.Index.value + "</td>";
					table_row += "<td>" +  photoinstru.Index.value + "</td>";
					table_row += "<td>" +  photoinstru.MagZeroPoint_Output.value + "</td>";
					table_row += "<td>" +  photoinstru.NKeys.value + "</td>";
					table_row += "<td>" +  getElemListValHelper(photoinstru.Keys.value, " ") + "</td>";
					table_row += "</tr>";
					$(table_row).appendTo("#photometricInstrumentsTable tbody");
				});


				/* 
				 * build configuration table 
				 */
				$.each(scamp_data.Configuration, function(i, config) {
					var table_row = "";
					table_row += "<tr>";
					table_row += "<td>" +  config.name + "</td>";

					var value = "";
					if (config.datatype.includes("array")) {
						for (var i = 0; i < config.value.length; i++) {
							value += config.value[i] + ", ";
						}
					} else {
						value = config.value;
					}
					table_row += "<td>" +  value + "</td>";
					table_row += "</tr>";
					$(table_row).appendTo("#configTable tbody");
				});


				/* 
				 * build warnings table 
				 */
				$.each(scamp_data.Warnings, function(i, warn) {
					var table_row = "";
					table_row += "<tr>";
					table_row += "<td>" +  warn.Date.value + "</td>";
					table_row += "<td>" +  warn.Time.value + "</td>";
					table_row += "<td>" +  warn.Text.value + "</td>";
					$(table_row).appendTo("#warningsTable tbody");
				});

				/*
				 * Hide unused columns
				 */
				if (!showmatch) {
					$('#fieldsTable th:nth-child(17)').hide();
					$('#fieldsTable td:nth-child(17)').hide();
					$('#fieldsTable th:nth-child(18)').hide();
					$('#fieldsTable td:nth-child(18)').hide();
					$('#fieldsTable th:nth-child(19)').hide();
					$('#fieldsTable td:nth-child(19)').hide();
					$('#fieldsTable th:nth-child(20)').hide();
					$('#fieldsTable td:nth-child(20)').hide();
					$('#fieldsTable th:nth-child(21)').hide();
					$('#fieldsTable td:nth-child(21)').hide();
					$('#fieldsTable th:nth-child(22)').hide();
					$('#fieldsTable td:nth-child(22)').hide();
				}
				if (!showplot) {
					$('#groupsTable th:nth-child(2)').hide();
					$('#groupsTable td:nth-child(2)').hide();
					$('#groupsTable th:nth-child(11)').hide();
					$('#groupsTable td:nth-child(11)').hide();
					$('#groupsTable th:nth-child(20)').hide();
					$('#groupsTable td:nth-child(20)').hide();
					$('#groupsTable th:nth-child(21)').hide();
					$('#groupsTable td:nth-child(21)').hide();
					$('#groupsTable th:nth-child(32)').hide();
					$('#groupsTable td:nth-child(32)').hide();
					$('#groupsTable th:nth-child(33)').hide();
					$('#groupsTable td:nth-child(33)').hide();
					$('#groupsTable th:nth-child(47)').hide();
					$('#groupsTable td:nth-child(47)').hide();
                    $('#astrometricInstrumentsTable th:nth-child(6)').hide();   
                    $('#astrometricInstrumentsTable td:nth-child(6)').hide();  
				}
				
				if (scamp_data.Warnings.length == 0) {
					$("#warningDiv").hide();
				}	
				$('a[rel=popover]').popover({
					animation: true, container: "body", html: true, placement: 'bottom', content: function() {return "<img src='"+$(this).data('img') + "' />";}
				});
				
			});
		</script>
		<!-- SCRIPTS END -->





	</body>
</html>
