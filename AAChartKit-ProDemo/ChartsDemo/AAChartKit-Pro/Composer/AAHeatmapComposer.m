//
//  AAHeatmapComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/1.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AAHeatmapComposer.h"
#import "AAChartKit-Pro.h"
#import "AAOptionsCSV.h"
#import "NSString+toPureJSString.h"
#import "AAOptionsData.h"

@implementation AAHeatmapComposer

+ (AAOptions *)heatmapChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeHeatmap))
    .titleSet(AATitle.new
              .textSet(@"Sales per employee per weekday"))
    .xAxisSet(AAXAxis.new
              .visibleSet(true)
              .categoriesSet(@[
                  @"Alexander", @"Marie", @"Maximilian", @"Sophia",
                  @"Lukas", @"Maria", @"Leon", @"Anna", @"Tim", @"Laura"
                             ]))
    .yAxisSet(AAYAxis.new
              .visibleSet(true)
              .categoriesSet(@[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday"])
              .titleSet(AAAxisTitle.new
                        .textSet(@"")))
    .colorAxisSet(AAColorAxis.new
                  .minSet(@0)
                  .minColorSet(AAColor.whiteColor)
                  .maxColorSet(@"#7cb5ec"))
    .legendSet(AALegend.new
               .enabledSet(true)
               .alignSet(AAChartAlignTypeRight)
               .layoutSet(AAChartLayoutTypeVertical)
               .verticalAlignSet(AAChartVerticalAlignTypeTop)
               .ySet(@25))
    .tooltipSet(AATooltip.new
                .enabledSet(true)
                .formatterSet(@AAJSFunc(function () {
                    return '<b>' + this.series.xAxis.categories[this.point.x] + '</b> sold <br><b>' +
                        this.point.value + '</b> items on <br><b>' + this.series.yAxis.categories[this.point.y] + '</b>';
                })))
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"Sales")
        .borderWidthSet(@1)
        .dataSet(AAOptionsData.heatmapData)
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(true)
                       .colorSet(AAColor.redColor))
               ]);
}

+ (AAOptions *)largeDataHeatmapChart {
    NSString *csvStr = AAOptionsCSV.csvData[@"csv"];
    return AAOptions.new
        .dataSet(AAData.new
                 .csvSet([self aa_toPureJSString2WithString:csvStr])
                 .parsedSet(@AAJSFunc(function () {
                     start = +new Date();
                 })))
        .chartSet(AAChart.new
            .typeSet(AAChartTypeHeatmap)
            .marginSet(@[@60, @10, @80, @50]))
        .titleSet(AATitle.new
            .textSet(@"大型热力图")
            .alignSet(AAChartAlignTypeLeft)
            .xSet(@40))
        .subtitleSet(AASubtitle.new
            .textSet(@"2013每天每小时的热力变化")
            .alignSet(AAChartAlignTypeLeft)
            .xSet(@40))
        .xAxisSet(AAXAxis.new
            .typeSet(AAChartAxisTypeDatetime)
            .minSet(@1356998400000)
            .maxSet(@1388534400000)
            .labelsSet(AALabels.new
                .alignSet(AAChartAlignTypeLeft)
                .xSet(@5)
                .ySet(@14)
                .formatSet(@"{value:%B}"))
//            .showLastLabelSet(false)
            .tickLengthSet(@16))
        .yAxisSet(AAYAxis.new
            .titleSet(AAAxisTitle.new
                .textSet((id)NSNull.new))
            .labelsSet(AALabels.new
                .formatSet(@"{value}:00"))
            .minPaddingSet(@0)
            .maxPaddingSet(@0)
            .startOnTickSet(false)
            .endOnTickSet(false)
            .tickPositionsSet(@[@0, @6, @12, @18, @24])
            .tickWidthSet(@1)
            .minSet(@0)
            .maxSet(@23)
            .reversedSet(true))
        .colorAxisSet(AAColorAxis.new
            .stopsSet(@[
                @[@0, @"#3060cf", ],
                @[@0.5, @"#fffbbc", ],
                @[@0.9, @"#c4463a", ],
                @[@1, @"#c4463a", ]
                ])
            .minSet(@-15)
            .maxSet(@25)
            .startOnTickSet(false)
            .endOnTickSet(false)
            .labelsSet(AALabels.new
                .formatSet(@"{value}℃"))
                      )
        .seriesSet(@[
            AAHeatmap.new
                .borderWidthSet(@0)
                .colsizeSet(@86400000)
                .tooltipSet(AATooltip.new
                    .headerFormatSet(@"Temperature")
                    .pointFormatSet(@"{point.x:%e %b, %Y} {point.y}:00: {point.value} ℃")
            )
                .turboThresholdSet(@1.7976931348623157e+308)
            ]);
}

+ (AAOptions *)calendarHeatmap {
    AAOptions *aaOptions = AAOptions.new
        .chartSet(AAChart.new
                  .typeSet(AAChartTypeHeatmap))
        .titleSet(AATitle.new
                  .textSet(@"Day temperature in Oslo, Norway July 2023")
                  .alignSet(AAChartAlignTypeLeft))
        .subtitleSet(AASubtitle.new
                     .textSet(@"Temperature variation at day through July")
                     .alignSet(AAChartAlignTypeLeft))
//        .accessibilitySet(AAAccessibility.new
//                          .landmarkVerbositySet(@"one"))
        .tooltipSet(AATooltip.new
                    .enabledSet(true)
                    .outsideSet(@true)
//                    .zIndexSet(@20)
                    .headerFormatSet(@"")
                    .pointFormatSet(@"{#unless point.custom.empty}{point.date:%A, %b %e, %Y}{/unless}")
//                    .nullFormatSet(@"No data")
                    )
        .xAxisSet(AAXAxis.new
                  .categoriesSet(@[@"Sunday", @"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday", @"Saturday"])
                  .oppositeSet(true)
                  .lineWidthSet(@26)
                  .offsetSet(@13)
                  .lineColorSet(@"rgba(27, 26, 37, 0.2)")
                  .labelsSet(AALabels.new
                             .rotationSet(@0)
                             .ySet(@20)
                             .styleSet(AAStyle.new
//                                       .textTransformSet(AAChartTitleAlignTypeUppercase)
                                       .fontWeightSet(AAChartFontWeightTypeBold)))
//                  .accessibilitySet(AAAccessibility.new
//                                    .descriptionSet(@"weekdays")
//                                    .rangeDescriptionSet(@"X Axis is showing all 7 days of the week, starting with Sunday."))
                  )
        .yAxisSet(AAYAxis.new
                  .minSet(@0)
                  .maxSet(@5)
//                  .accessibilitySet(AAAccessibility.new
//                                    .descriptionSet(@"weeks")
//                                    )
                  .visibleSet(false))
        .legendSet(AALegend.new
                   .alignSet(AAChartAlignTypeRight)
                   .layoutSet(AAChartLayoutTypeVertical)
                   .verticalAlignSet(AAChartVerticalAlignTypeMiddle))
        .colorAxisSet(AAColorAxis.new
                      .startOnTickSet(true)
                      .endOnTickSet(true)
                      .minSet(@0)
                      .stopsSet(@[
                        @[@0.2, @"lightblue"],
                        @[@0.4, @"#CBDFC8"],
                        @[@0.6, @"#F3E99E"],
                        @[@0.9, @"#F9A05C"]
                      ])
                      .labelsSet(AALabels.new
                                 .formatSet(@"{value} °C")))
        .seriesSet(@[
            AASeriesElement.new
                .keysSet(@[@"x", @"y", @"value", @"date", @"id"])
                .dataSet(AAOptionsData.calendarHeatmapData)
                .nullColorSet(@"rgba(196, 196, 196, 0.2)")
                .borderWidthSet(@2)
                .borderColorSet(@"rgba(196, 196, 196, 0.2)")
                .dataLabelsSet((id)@[
                    AADataLabels.new
                        .enabledSet(true)
                        .formatSet(@"{#unless point.custom.empty}{point.value:.1f}°{/unless}")
                        .styleSet(AAStyle.new
                        .textOutlineSet(@"none")
                        .fontWeightSet(AAChartFontWeightTypeRegular)
                        .fontSizeSet(@"1rem"))
                        .ySet(@4),
                    AADataLabels.new
                        .enabledSet(true)
                        .alignSet(AAChartAlignTypeLeft)
                        .verticalAlignSet(AAChartVerticalAlignTypeTop)
                        .formatSet(@"{#unless point.custom.empty}{point.custom.monthDay}{/unless}")
                        .backgroundColorSet(@"whitesmoke")
                        .paddingSet(@2)
                        .styleSet(AAStyle.new
                        .textOutlineSet(@"none")
                        .colorSet(@"rgba(70, 70, 92, 1)")
                        .fontSizeSet(@"0.8rem")
                        .fontWeightSet(AAChartFontWeightTypeBold)
                        .opacitySet(@0.5)
                    )
                        .xSet(@1)
                        .ySet(@1)
                ])
        ]);
    
    return aaOptions;
}

+ (NSString *)aa_toPureJSString2WithString:(NSString *)string {
    //https://stackoverflow.com/questions/34334232/why-does-function-not-work-but-function-does-chrome-devtools-node
    NSString *pureJSStr = [NSString stringWithFormat:@"(%@)",string];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\0" withString:@""];
//    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\u2028" withString:@"\\u2028"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\u2029" withString:@"\\u2029"];
    return pureJSStr;
}

@end
