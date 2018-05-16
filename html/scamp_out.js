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

    var i = 0;
    $.each(scamp_data.Fields, function(i, field) {
            if (higlight == i) {
            var w = 10;
            var color = "#ffffff";
            } else {
            var w = 1;
            var color = "#000";
            }

            var overlay = A.graphicOverlay({color: getRandomColor(), lineWidth: w});
            aladin.addOverlay(overlay);

            for (var i=0; i<field.Set_Polygon.value.length; i++) {
            var poly = field.Set_Polygon.value[i];
            var drawline = poly;
            drawline.push(poly[0]);
            overlay.add(A.polyline(drawline));
            }
            })
}

function generateImageColHelper(imageUrl) {
    var value = "";
    /* value += "<td><a type='button' rel='popover' data-img='"+imageUrl+"'>"; */
    value += "<td><a type='button' data-toggle='modal' data-target='#imageModal' data-imgurl='" + imageUrl + "'>";
    value += "<img width='100' class='img-fluid' src='"+imageUrl+"' />";
    value += "</a></td>";
    return value;
}

$(document).ready(
        function() {
        /* first initialize aladin */
        aladin = A.aladin('#aladin-lite-div', {
            survey: "P/DSS2/color", 
            fov: 60,
            showReticle: false,
            showZoomControl: true,
            showFullScreenControl: true,
            showLayersControl: false,
            showGotoControl: false,
            showShareControl: false,
            fulscreen: false
        });

        aladinDraw(3);
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
        var showplot  = getElemVal("CHECKPLOT_DEV", scamp_data.Configuration)[0];
        showplot = (showplot == "PNG") ? true : false;

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
        /* 
         * build fields groups table 
         */
        $.each(scamp_data.Fgroups, function(i, group) {
                var table_row = "";
                table_row += "<tr>";
                table_row += "<td>" +  group.Name.value + "</td>";
                if (showplot) {
                    table_row += generateImageColHelper(group.FgroupsPlot.value);
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
