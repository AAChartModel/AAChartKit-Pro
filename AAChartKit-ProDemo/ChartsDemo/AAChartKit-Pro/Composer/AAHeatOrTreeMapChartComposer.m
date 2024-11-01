//
//  AATreeOrHeatMapChartComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import "AAHeatOrTreeMapChartComposer.h"
#import "AAChartKit-Pro.h"
#import "AAOptionsCSV.h"
#import "NSString+toPureJSString.h"
#import "AAOptionsData.h"

@implementation AAHeatOrTreeMapChartComposer




//    static func simpleTilemapWithHexagonTileShape() -> AAOptions {
//        AAOptions()
//            .chart(AAChart()
//                .type(.tilemap)
//                .marginTop(15)
////                .height("65%")
//            )
//            .title(AATitle()
//                .text("Idea map"))
//            .subtitle(AASubtitle()
//                .text("Hover over tiles for details"))
//            .colors([
//                "#fed",
//                "#ffddc0",
//                "#ecb",
//                "#dba",
//                "#c99",
//                "#b88",
//                "#aa7577",
//                "#9f6a66"
//            ])
//                    .xAxis(AAXAxis()
//                        .visible(false))
//                    .yAxis(AAYAxis()
//                        .visible(false))
//                    .legend(AALegend()
//                        .enabled(false))
//                    .tooltip(AATooltip()
//                        .headerFormat("")
//                        .backgroundColor("rgba(247,247,247,0.95)")
////                        .pointFormat("<span style=\"color: {point.color}\">●</span>" +
////                                     "<span style=\"font-size: 13px; font-weight: bold\"> {point.name}" +
////                                     "</span><br>{point.desc}")
//                            .style(AAStyle()
//                                .width(170))
//                                .padding(10)
//        //                        .hideDelay(1000000)
//                    )
//                    .plotOptions(AAPlotOptions()
//                        .series(AASeries()
//                            .keys(["x", "y", "name", "desc"])
//                            .tileShape(.hexagon)
//                            .dataLabels(AADataLabels()
//                                .enabled(true)
//                                .format("{point.name}")
//                                .color("#000000")
//                                .style(AAStyle()
////                                    .textOutline(false)
//                                ))))
//                    .series([
//                        AASeriesElement()
//                            .name("Main idea")
////                            .pointPadding(10)
//                            .data([
//                                [5, 3, "Main idea",
//                                 "The main idea tile outlines the overall theme of the idea map."]
//                            ])
//                            .color("#7eb"),
//                        AASeriesElement()
//                            .name("Steps")
//                            .colorByPoint(true)
//                            .data(AAOptionsData.simpleTilemapData)
//                    ])
//    }

+ (AAOptions *)simpleTilemapWithHexagonTileShape {
    return AAOptions.new
        .chartSet(AAChart.new
            .typeSet(AAChartTypeTilemap)
            .marginTopSet(@15))
        .titleSet(AATitle.new
            .textSet(@"Idea map"))
        .subtitleSet(AASubtitle.new
            .textSet(@"Hover over tiles for details"))
        .colorsSet(@[
            @"#fed",
            @"#ffddc0",
            @"#ecb",
            @"#dba",
            @"#c99",
            @"#b88",
            @"#aa7577",
            @"#9f6a66"
        ])
        .xAxisSet(AAXAxis.new
            .visibleSet(false))
        .yAxisSet(AAYAxis.new
            .visibleSet(false))
        .legendSet(AALegend.new
            .enabledSet(false))
        .tooltipSet(AATooltip.new
            .headerFormatSet(@"")
            .backgroundColorSet(@"rgba(247,247,247,0.95)")
            .styleSet(AAStyle.new
                .widthSet(@170)
            .paddingSet(@10)
            ))
        .plotOptionsSet(AAPlotOptions.new
            .seriesSet(AASeries.new
                .keysSet(@[@"x", @"y", @"name", @"desc"])
                       .tileShapeSet(AAChartTileShapeTypeHexagon)
                .dataLabelsSet(AADataLabels.new
                    .enabledSet(true)
                    .formatSet(@"{point.name}")
                    .colorSet(@"#000000")
                    .styleSet(AAStyle.new
                        .textOutlineSet(false)))))
        .seriesSet(@[
            AASeriesElement.new
                .nameSet(@"Main idea")
                .dataSet(@[
                    @[@5, @3, @"Main idea",
                      @"The main idea tile outlines the overall theme of the idea map."]
                ])
                .colorSet(@"#7eb"),
            AASeriesElement.new
                .nameSet(@"Steps")
                .colorByPointSet(@true)
                .dataSet(AAOptionsData.simpleTilemapData)
        ]);
}

//    static func simpleTilemapWithCircleTileShape() -> AAOptions {
//        let aaOptions = simpleTilemapWithHexagonTileShape()
//        aaOptions.plotOptions?.series?
//                .tileShape(.circle)
//        return aaOptions
//    }
//
//    static func simpleTilemapWithDiamondTileShape() -> AAOptions {
//        let aaOptions = simpleTilemapWithHexagonTileShape()
//        aaOptions.plotOptions?.series?
//                .tileShape(.diamond)
//        return aaOptions
//    }
//
//    static func simpleTilemapWithSquareTileShape() -> AAOptions {
//        let aaOptions = simpleTilemapWithHexagonTileShape()
//        aaOptions.plotOptions?.series?
//                .tileShape(.square)
//        return aaOptions
//    }

+ (AAOptions *)simpleTilemapWithCircleTileShape {
    AAOptions *aaOptions = [self simpleTilemapWithHexagonTileShape];
    aaOptions.plotOptions.series
            .tileShapeSet(AAChartTileShapeTypeCircle);
    return aaOptions;
}

+ (AAOptions *)simpleTilemapWithDiamondTileShape {
    AAOptions *aaOptions = [self simpleTilemapWithHexagonTileShape];
    aaOptions.plotOptions.series
            .tileShapeSet(AAChartTileShapeTypeDiamond);
    return aaOptions;
}

+ (AAOptions *)simpleTilemapWithSquareTileShape {
    AAOptions *aaOptions = [self simpleTilemapWithHexagonTileShape];
    aaOptions.plotOptions.series
            .tileShapeSet(AAChartTileShapeTypeSquare);
    return aaOptions;
}

// static func tilemapForAfricaWithHexagonTileShape() -> AAOptions {
//        AAOptions()
//            .chart(AAChart()
//                .type(.tilemap)
////                .height("125%")
//            )
//            .title(AATitle()
//                .text("Africa Real GDP Growth Forecasts for 2017")
//                .align(.left))
//            .xAxis(AAXAxis()
//                .visible(false))
//            .yAxis(AAYAxis()
//                .visible(false))
//            .legend(AALegend()
//                .enabled(true)
//                .layout(.vertical)
//                .align(.left)
//                .y(-20)
//                .floating(true))
//            .colorAxis(AAColorAxis()
//                .dataClasses([
//                    AADataClassesElement()
//                        .to(2)
//                        .color("#e8f5e9")
//                        .name("Weak"),
//                    AADataClassesElement()
//                        .from(2)
//                        .to(5)
//                        .color("#81c784")
//                        .name("Average"),
//                    AADataClassesElement()
//                        .from(5)
//                        .to(6)
//                        .color("#43a047")
//                        .name("Strong"),
//                    AADataClassesElement()
//                        .from(6)
//                        .color("#1b5e20")
//                        .name("Stellar")
//                ]))
//            .tooltip(AATooltip()
//                .headerFormat("")
//                .pointFormat("The real GDP growth of <b>{point.name}</b> is <b>{point.value}</b> %"))
//            .plotOptions(AAPlotOptions()
//                .series(AASeries()
//                    .tileShape(.hexagon)
//                    .dataLabels(AADataLabels()
//                        .enabled(true)
//                        .format("{point.iso-a3}")
//                        .color("#000000")
//                        .style(AAStyle()
////                            .textOutline(false)
//                        ))))
//            .series([
//                AASeriesElement()
//                    .data(AAOptionsData.tilemapForAfricaData)
//            ])
// }

+ (AAOptions *)tilemapForAfricaWithHexagonTileShape {
    return AAOptions.new
            .chartSet(AAChart.new
                    .typeSet(AAChartTypeTilemap))
            .titleSet(AATitle.new
                    .textSet(@"Africa Real GDP Growth Forecasts for 2017")
                    .alignSet(AAChartAlignTypeLeft))
            .xAxisSet(AAXAxis.new
                    .visibleSet(false))
            .yAxisSet(AAYAxis.new
                    .visibleSet(false))
            .legendSet(AALegend.new
                       .enabledSet(true)
                       .layoutSet(AAChartLayoutTypeVertical)
                       .alignSet(AAChartAlignTypeLeft)
                       .ySet(@(-20))
                       .floatingSet(true))
            .colorAxisSet(AAColorAxis.new
                    .dataClassesSet(@[
                        AADataClassesElement.new
                                .toSet(@2)
                                .colorSet(@"#e8f5e9")
                                .nameSet(@"Weak"),
                        AADataClassesElement.new
                                .fromSet(@2)
                                .toSet(@5)
                                .colorSet(@"#81c784")
                                .nameSet(@"Average"),
                        AADataClassesElement.new
                                .fromSet(@5)
                                .toSet(@6)
                                .colorSet(@"#43a047")
                                .nameSet(@"Strong"),
                        AADataClassesElement.new
                                .fromSet(@6)
                                .colorSet(@"#1b5e20")
                                .nameSet(@"Stellar")
                    ]))
            .tooltipSet(AATooltip.new
                    .headerFormatSet(@"")
                    .pointFormatSet(@"The real GDP growth of <b>{point.name}</b> is <b>{point.value}</b> %"))
            .plotOptionsSet(AAPlotOptions.new
                    .seriesSet(AASeries.new
                            .tileShapeSet(AAChartTileShapeTypeHexagon)
                            .dataLabelsSet(AADataLabels.new
                                    .enabledSet(true)
                                    .formatSet(@"{point.iso-a3}")
                                    .colorSet(@"#000000")
                                    .styleSet(AAStyle.new
                                            .textOutlineSet(false)
                                    ))))
            .seriesSet(@[
                    AASeriesElement.new
                            .dataSet(AAOptionsData.tilemapForAfricaData)
            ]);
}

//    static func tilemapForAfricaWithCircleTileShape() -> AAOptions {
//        let aaOptions = tilemapForAfricaWithHexagonTileShape()
//        aaOptions.plotOptions?.series?
//                .tileShape(.circle)
//        return aaOptions
//    }
//
//    static func tilemapForAfricaWithDiamondTileShape() -> AAOptions {
//        let aaOptions = tilemapForAfricaWithHexagonTileShape()
//        aaOptions.plotOptions?.series?
//                .tileShape(.diamond)
//        return aaOptions
//    }
//
//    static func tilemapForAfricaWithSquareTileShape() -> AAOptions {
//        let aaOptions = tilemapForAfricaWithHexagonTileShape()
//        aaOptions.plotOptions?.series?
//                .tileShape(.square)
//        return aaOptions
//    }

+ (AAOptions *)tilemapForAfricaWithCircleTileShape {
    AAOptions *aaOptions = [self tilemapForAfricaWithHexagonTileShape];
    aaOptions.plotOptions.series
            .tileShapeSet(AAChartTileShapeTypeCircle);
    return aaOptions;
}

+ (AAOptions *)tilemapForAfricaWithDiamondTileShape {
    AAOptions *aaOptions = [self tilemapForAfricaWithHexagonTileShape];
    aaOptions.plotOptions.series
            .tileShapeSet(AAChartTileShapeTypeDiamond);
    return aaOptions;
}

+ (AAOptions *)tilemapForAfricaWithSquareTileShape {
    AAOptions *aaOptions = [self tilemapForAfricaWithHexagonTileShape];
    aaOptions.plotOptions.series
            .tileShapeSet(AAChartTileShapeTypeSquare);
    return aaOptions;
}

+ (AAOptions *)tilemapChartForAmericaWithHexagonTileShape {
    return AAOptions.new
            .chartSet(AAChart.new
                    .typeSet(AAChartTypeTilemap))
            .titleSet(AATitle.new
                    .textSet(@"U.S. states by population in 2016"))
            .xAxisSet(AAXAxis.new
                    .visibleSet(false))
            .yAxisSet(AAYAxis.new
                    .visibleSet(false))
            .colorAxisSet(AAColorAxis.new
                    .dataClassesSet(@[
                            AADataClassesElement.new
                                    .fromSet(@0)
                                    .toSet(@1000000)
                                    .colorSet(@"#F9EDB3")
                                    .nameSet(@"< 1M"),
                            AADataClassesElement.new
                                    .fromSet(@1000000)
                                    .toSet(@5000000)
                                    .colorSet(@"#FFC428")
                                    .nameSet(@"1M - 5M"),
                            AADataClassesElement.new
                                    .fromSet(@5000000)
                                    .toSet(@20000000)
                                    .colorSet(@"#F9EDB3")
                                    .nameSet(@"5M - 20M"),
                            AADataClassesElement.new
                                    .fromSet(@20000000)
                                    .colorSet(@"#FF2371")
                                    .nameSet(@"> 20M"),
                    ]))
            .tooltipSet(AATooltip.new
                    .enabledSet(true)
                    .headerFormatSet(@"")
                    .valueSuffixSet(@"The population of <b> {point.name}</b> is <b>{point.value}</b>"))
            .plotOptionsSet(AAPlotOptions.new
                    .seriesSet(AASeries.new
                            .dataLabelsSet(AADataLabels.new
                                    .enabledSet(true)
                                    .formatSet(@"{point.hc-a2}")
                                    .colorSet(AAColor.whiteColor)
                                    .styleSet(AAStyle.new
                                            .textOutlineSet(@"none")))))
            .seriesSet(@[
                    AASeriesElement.new
                            .nameSet(@"Height")
                            .colorByPointSet(@true)
                            .dataSet(AAOptionsData.tilemapData)
            ]);
}

//    static func tilemapChartForAmericaWithCircleTileShape() -> AAOptions {
//        let aaOptions = tilemapChartForAmericaWithHexagonTileShape()
//        aaOptions.plotOptions?.series?
//                .tileShape(.circle)
//        return aaOptions
//    }
//
//    static func tilemapChartForAmericaWithDiamondTileShape() -> AAOptions {
//        let aaOptions = tilemapChartForAmericaWithHexagonTileShape()
//        aaOptions.plotOptions?.series?
//                .tileShape(.diamond)
//        return aaOptions
//    }
//
//    static func tilemapChartForAmericaWithSquareTileShape() -> AAOptions {
//        let aaOptions = tilemapChartForAmericaWithHexagonTileShape()
//        aaOptions.plotOptions?.series?
//                .tileShape(.square)
//        return aaOptions
//    }

+ (AAOptions *)tilemapChartForAmericaWithCircleTileShape {
    AAOptions *aaOptions = [self tilemapChartForAmericaWithHexagonTileShape];
    aaOptions.plotOptions.series
            .tileShapeSet(AAChartTileShapeTypeCircle);
    return aaOptions;
}

+ (AAOptions *)tilemapChartForAmericaWithDiamondTileShape {
    AAOptions *aaOptions = [self tilemapChartForAmericaWithHexagonTileShape];
    aaOptions.plotOptions.series
            .tileShapeSet(AAChartTileShapeTypeDiamond);
    return aaOptions;
}

+ (AAOptions *)tilemapChartForAmericaWithSquareTileShape {
    AAOptions *aaOptions = [self tilemapChartForAmericaWithHexagonTileShape];
    aaOptions.plotOptions.series
            .tileShapeSet(AAChartTileShapeTypeSquare);
    return aaOptions;
}

//configure tree graph chart options
//{
//    chart: {
//        inverted: true,
//        marginBottom: 170
//    },
//    title: {
//        text: 'Inverted treegraph',
//        align: 'left'
//    },
//    series: [
//        {
//            type: 'treegraph',
//            data,
//            tooltip: {
//                pointFormat: '{point.name}'
//            },
//            dataLabels: {
//                pointFormat: '{point.name}',
//                style: {
//                    whiteSpace: 'nowrap',
//                    color: '#000000',
//                    textOutline: '3px contrast'
//                },
//                crop: false
//            },
//            marker: {
//                radius: 6
//            },
//            levels: [
//                {
//                    level: 1,
//                    dataLabels: {
//                        align: 'left',
//                        x: 20
//                    }
//                },
//                {
//                    level: 2,
//                    colorByPoint: true,
//                    dataLabels: {
//                        verticalAlign: 'bottom',
//                        y: -20
//                    }
//                },
//                {
//                    level: 3,
//                    colorVariation: {
//                        key: 'brightness',
//                        to: -0.5
//                    },
//                    dataLabels: {
//                        align: 'left',
//                        rotation: 90,
//                        y: 20
//                    }
//                }
//            ]
//        }
//    ]
//}

+ (AAOptions *)treegraph {
    AAOptions *aaOptions = [self invertedTreegraph];
    aaOptions.chart.inverted = false;
    return aaOptions;
}

+ (AAOptions *)invertedTreegraph {
    return AAOptions.new
    .chartSet(AAChart.new
              .invertedSet(true)
              .marginBottomSet(@170))
    .titleSet(AATitle.new
              .textSet(@"Inverted treegraph")
              .alignSet(AAChartAlignTypeLeft))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeTreegraph)
        .dataSet(AAOptionsData.treegraphData)
        .tooltipSet(AATooltip.new
                    .pointFormatSet(@"{point.name}"))
        .dataLabelsSet(AADataLabels.new
//                       .pointFormatSet(@"{point.name}")
                       .styleSet(AAStyle.new
//                                 .whiteSpaceSet(AAChartWhiteSpaceTypeNowrap)
                                 .colorSet(@"#000000")
                                 .textOutlineSet(@"3px contrast"))
                       .cropSet(false))
        .markerSet(AAMarker.new
                   .radiusSet(@6))
        .levelsSet(@[
            AALevelsElement.new
            .levelSet(@1)
            .dataLabelsSet(AADataLabels.new
                           .alignSet(AAChartAlignTypeLeft)
                           .xSet(@20)),
            AALevelsElement.new
            .levelSet(@2)
            .colorByPointSet(@true)
            .dataLabelsSet(AADataLabels.new
                           .verticalAlignSet(AAChartVerticalAlignTypeBottom)
                           .ySet(@(-20))),
            AALevelsElement.new
            .levelSet(@3)
            .colorVariationSet(AAColorVariation.new
                               .keySet(@"brightness")
                               .toSet(@(-0.5)))
            .dataLabelsSet(AADataLabels.new
                           .alignSet(AAChartAlignTypeLeft)
                           .rotationSet(@90)
                           .ySet(@20))
        ])
    ]);
}

//{
//    title: {
//        text: 'Treegraph with box layout'
//    },
//    series: [
//        {
//            type: 'treegraph',
//            data,
//            tooltip: {
//                pointFormat: '{point.name}'
//            },
//            marker: {
//                symbol: 'rect',
//                width: '25%'
//            },
//            borderRadius: 10,
//            dataLabels: {
//                pointFormat: '{point.name}',
//                style: {
//                    whiteSpace: 'nowrap'
//                }
//            },
//            levels: [
//                {
//                    level: 1,
//                    levelIsConstant: false
//                },
//                {
//                    level: 2,
//                    colorByPoint: true
//                },
//                {
//                    level: 3,
//                    colorVariation: {
//                        key: 'brightness',
//                        to: -0.5
//                    }
//                },
//                {
//                    level: 4,
//                    colorVariation: {
//                        key: 'brightness',
//                        to: 0.5
//                    }
//                }
//            ]
//        }
//    ]
//}

+ (AAOptions *)treegraphWithBoxLayout {
    return AAOptions.new
    .titleSet(AATitle.new
              .textSet(@"Treegraph with box layout"))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeTreegraph)
        .dataSet(AAOptionsData.treegraphData)
        .tooltipSet(AATooltip.new
                    .pointFormatSet(@"{point.name}"))
        .markerSet(AAMarker.new
                   .symbolSet(@"rect")
                   .widthSet((id)@"25%"))
        .borderRadiusSet(@10)
        .dataLabelsSet(AADataLabels.new
//                       .pointFormatSet(@"{point.name}")
                       .styleSet(AAStyle.new
//                                 .whiteSpaceSet(AAChartWhiteSpaceTypeNowrap)
                       ))
        .levelsSet(@[
            AALevelsElement.new
            .levelSet(@1)
//            .levelIsConstantSet(false)
            ,
            AALevelsElement.new
            .levelSet(@2)
            .colorByPointSet(@true),
            AALevelsElement.new
            .levelSet(@3)
            .colorVariationSet(AAColorVariation.new
                               .keySet(@"brightness")
                               .toSet(@(-0.5))),
            AALevelsElement.new
            .levelSet(@4)
            .colorVariationSet(AAColorVariation.new
                               .keySet(@"brightness")
                               .toSet(@0.5))
        ])
    ]);
}



@end
