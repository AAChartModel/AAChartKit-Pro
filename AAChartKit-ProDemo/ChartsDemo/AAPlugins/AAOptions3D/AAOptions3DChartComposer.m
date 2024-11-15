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
