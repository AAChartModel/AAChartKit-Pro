//
//  AABubbleStellarChartComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2025/5/3.
//  Copyright © 2025 An An. All rights reserved.
//

#import "AABubbleStellarChartComposer.h"
#import "AAChartKit-Pro.h"
#import "AAOptionsCSV.h"
#import "NSString+toPureJSString.h"

@implementation AABubbleStellarChartComposer

+ (AAOptions *)bubbleStellarChart {
    // CSV Data (Replace with your actual CSV data string)
    // Note: AAChartKit might require data to be pre-parsed or structured differently than direct CSV input in Highcharts JS.
    // This example assumes you have a mechanism to provide the CSV string.
    // If direct CSV isn't supported as shown, you'll need to parse the CSV and build the series data array manually.
    NSString *csvStr = AAOptionsCSV.stellarChartData[@"csv"];
    NSString *csvDataStr = csvStr.aa_toPureCSVString;

    NSArray *colors = @[@"#6CDDCA", @"#C771F3", @"#4D90DB", @"#FAB776"];

    AAOptions *aaOptions = AAOptions.new
    
        .chartSet(AAChart.new
            .typeSet(AAChartTypeBubble)
            .polarSet(true)
//            .heightSet(@600)
//            .eventsSet(AAChartEvents.new
//                       .renderSet(@AAJSFunc((function() {
//                           const chart = this,
//                           pieSeries = chart.series[1];
//                           pieSeries.customLabel = fillCenter(
//                                                              100,
//                                                              '1990-2020',
//                                                              chart,
//                                                              pieSeries.customLabel
//                                                              );
//                       })
//                                            )))
                  ) // Add render event with fillCenter
        .dataSet(AAData.new
                 .csvSet(csvDataStr) // Provide CSV data string
            .seriesMappingSet(@[@{
                                  @"name": @0,
                                  @"x": @1,
                                  @"y": @2,
                                  @"z": @3,
                                  @"custom.lightYears": @4,
                                  @"custom.planetMass": @5,
                                  @"custom.stellarMagnitude": @6,
                                  @"custom.discoveryDate": @7
                                  }])
                 )
        .titleSet(AATitle.new
            .textSet(@"The 240 Closest Planets to the Earth other than our solar system"))
        .subtitleSet(AASubtitle.new
            .textSet(@"Using bubble series in polar coordinate system along with pie series"))
        .colorAxisSet(AAColorAxis.new
            .minSet(@0)
            .maxSet(@12)
            .stopsSet(@[
                @[@0, colors[0]],
                @[@(1.0/3.0), colors[1]],
                @[@(2.0/3.0), colors[2]],
                @[@1, colors[3]]
            ]))
        .legendSet(AALegend.new
            .enabledSet(false))
        .paneSet(AAPane.new
            .innerSizeSet(@"42%")
            .sizeSet(@"95%")
            .backgroundSet(@[
                AABackgroundElement.new
                    .backgroundColorSet(@"#f7f7f7")
                    .borderWidthSet(@0),
                AABackgroundElement.new
                    .backgroundColorSet(@"#fff")
                    .borderWidthSet(@0)
                    .outerRadiusSet(@"42%")
            ]))
        .xAxisSet(AAXAxis.new
            .tickIntervalSet(@1)
            .minSet(@0)
            .maxSet(@30)
            .gridLineWidthSet(@0)
            .labelsSet(AALabels.new.enabledSet(false))
            .lineWidthSet(@0))
        .yAxisSet(AAYAxis.new
            .tickIntervalSet(@1)
            .labelsSet(AALabels.new.enabledSet(false))
            .gridLineWidthSet(@0.5)
            .gridLineColorSet(@"#BBBAC5")
            .gridLineDashStyleSet(AAChartLineDashStyleTypeLongDash)
            .endOnTickSet(false))
        .tooltipSet(AATooltip.new
            .borderWidthSet(@1)
            .backgroundColorSet(@"#fff")
            .shadowSet(false)
//            .outsideSet(true)
            .hideDelaySet(@20)
            .useHTMLSet(true)
            .formatterSet(@AAJSFunc(function (tooltip) {
                // Hide tooltip for pie series
                if (this.series.options.type === 'pie') {
                    return false;
                }
                // If not null, use the default formatter
                return tooltip.defaultFormatter.call(this, tooltip);
            }))) // Set tooltip formatter JS function
        .plotOptionsSet(AAPlotOptions.new
            .seriesSet(AASeries.new
                .statesSet(AAStates.new
                    .inactiveSet(AAInactive.new.enabledSet(false))))
//            .pieSet(AAPie.new
//                .statesSet(AAStates.new
//                    .hoverSet(AAHover.new.haloSet(AAHalo.new.sizeSet(@0)))))
                        ) // Note: halo is object in AAChartKit
        .seriesSet(@[
            AASeriesElement.new
//                .colorKeySet(@"custom.stellarMagnitude")
                .maxSizeSet(@14)
                .minSizeSet(@3)
                .tooltipSet(AATooltip.new
                    .pointFormatSet(@"<table>"
                                     "<tr><td style='padding:0'><span class=\"smallerLabel\">Name:</span> {point.name}</td></tr>"
                                     "<tr><td style='padding:0'><span class=\"smallerLabel\">Mass:</span> {point.custom.planetMass}</td></tr>"
                                     "<tr><td style='padding:0'><span class=\"smallerLabel\">Distance:</span> {point.custom.lightYears} Light Years</td></tr>"
                                     "<tr><td style='padding:0'><span class=\"smallerLabel\">Stellar Magnitude:</span> {point.custom.stellarMagnitude}</td></tr>"
            "</table>".aa_toPureHTMLString)
            ),
            AASeriesElement.new
                .typeSet(AAChartTypePie)
                .dataLabelsSet(AADataLabels.new.enabledSet(false))
                .sizeSet(@"40%")
                .innerSizeSet(@"85%")
                .zIndexSet(@-1)
                .pointSet(AAPoint.new
                    .eventsSet(AAPointEvents.new
                .mouseOverSet(@AAJSFunc((function() {
                const {
                    minDate,
                    maxDate
                } = this.options.custom,
                point = this,
                series = this.series,
                chart = series.chart,
                bubbleSeries = chart.series[0];
                
                bubbleSeries.points.forEach(point => {
                    if (
                        point.options.custom.discoveryDate < minDate ||
                        point.options.custom.discoveryDate >= maxDate
                        ) {
                            point.graphic.attr({
                                opacity: 0.2
                            });
                        }
                });
                
                series.customLabel = fillCenter(
                                                point.percentage,
                                                point.options.custom.minDate,
                                                chart,
                                                series.customLabel
                                                );
            }))) // Set mouseOver JS function
                .mouseOutSet(@AAJSFunc((function() {
                const chart = this.series.chart,
                series = this.series,
                bubbleSeries = chart.series[0];
                
                bubbleSeries.points.forEach(point => {
                    point.graphic.attr({
                        opacity: 1
                    });
                });
                series.customLabel = fillCenter(
                                                100,
                                                '1990-2020',
                                                chart,
                                                series.customLabel
                                                );
            }))))) // Set mouseOut JS function
                .dataSet(@[
                    @{
                        @"y": @12,
                        @"color": colors[0],
                        @"custom": @{ @"minDate": @1990, @"maxDate": @2000 }
                    },
                    @{
                        @"y": @47,
                        @"color": colors[1],
                        @"custom": @{ @"minDate": @2000, @"maxDate": @2010 }
                    },
                    @{
                        @"y": @117,
                        @"color": colors[2],
                        @"custom": @{ @"minDate": @2010, @"maxDate": @2020 }
                    },
                    @{
                        @"y": @64,
                        @"color": colors[3],
                        @"custom": @{ @"minDate": @2020, @"maxDate": @2030 }
                    }
                ])
        ])
        ;

    return aaOptions;
}

@end
