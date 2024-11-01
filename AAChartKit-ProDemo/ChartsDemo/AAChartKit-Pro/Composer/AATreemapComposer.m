//
//  AATreemapComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/1.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AATreemapComposer.h"
#import "AAChartKit-Pro.h"
#import "NSString+toPureJSString.h"
#import "AAOptionsData.h"

@implementation AATreemapComposer

+ (AAOptions *)treemapWithColorAxisData {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeTreemap))
    .titleSet(AATitle.new
              .textSet(@"矩形树图"))
    .colorAxisSet(AAColorAxis.new
                  .minColorSet(AAColor.whiteColor)
                  .maxColorSet(AAColor.redColor))
    .seriesSet(@[
        AASeriesElement.new
        .dataSet(AAOptionsData.treemapWithColorAxisData)
               ]);
}

+ (AAOptions *)treemapWithLevelsData {
    return AAOptions.new
    .titleSet(AATitle.new
              .textSet(@"Fruit Consumption Situation"))
    .legendSet(AALegend.new
               .enabledSet(false))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeTreemap)
        .levelsSet(@[
            AALevelsElement.new
            .levelSet(@1)
            .layoutAlgorithmSet(@"sliceAndDice")
            .dataLabelsSet(AADataLabels.new
                           .enabledSet(true)
                           .alignSet(AAChartAlignTypeLeft)
                           .verticalAlignSet(AAChartVerticalAlignTypeTop)
                           .styleSet(AAStyleColorSizeWeight(AAColor.whiteColor, 15, AAChartFontWeightTypeBold)))
                   ])
        .dataSet(AAOptionsData.treemapWithLevelsData)]);
}
//Highcharts.chart('container', {
//    series: [{
//        type: 'treemap',
//        layoutAlgorithm: 'stripes',
//        alternateStartingDirection: true,
//        borderColor: '#fff',
//        borderRadius: 6,
//        borderWidth: 2,
//        dataLabels: {
//            style: {
//                textOutline: 'none'
//            }
//        },
//        levels: [{
//            level: 1,
//            layoutAlgorithm: 'sliceAndDice',
//            dataLabels: {
//                enabled: true,
//                align: 'left',
//                verticalAlign: 'top',
//                style: {
//                    fontSize: '15px',
//                    fontWeight: 'bold'
//                }
//            }
//        }],
//        data:
//    }],
//    title: {
//        text: 'Norwegian regions and counties by area',
//        align: 'left'
//    },
//    subtitle: {
//        text:
//            'Source: <a href="https://snl.no/Norge" target="_blank">SNL</a>',
//        align: 'left'
//    },
//    tooltip: {
//        useHTML: true,
//        pointFormat:
//            'The area of <b>{point.name}</b> is <b>{point.value} km<sup>' +
//            '2</sup></b>'
//    }
//});

+ (AAOptions *)treemapWithLevelsData2 {
    return AAOptions.new
    .titleSet(AATitle.new
              .textSet(@"Norwegian regions and counties by area")
              .alignSet(AAChartAlignTypeLeft))
    .subtitleSet(AASubtitle.new
                    .textSet(@"Source: <a href=\"https://snl.no/Norge\" target=\"_blank\">SNL</a>".aa_toPureHTMLString)
                    .alignSet(AAChartAlignTypeLeft))
    .tooltipSet(AATooltip.new
                .useHTMLSet(true)
                .pointFormatSet(@"The area of <b>{point.name}</b> is <b>{point.value} km<sup>2</sup></b>".aa_toPureHTMLString))
    .plotOptionsSet(AAPlotOptions.new
                    .treemapSet(AATreemap.new
                                .alternateStartingDirectionSet(true)
                                .layoutAlgorithmSet(@"squarified")))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeTreemap)
//        .layoutAlgorithmSet(@"stripes")
//        .alternateStartingDirectionSet(true)
        .borderColorSet(AAColor.whiteColor)
        .borderRadiusSet(@6)
        .borderWidthSet(@2)
        .dataLabelsSet(AADataLabels.new
                          .styleSet(AAStyle.new
                                    .colorSet(AAColor.blackColor)
                                    .textOutlineSet(@"none")))
        .levelsSet(@[
            AALevelsElement.new
            .levelSet(@1)
            .layoutAlgorithmSet(@"sliceAndDice")
            .dataLabelsSet(AADataLabels.new
                           .enabledSet(true)
                           .alignSet(AAChartAlignTypeLeft)
                           .verticalAlignSet(AAChartVerticalAlignTypeTop)
                           .styleSet(AAStyleColorSizeWeight(AAColor.blackColor, 15, AAChartFontWeightTypeBold)))
                   ])
        .dataSet(AAOptionsData.treemapWithLevels2Data)]);
}

+ (AAOptions *)drilldownLargeDataTreemapChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeTreemap))
    .titleSet(AATitle.new
              .textSet(@"2012年，全球每10w人口死亡率"))
    .subtitleSet(AASubtitle.new
                 .textSet(@"点击下钻"))
    .plotOptionsSet(AAPlotOptions.new
                    .treemapSet(AATreemap.new
                                .allowTraversingTreeSet(true)
                                .layoutAlgorithmSet(@"squarified")))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeTreemap)
        .levelsSet(@[
            AALevelsElement.new
            .levelSet(@1)
            .dataLabelsSet(AADataLabels.new
                           .enabledSet(true))
            .borderWidthSet(@3)
                   ])
        .dataSet(AAOptionsData.drilldownTreemapData)
               ]);
}

@end
