//
//  AARelationshipChartComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import "AARelationshipChartComposer.h"
#import "AAChartKit-Pro.h"
#import "AAOptionsData.h"

@implementation AARelationshipChartComposer

+ (AAOptions *)sankeyChart {
    return AAOptions.new
    .titleSet(AATitle.new
              .textSet(@"AAChartKit-Pro 桑基图"))
    .colorsSet(@[
        AARgbaColor(137, 78, 36, 1.0),
        AARgbaColor(220, 36, 30, 1.0),
        AARgbaColor(255, 206, 0, 1.0),
        AARgbaColor(1, 114, 41, 1.0),
        AARgbaColor(0, 175, 173, 1.0),
        AARgbaColor(215, 153, 175, 1.0),
        AARgbaColor(106, 114, 120, 1.0),
        AARgbaColor(114, 17, 84, 1.0),
        AARgbaColor(0, 0, 0, 1.0),
        AARgbaColor(0, 24, 168, 1.0),
        AARgbaColor(0, 160, 226, 1.0),
        AARgbaColor(106, 187, 170, 1.0),
               ])
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeSankey)
        .keysSet(@[@"from", @"to", @"weight"])
        .dataSet(AAOptionsData.sankeyData),
               ]);
}

+ (AAOptions *)dependencywheelChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .marginLeftSet(@20)
              .marginRightSet(@20))
    .titleSet(AATitle.new
              .textSet(@"AAChartKit-Pro 和弦图"))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeDependencywheel)
        .nameSet(@"Dependency wheel series")
        .keysSet(@[@"from",@"to",@"weight"])
        .dataSet(AAOptionsData.dependencywheelData)
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(true)
                       .colorSet(@"#333")
                       .textPathSet(AATextPath.new
                                    .enabledSet(true)
                                    .attributesSet(@{ @"dy": @5 }))
                       .distanceSet(@10))
               ]);
}

//https://www.highcharts.com/docs/chart-and-series-types/arc-diagram
+ (AAOptions *)arcdiagramChart1 {
    return AAOptions.new
        .colorsSet(@[@"#293462", @"#a64942", @"#fe5f55", @"#fff1c1", @"#5bd1d7", @"#ff502f", @"#004d61", @"#ff8a5c", @"#fff591", @"#f5587b", @"#fad3cf", @"#a696c8", @"#5BE7C4", @"#266A2E", @"#593E1A"])
        .titleSet(AATitle.new
            .textSet(@"Main train connections in Europe"))
        .seriesSet(@[
            AASeriesElement.new
                .keysSet(@[@"from", @"to", @"weight"])
                .typeSet(AAChartTypeArcdiagram)
                .nameSet(@"Train connections")
                .linkWeightSet(@1)
                .centeredLinksSet(@true)
                .dataLabelsSet(AADataLabels.new
                    .rotationSet(@90)
                    .ySet(@30)
                    .alignSet(AAChartAlignTypeLeft)
                    .colorSet(AAColor.blackColor))
                .offsetSet(@"65%")
                .dataSet(AAOptionsData.arcdiagram1Data)
            ]);
}

+ (AAOptions *)arcdiagramChart2 {
    return AAOptions.new
        .titleSet(AATitle.new
            .textSet(@"Highcharts Arc Diagram"))
        .subtitleSet(AASubtitle.new
            .textSet(@"Arc Diagram with marker symbols"))
        .seriesSet(@[
            AASeriesElement.new
                .linkWeightSet(@1)
                .keysSet(@[@"from", @"to", @"weight", ])
                .typeSet(AAChartTypeArcdiagram)
                .markerSet(AAMarker.new
                    .symbolSet(AAChartSymbolTypeTriangle)
                    .lineWidthSet(@2)
                    .lineColorSet(AAColor.whiteColor))
                .centeredLinksSet(@true)
                .dataLabelsSet(AADataLabels.new
                    .formatSet(@"{point.fromNode.name} → {point.toNode.name}")
                    .nodeFormatSet(@"{point.name}")
                    .colorSet(AAColor.blackColor)
                    .linkTextPathSet(AATextPath.new
                        .enabledSet(true))
            )
                .dataSet(AAOptionsData.arcdiagram2Data)
            ]);
}

+ (AAOptions *)arcdiagramChart3 {
    return AAOptions.new
        .chartSet(AAChart.new
            .invertedSet(true))
        .titleSet(AATitle.new
            .textSet(@"Highcharts Inverted Arc Diagram"))
        .seriesSet(@[
            AASeriesElement.new
                .keysSet(@[@"from", @"to", @"weight", ])
//                .centerPosSet(@"50%")
                .typeSet(AAChartTypeArcdiagram)
                .dataLabelsSet(AADataLabels.new
                    .alignSet(AAChartAlignTypeRight)
                    .xSet(@-20)
                    .ySet(@-2)
                    .colorSet(@"#333333")
                    .overflowSet(@"allow")
                    .paddingSet(@0)
            )
                .offsetSet(@"60%")
                .dataSet(AAOptionsData.arcdiagram3Data)
            ]);
}

+ (AAOptions *)organizationChart {
    return AAOptions.new
        .chartSet(AAChart.new
//            .heightSet(@600)
            .invertedSet(true))
        .titleSet(AATitle.new
            .textSet(@"Highsoft 公司组织结构"))
        .seriesSet(@[
            AASeriesElement.new
                .typeSet(AAChartTypeOrganization)
                .nameSet(@"Highsoft")
                .keysSet(@[@"from", @"to"])
                .dataSet(AAOptionsData.organizationData)
                .levelsSet(@[
                    AALevelsElement.new
                        .levelSet(@0)
                        .colorSet(@"silver")
                        .dataLabelsSet(AADataLabels.new
                            .colorSet(AAColor.blackColor))
                        .heightSet(@25)
                    ,
                    AALevelsElement.new
                        .levelSet(@1)
                        .colorSet(@"silver")
                        .dataLabelsSet(AADataLabels.new
                            .colorSet(AAColor.blackColor))
                        .heightSet(@25)
                    ,
                    AALevelsElement.new
                        .levelSet(@2)
                        .colorSet(@"#980104")
                    ,
                    AALevelsElement.new
                        .levelSet(@4)
                        .colorSet(@"#359154")
                ])
                .nodesSet(AAOptionsData.organizationNodesData)
                .colorByPointSet(false)
                .colorSet(@"#007ad0")
                .dataLabelsSet(AADataLabels.new
                    .colorSet(AAColor.whiteColor))
                .borderColorSet(AAColor.whiteColor)
                .nodeWidthSet(@65)
            ])
        .tooltipSet(AATooltip.new
            .outsideSet(@true));
}

+ (AAOptions *)networkgraphChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeNetworkgraph))
    .titleSet(AATitle.new
              .textSet(@"The Indo-European Laungauge Tree"))
    .subtitleSet(AASubtitle.new
                 .textSet(@"A Force-Directed Network Graph in Highcharts"))
    .seriesSet(@[
        AASeriesElement.new
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(false))
        .dataSet(AAOptionsData.networkgraphData),
               ]);
}

@end
