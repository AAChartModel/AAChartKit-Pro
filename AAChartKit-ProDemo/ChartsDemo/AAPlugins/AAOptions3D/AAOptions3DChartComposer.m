//
//  AAOptions3DChartComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/15.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AAOptions3DChartComposer.h"
#import "AAChartKit-Pro.h"
#import "AAChart+Options3D.h"

static NSString * const AAChartTypeScatter3d = @"scatter3d";

@implementation AAOptions3DChartComposer

/**
 $(function() {
     const rand = function (from, to) {
         return Math.round(from + Math.random() * (to - from));
     };
     const chart = Highcharts.chart('container', {
         chart: {
             type: 'column',
             options3d: {
                 enabled: true,
                 alpha: 20,
                 beta: 30,
                 depth: 400, // Set deph
                 viewDistance: 5,
                 frame: {
                     bottom: {
                         size: 1,
                         color: 'rgba(0,0,0,0.05)'
                     }
                 }
             }
         },
         title: {
             text: ''
         },
         subtitle: {
             text: ''
         },
         yAxis: {
             min: 0,
             max: 10
         },
         xAxis: {
             min: 0, // Set min on xAxis
             max: 3,
             gridLineWidth: 1
         },
         zAxis: {
             min: 0,
             max: 3,
             categories: ['A01', 'A02', 'A03', 'A04', 'A05', 'A06', 'A07', 'A08', 'A09', 'A10', 'A11', 'A12'],
             labels: {
                 y: 5,
                 rotation: 18
             }
         },
         plotOptions: {
             series: {
                 groupZPadding: 10,
                 depth: 100,
                 groupPadding: 0,
                 grouping: false,
             }
         },
         series: [{
             stack: 0,
             data: [...Array(4)].map((v, i) => ({ x: i, y: rand(0, 10) }))
         }, {
             stack: 1,
             data: [...Array(4)].map((v, i) => ({ x: i, y: rand(0, 10) }))
         }, {
             stack: 2,
             data: [...Array(4)].map((v, i) => ({ x: i, y: rand(0, 10) }))
         },{
             stack: 3,
             data: [...Array(4)].map((v, i) => ({ x: i, y: rand(0, 10) }))
         }]
     });
     // Add mouse events for rotation
     $(chart.container).on('mousedown.hc touchstart.hc', function(eStart) {
         eStart = chart.pointer.normalize(eStart);
         var posX = eStart.pageX,
             posY = eStart.pageY,
             alpha = chart.options.chart.options3d.alpha,
             beta = chart.options.chart.options3d.beta,
             newAlpha,
             newBeta,
             sensitivity = 1; // lower is more sensitive
         $(document).on({
             'mousemove.hc touchdrag.hc': function(e) {
                 // Run beta
                 newBeta = beta + (posX - e.pageX) / sensitivity;
                 chart.options.chart.options3d.beta = newBeta;
                 // Run alpha
                 newAlpha = alpha + (e.pageY - posY) / sensitivity;
                 chart.options.chart.options3d.alpha = newAlpha;
                 chart.redraw(false);
             },
             'mouseup touchend': function() {
                 $(document).off('.hc');
             }
         });
     });
 });
 */
+ (AAOptions *)_3DColumnWithStackingRandomData {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeColumn)
              .options3dSet(AAOptions3D.new
                            .enabledSet(true)
                            .alphaSet(@20)
                            .betaSet(@30)
                            .depthSet(@400)
                            .viewDistanceSet(@5)
                            .frameSet(AAFrame.new
                                      .bottomSet(@{@"size": @1, @"color": @"rgba(0,0,0,0.05)"})
                                      )
                            )
              )
    .titleSet(AATitle.new
              .textSet(@"")
              )
    .subtitleSet(AASubtitle.new
                 .textSet(@"")
                 )
    .yAxisSet(AAYAxis.new
              .minSet(@0)
              .maxSet(@10)
              )
    .xAxisSet(AAXAxis.new
              .minSet(@0)
              .maxSet(@3)
              .gridLineWidthSet(@1)
              )
//    .zAxisSet(AAZAxis.new
//              .minSet(@0)
//              .maxSet(@3)
//              .categoriesSet(@[@"A01", @"A02", @"A03", @"A04", @"A05", @"A06", @"A07", @"A08", @"A09", @"A10", @"A11", @"A12"])
//              .labelsSet(AALabels.new
//                         .ySet(@5)
//                         .rotationSet(@18)
//                         )
//              )
    .plotOptionsSet(AAPlotOptions.new
                    .seriesSet(AASeries.new
//                               .groupZPaddingSet(@10)
//                               .depthSet(@100)
                               .groupPaddingSet(@0)
//                               .groupingSet(false)
                               )
                    )
    .seriesSet(@[
        AASeriesElement.new
        .stackSet(@0)
        .dataSet(@[
            @{@"x": @0, @"y": @(arc4random_uniform(11))},
            @{@"x": @1, @"y": @(arc4random_uniform(11))},
            @{@"x": @2, @"y": @(arc4random_uniform(11))},
            @{@"x": @3, @"y": @(arc4random_uniform(11))}
        ]),
        AASeriesElement.new
        .stackSet(@1)
        .dataSet(@[
            @{@"x": @0, @"y": @(arc4random_uniform(11))},
            @{@"x": @1, @"y": @(arc4random_uniform(11))},
            @{@"x": @2, @"y": @(arc4random_uniform(11))},
            @{@"x": @3, @"y": @(arc4random_uniform(11))}
        ]),
        AASeriesElement.new
        .stackSet(@2)
        .dataSet(@[
            @{@"x": @0, @"y": @(arc4random_uniform(11))},
            @{@"x": @1, @"y": @(arc4random_uniform(11))},
            @{@"x": @2, @"y": @(arc4random_uniform(11))},
            @{@"x": @3, @"y": @(arc4random_uniform(11))}
        ]),
        AASeriesElement.new
        .stackSet(@3)
        .dataSet(@[
            @{@"x": @0, @"y": @(arc4random_uniform(11))},
            @{@"x": @1, @"y": @(arc4random_uniform(11))},
            @{@"x": @2, @"y": @(arc4random_uniform(11))},
            @{@"x": @3, @"y": @(arc4random_uniform(11))}
        ])
    ]);
}
/**
 // Data retrieved from https://yearbook.enerdata.net/electricity/world-electricity-production-statistics.html
 Highcharts.chart('container', {
     chart: {
         type: 'column',
         options3d: {
             enabled: true,
             alpha: 15,
             beta: 15,
             viewDistance: 25,
             depth: 40
         }
     },

     title: {
         text: ' Electricity production in countries, grouped by continent',
         align: 'left'
     },

     xAxis: {
         labels: {
             skew3d: true,
             style: {
                 fontSize: '16px'
             }
         }
     },

     yAxis: {
         allowDecimals: false,
         min: 0,
         title: {
             text: 'TWh',
             skew3d: true,
             style: {
                 fontSize: '16px'
             }
         }
     },

     tooltip: {
         headerFormat: '<b>{point.key}</b><br>',
         pointFormat: '<span style="color:{series.color}">\u25CF</span> ' +
             '{series.name}: {point.y} / {point.stackTotal}'
     },

     plotOptions: {
         series: {
             pointStart: 2018
         },
         column: {
             stacking: 'normal',
             depth: 40
         }
     },

     series: [{
         name: 'South Korea',
         data: [590, 582, 571, 606, 625],
         stack: 'Asia'
     }, {
         name: 'Germany',
         data: [643, 612, 572, 588, 578],
         stack: 'Europe'
     }, {
         name: 'Saudi Arabia',
         data: [378, 367, 363, 408, 433],
         stack: 'Asia'
     }, {
         name: 'France',
         data: [582, 571, 533, 555, 473],
         stack: 'Europe'
     }]
 });

 */
//3D column with stacking and grouping
+ (AAOptions *)_3DColumnWithStackingAndGrouping {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeColumn)
              .options3dSet(AAOptions3D.new
                            .enabledSet(true)
                            .alphaSet(@15)
                            .betaSet(@15)
                            .viewDistanceSet(@25)
                            .depthSet(@40)
                            )
              )
    .titleSet(AATitle.new
              .textSet(@"Electricity production in countries, grouped by continent")
              .alignSet(@"left")
              )
    .xAxisSet(AAXAxis.new
              .labelsSet(AALabels.new
//                         .skew3dSet(true)
                         .styleSet(AAStyle.new
                                   .fontSizeSet(@"16px")
                                   )
                         )
              )
    .yAxisSet(AAYAxis.new
              .allowDecimalsSet(false)
              .minSet(@0)
              .titleSet(AATitle.new
                        .textSet(@"TWh")
//                        .skew3dSet(true)
                        .styleSet(AAStyle.new
                                  .fontSizeSet(@"16px")
                                  )
                        )
              )
    .tooltipSet(AATooltip.new
                .headerFormatSet(@"<b>{point.key}</b><br>")
//                .pointFormatSet(@"<span style=\"color:{series.color}\">\u25CF</span> {series.name}: {point.y} / {point.stackTotal}")
                )
    .plotOptionsSet(AAPlotOptions.new
                    .seriesSet(AASeries.new
//                               .pointStartSet(@2018)
                               )
                    .columnSet(AAColumn.new
                               .stackingSet(AAChartStackingTypeNormal)
//                               .depthSet(@40)
                               )
                    )
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"South Korea")
        .dataSet(@[@590, @582, @571, @606, @625])
        .stackSet(@"Asia"),
        AASeriesElement.new
        .nameSet(@"Germany")
        .dataSet(@[@643, @612, @572, @588, @578])
        .stackSet(@"Europe"),
        AASeriesElement.new
        .nameSet(@"Saudi Arabia")
        .dataSet(@[@378, @367, @363, @408, @433])
        .stackSet(@"Asia"),
        AASeriesElement.new
        .nameSet(@"France")
        .dataSet(@[@582, @571, @533, @555, @473])
        .stackSet(@"Europe"),
    ]);
}

/**
 Highcharts.chart('container', {
     chart: {
         type: 'area',
         options3d: {
             enabled: true,
             alpha: 15,
             beta: 30,
             depth: 200
         }
     },
     title: {
         text: 'Visual comparison of Mountains Panorama',
         align: 'left'
     },
     accessibility: {
         description: 'The chart is showing the shapes of three mountain ' +
             'ranges as three area line series laid out in 3D behind each ' +
             'other.',
         keyboardNavigation: {
             seriesNavigation: {
                 mode: 'serialize'
             }
         }
     },
     lang: {
         accessibility: {
             axis: {
                 xAxisDescriptionPlural: 'The chart has 3 unlabelled X axes, ' +
                     'one for each series.'
             }
         }
     },
     yAxis: {
         title: {
             text: 'Height Above Sea Level',
             x: -40
         },
         labels: {
             format: '{value:,.0f} MAMSL'
         },
         gridLineDashStyle: 'Dash'
     },
     xAxis: [{
         visible: false
     }, {
         visible: false
     }, {
         visible: false
     }],
     plotOptions: {
         area: {
             depth: 100,
             marker: {
                 enabled: false
             },
             states: {
                 inactive: {
                     enabled: false
                 }
             }
         }
     },
     tooltip: {
         valueSuffix: ' MAMSL'
     },
     series: [{
         name: 'Tatra Mountains visible from Rusinowa polana',
         lineColor: 'rgb(180,90,50)',
         color: 'rgb(200,110,50)',
         fillColor: 'rgb(200,110,50)',
         data: [
             ['Murań', 1890],
             ['Nowy Wierch', 2009],
             ['Hawrań', 2152],
             ['Płaczliwa Skała', 2142],
             ['Szalony Wierch', 2061],
             ['Karczmarski Wierch', 1438],
             ['Jagnięcy Szczyt', 2230],
             ['Czerwona Turnia', 2284],
             ['Kołowy Szczyt', 2418],
             ['Czarny Szczyt', 2429],
             ['Baranie Rogi', 2526],
             ['Śnieżny Szczyt', 2465],
             ['Lodowy Szczyt', 2627],
             ['Lodowa Kopa', 2602],
             ['Szeroka Jaworzyńska', 2210],
             ['Horwacki Wierch', 1902],
             ['Spismichałowa Czuba', 2012],
             ['Zielona Czuba', 2130],
             ['Wielicki Szczyt', 2318],
             ['Gerlach', 2655],
             ['Batyżowiecki Szczyt', 2448],
             ['Kaczy Szczyt', 2395],
             ['Zmarzły Szczyt', 2390],
             ['Kończysta', 2538],
             ['Młynarz', 2170],
             ['Ganek', 2462],
             ['Wysoka', 2547],
             ['Ciężki Szczyt', 2520],
             ['Rysy', 2503],
             ['Żabi Mnich', 2146],
             ['Żabi Koń', 2291],
             ['Żabia Turnia Mięguszowiecka', 2335],
             ['Wołowa Turnia', 2373]
         ]
     }, {
         xAxis: 1,
         lineColor: 'rgb(120,160,180)',
         color: 'rgb(140,180,200)',
         fillColor: 'rgb(140,180,200)',
         name: 'Dachstein panorama seen from Krippenstein',
         data: [
             ['Kufstein', 2049],
             ['Hohe Wildstelle', 2746],
             ['Kleiner Miesberg', 2173],
             ['Großer Miesberg', 2202],
             ['Hochstein', 2543],
             ['Lackner Miesberg', 2232],
             ['Wasenspitze', 2257],
             ['Sinabell', 2349],
             ['Feister Scharte', 2198],
             ['Eselstein', 2556],
             ['Landfriedstein', 2536],
             ['Scheichenspitz', 2667],
             ['Schmiedstock', 2634],
             ['Gamsfeldspitze', 2611],
             ['Edelgriess', 2305],
             ['Koppenkarstein', 2863],
             ['Niederer Gjaidstein', 2483],
             ['Hoher Gjaidstein', 2794],
             ['Hoher Dachstein', 2995],
             ['Niederer Dachstein', 2934],
             ['Hohes Kreuz', 2837],
             ['Hoher Ochsenkogel', 2513]
         ]
     }, {
         xAxis: 2,
         lineColor: 'rgb(200, 190, 140)',
         color: 'rgb(200, 190, 140)',
         fillColor: 'rgb(230, 220, 180)',
         name: 'Panorama from Col Des Mines',
         data: [
             ['Combin de la Tsessette', 4141],
             ['Grand Combin de Grafeneire', 4314],
             ['Combin de Corbassière', 3716],
             ['Petit Combin', 3672],
             ['Pointe de Boveire', 3212],
             ['Grand Aget', 3133],
             ['Mont Rogneux', 3084],
             ['Dents du Grand Lé', 2884],
             ['Monts Telliers', 2951],
             ['Grand Golliat', 3238],
             ['Mont Grande Rochère', 3326],
             ['Mont de la Fouly', 2871],
             ['Tête de la Payanne', 2452],
             ['Pointe Allobrogia', 3172],
             ['Six Blanc', 2334],
             ['Mont Dolent', 3820],
             ['Aiguille de Triolet', 3870],
             ['Le Tour Noir', 3836],
             ['Aiguille de l\'A Neuve', 3753],
             ['Aiguille d\'Argentière', 3900],
             ['Aiguille du Chardonnet', 3824],
             ['Aiguille du Tour', 3540],
             ['Aiguille du Pissoir', 3440],
             ['Le Catogne', 2598],
             ['Pointe de Prosom', 2762],
             ['Pointe Ronde', 2700],
             ['Mont Buet', 3096],
             ['Le Cheval Blanc', 2831],
             ['Pointe de la Finive', 2838],
             ['Pic de Tenneverge', 2985],
             ['Pointe d\'Aboillon', 2819],
             ['Tour Sallière', 3220],
             ['Le Dôme', 3138],
             ['Haute Cime', 3257],
             ['Pierre Avoi', 2473],
             ['Cime de l\'Est', 3178]
         ]
     }]
 });

 */
+ (AAOptions *)_3DAreaChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeArea)
              .options3dSet(AAOptions3D.new
                            .enabledSet(true)
                            .alphaSet(@15)
                            .betaSet(@30)
                            .depthSet(@200)
                            )
              )
    .titleSet(AATitle.new
              .textSet(@"Visual comparison of Mountains Panorama")
              .alignSet(@"left")
              )
//    .accessibilitySet(AAAccessibility.new
//                      .descriptionSet(@"The chart is showing the shapes of three mountain ranges as three area line series laid out in 3D behind each other.")
//                      .keyboardNavigationSet(AAKeyboardNavigation.new
//                                             .seriesNavigationSet(AASeriesNavigation.new
//                                                                  .modeSet(@"serialize")
//                                                                  )
//                                             )
//                      )
//    .langSet(AALang.new
//             .accessibilitySet(AAAccessibilityLang.new
//                               .axisSet(AAAxis.new
//                                        .xAxisDescriptionPluralSet(@"The chart has 3 unlabelled X axes, one for each series.")
//                                        )
//                               )
//             )
    .yAxisSet(AAYAxis.new
              .titleSet(AATitle.new
                        .textSet(@"Height Above Sea Level")
                        .xSet(@-40)
                        )
              .labelsSet(AALabels.new
//                         .formatSet(@"{value:,.0f} MAMSL")
                         )
              .gridLineDashStyleSet(AAChartLineDashStyleTypeDash)
              )
    .xAxisSet(@[
        AAXAxis.new
            .visibleSet(false),
        AAXAxis.new
            .visibleSet(false),
        AAXAxis.new
            .visibleSet(false)
    ])
    .plotOptionsSet(AAPlotOptions.new
                    .areaSet(AAArea.new
//                             .depthSet(@100)
//                             .markerSet(AAMarker.new
//                                        .enabledSet(false)
//                                        )
//                             .statesSet(AAStates.new
//                                        .inactiveSet(AAInactive.new
//                                                     .enabledSet(false)
//                                                     )
//                                        )
                             )
                    )
    .tooltipSet(AATooltip.new
                .valueSuffixSet(@" MAMSL")
                )
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"Tatra Mountains visible from Rusinowa polana")
//        .lineColorSet(@"rgb(180,90,50)")
        .colorSet(@"rgb(200,110,50)")
        .fillColorSet(@"rgb(200,110,50)")
        .dataSet(@[
            @[@"Murań", @1890], @[@"Nowy Wierch", @2009], @[@"Hawrań", @2152], @[@"Płaczliwa Skała", @2142], @[@"Szalony Wierch", @2061],
            @[@"Karczmarski Wierch", @1438], @[@"Jagnięcy Szczyt", @2230], @[@"Czerwona Turnia", @2284], @[@"Kołowy Szczyt", @2418],
            @[@"Czarny Szczyt", @2429], @[@"Baranie Rogi", @2526], @[@"Śnieżny Szczyt", @2465], @[@"Lodowy Szczyt", @2627],
            @[@"Lodowa Kopa", @2602], @[@"Szeroka Jaworzyńska", @2210], @[@"Horwacki Wierch", @1902], @[@"Spismichałowa Czuba", @2012],
            @[@"Zielona Czuba", @2130], @[@"Wielicki Szczyt", @2318], @[@"Gerlach", @2655], @[@"Batyżowiecki Szczyt", @2448],
            @[@"Kaczy Szczyt", @2395], @[@"Zmarzły Szczyt", @2390], @[@"Kończysta", @2538], @[@"Młynarz", @2170], @[@"Ganek", @2462],
            @[@"Wysoka", @2547], @[@"Ciężki Szczyt", @2520], @[@"Rysy", @2503], @[@"Żabi Mnich", @2146], @[@"Żabi Koń", @2291],
            @[@"Żabia Turnia Mięguszowiecka", @2335], @[@"Wołowa Turnia", @2373]
        ]),
        AASeriesElement.new
        .xAxisSet(@1)
//        .lineColorSet(@"rgb(120,160,180)")
        .colorSet(@"rgb(140,180,200)")
        .fillColorSet(@"rgb(140,180,200)")
        .nameSet(@"Dachstein panorama seen from Krippenstein")
        .dataSet(@[
            @[@"Kufstein", @2049], @[@"Hohe Wildstelle", @2746], @[@"Kleiner Miesberg", @2173], @[@"Großer Miesberg", @2202],
            @[@"Hochstein", @2543], @[@"Lackner Miesberg", @2232], @[@"Wasenspitze", @2257], @[@"Sinabell", @2349],
            @[@"Feister Scharte", @2198], @[@"Eselstein", @2556], @[@"Landfriedstein", @2536], @[@"Scheichenspitz", @2667],
            @[@"Schmiedstock", @2634], @[@"Gamsfeldspitze", @2611], @[@"Edelgriess", @2305], @[@"Koppenkarstein", @2863],
            @[@"Niederer Gjaidstein", @2483], @[@"Hoher Gjaidstein", @2794], @[@"Hoher Dachstein", @2995], @[@"Niederer Dachstein", @2934],
            @[@"Hohes Kreuz", @2837], @[@"Hoher Ochsenkogel", @2513]
        ]),
        AASeriesElement.new
        .xAxisSet(@2)
//        .lineColorSet(@"rgb(200, 190, 140)")
        .colorSet(@"rgb(200, 190, 140)")
        .fillColorSet(@"rgb(230, 220, 180)")
        .nameSet(@"Panorama from Col Des Mines")
        .dataSet(@[
            @[@"Combin de la Tsessette", @4141], @[@"Grand Combin de Grafeneire", @4314], @[@"Combin de Corbassière", @3716],
            @[@"Petit Combin", @3672], @[@"Pointe de Boveire", @3212], @[@"Grand Aget", @3133], @[@"Mont Rogneux", @3084],
            @[@"Dents du Grand Lé", @2884], @[@"Monts Telliers", @2951], @[@"Grand Golliat", @3238], @[@"Mont Grande Rochère", @3326],
            @[@"Mont de la Fouly", @2871], @[@"Tête de la Payanne", @2452], @[@"Pointe Allobrogia", @3172], @[@"Six Blanc", @2334],
            @[@"Mont Dolent", @3820], @[@"Aiguille de Triolet", @3870], @[@"Le Tour Noir", @3836], @[@"Aiguille de l'A Neuve", @3753],
            @[@"Aiguille d'Argentière", @3900], @[@"Aiguille du Chardonnet", @3824], @[@"Aiguille du Tour", @3540],
            @[@"Aiguille du Pissoir", @3440], @[@"Le Catogne", @2598], @[@"Pointe de Prosom", @2762], @[@"Pointe Ronde", @2700],
            @[@"Mont Buet", @3096], @[@"Le Cheval Blanc", @2831], @[@"Pointe de la Finive", @2838], @[@"Pic de Tenneverge", @2985],
            @[@"Pointe d'Aboillon", @2819], @[@"Tour Sallière", @3220], @[@"Le Dôme", @3138], @[@"Haute Cime", @3257],
            @[@"Pierre Avoi", @2473], @[@"Cime de l'Est", @3178]
        ])
    ]);
}

/**
 // Set up the chart
 const chart = new Highcharts.Chart({
     chart: {
         renderTo: 'container',
         margin: 100,
         type: 'scatter3d',
         animation: false,
         options3d: {
             enabled: true,
             alpha: 10,
             beta: 30,
             depth: 250,
             viewDistance: 5,
             fitToPlot: false,
             frame: {
                 bottom: { size: 1, color: 'rgba(0,0,0,0.02)' },
                 back: { size: 1, color: 'rgba(0,0,0,0.04)' },
                 side: { size: 1, color: 'rgba(0,0,0,0.06)' }
             }
         }
     },
     title: {
         text: 'Draggable box'
     },
     subtitle: {
         text: 'Click and drag the plot area to rotate in space'
     },
     plotOptions: {
         scatter: {
             width: 10,
             height: 10,
             depth: 10
         }
     },
     yAxis: {
         min: 0,
         max: 10,
         title: null
     },
     xAxis: {
         min: 0,
         max: 10,
         gridLineWidth: 1
     },
     zAxis: {
         min: 0,
         max: 10,
         showFirstLabel: false
     },
     legend: {
         enabled: false
     },
     series: [{
         name: 'Data',
         colorByPoint: true,
         accessibility: {
             exposeAsGroupOnly: true
         },
         data: [
             [1, 6, 5], [8, 7, 9], [1, 3, 4], [4, 6, 8], [5, 7, 7], [6, 9, 6],
             [7, 0, 5], [2, 3, 3], [3, 9, 8], [3, 6, 5], [4, 9, 4], [2, 3, 3],
             [6, 9, 9], [0, 7, 0], [7, 7, 9], [7, 2, 9], [0, 6, 2], [4, 6, 7],
             [3, 7, 7], [0, 1, 7], [2, 8, 6], [2, 3, 7], [6, 4, 8], [3, 5, 9],
             [7, 9, 5], [3, 1, 7], [4, 4, 2], [3, 6, 2], [3, 1, 6], [6, 8, 5],
             [6, 6, 7], [4, 1, 1], [7, 2, 7], [7, 7, 0], [8, 8, 9], [9, 4, 1],
             [8, 3, 4], [9, 8, 9], [3, 5, 3], [0, 2, 4], [6, 0, 2], [2, 1, 3],
             [5, 8, 9], [2, 1, 1], [9, 7, 6], [3, 0, 2], [9, 9, 0], [3, 4, 8],
             [2, 6, 1], [8, 9, 2], [7, 6, 5], [6, 3, 1], [9, 3, 1], [8, 9, 3],
             [9, 1, 0], [3, 8, 7], [8, 0, 0], [4, 9, 7], [8, 6, 2], [4, 3, 0],
             [2, 3, 5], [9, 1, 4], [1, 1, 4], [6, 0, 2], [6, 1, 6], [3, 8, 8],
             [8, 8, 7], [5, 5, 0], [3, 9, 6], [5, 4, 3], [6, 8, 3], [0, 1, 5],
             [6, 7, 3], [8, 3, 2], [3, 8, 3], [2, 1, 6], [4, 6, 7], [8, 9, 9],
             [5, 4, 2], [6, 1, 3], [6, 9, 5], [4, 8, 2], [9, 7, 4], [5, 4, 2],
             [9, 6, 1], [2, 7, 3], [4, 5, 4], [6, 8, 1], [3, 4, 0], [2, 2, 6],
             [5, 1, 2], [9, 9, 7], [6, 9, 9], [8, 4, 3], [4, 1, 7], [6, 2, 5],
             [0, 4, 9], [3, 5, 9], [6, 9, 1], [1, 9, 2]
         ]
     }]
 });
 */
+ (AAOptions *)_3DScatterChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeScatter3d)
              .marginSet((id)@100)
              .animationSet(false)
              .options3dSet(AAOptions3D.new
                            .enabledSet(true)
                            .alphaSet(@10)
                            .betaSet(@30)
                            .depthSet(@250)
                            .viewDistanceSet(@5)
                            .fitToPlotSet(false)
                            .frameSet(AAFrame.new
                                      .bottomSet(@{@"size": @1, @"color": @"rgba(0,0,0,0.02)"})
                                        .backSet(@{@"size": @1, @"color": @"rgba(0,0,0,0.04)"})
                                        .sideSet(@{@"size": @1, @"color": @"rgba(0,0,0,0.06)"})
                                      )
                            )
              )
    .titleSet(AATitle.new
              .textSet(@"Draggable box"))
    .subtitleSet(AASubtitle.new
                 .textSet(@"Click and drag the plot area to rotate in space"))
    .plotOptionsSet(AAPlotOptions.new
//                    .scatterSet(AAScatter.new
//                                .widthSet(@10)
//                                .heightSet(@10)
//                                .depthSet(@10)
//                                )
                    )
    .yAxisSet(AAYAxis.new
              .minSet(@0)
              .maxSet(@10)
              .titleSet((id)NSNull.null)
              )
    .xAxisSet(AAXAxis.new
                .minSet(@0)
                .maxSet(@10)
                .gridLineWidthSet(@1)
                )
//    .zAxisSet(AAZAxis.new
//                .minSet(@0)
//                .maxSet(@10)
//                .showFirstLabelSet(false)
//                )
    .legendSet(AALegend.new
                .enabledSet(false)
                )
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"Data")
        .colorByPointSet(@true)
//        .accessibilitySet(Accessibility.new
//                          .exposeAsGroupOnlySet(true)
//                          )
        .dataSet(@[
            @[@1, @6, @5], @[@8, @7, @9], @[@1, @3, @4], @[@4, @6, @8], @[@5, @7, @7], @[@6, @9, @6],
            @[@7, @0, @5], @[@2, @3, @3], @[@3, @9, @8], @[@3, @6, @5], @[@4, @9, @4], @[@2, @3, @3],
            @[@6, @9, @9], @[@0, @7, @0], @[@7, @7, @9], @[@7, @2, @9], @[@0, @6, @2], @[@4, @6, @7],
            @[@3, @7, @7], @[@0, @1, @7], @[@2, @8, @6], @[@2, @3, @7], @[@6, @4, @8], @[@3, @5, @9],
            @[@7, @9, @5], @[@3, @1, @7], @[@4, @4, @2], @[@3, @6, @2], @[@3, @1, @6], @[@6, @8, @5],
            @[@6, @6, @7], @[@4, @1, @1], @[@7, @2, @7], @[@7, @7, @0], @[@8, @8, @9], @[@9, @4, @1],
            @[@8, @3, @4], @[@9, @8, @9], @[@3, @5, @3], @[@0, @2, @4], @[@6, @0, @2], @[@2, @1, @3],
            @[@5, @8, @9], @[@2, @1, @1], @[@9, @7, @6], @[@3, @0, @2], @[@9, @9, @0], @[@3, @4, @8],
            @[@2, @6, @1], @[@8, @9, @2], @[@7, @6, @5], @[@6, @3, @1], @[@9, @3, @1], @[@8, @9, @3],
            @[@9, @1, @0], @[@3, @8, @7], @[@8, @0, @0], @[@4, @9, @7], @[@8, @6, @2], @[@4, @3, @0],
            @[@2, @3, @5], @[@9, @1, @4], @[@1, @1, @4], @[@6, @0, @2], @[@6, @1, @6], @[@3, @8, @8],
            @[@8, @8, @7], @[@5, @5, @0], @[@3, @9, @6], @[@5, @4, @3], @[@6, @8, @3], @[@0, @1, @5],
            @[@6, @7, @3], @[@8, @3, @2], @[@3, @8, @3], @[@2, @1, @6], @[@4, @6, @7], @[@8, @9, @9],
            @[@5, @4, @2], @[@6, @1, @3], @[@6, @9, @5], @[@4, @8, @2], @[@9, @7, @4], @[@5, @4, @2],
            @[@9, @6, @1], @[@2, @7, @3], @[@4, @5, @4], @[@6, @8, @1], @[@3, @4, @0], @[@2, @2, @6],
            @[@5, @1, @2], @[@9, @9, @7], @[@6, @9, @9], @[@8, @4, @3], @[@4, @1, @7], @[@6, @2, @5],
            @[@0, @4, @9], @[@3, @5, @9], @[@6, @9, @1], @[@1, @9, @2]
        ])
        ])
    ;
}



@end
