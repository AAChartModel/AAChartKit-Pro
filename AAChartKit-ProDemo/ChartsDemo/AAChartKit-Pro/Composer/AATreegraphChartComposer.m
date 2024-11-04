//
//  AATreegraphChartComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/1.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AATreegraphChartComposer.h"
#import "AAChartKit-Pro.h"
#import "AAOptionsCSV.h"
#import "NSString+toPureJSString.h"
#import "AAOptionsData.h"

@implementation AATreegraphChartComposer

/**
//configure tree graph chart options
{
    chart: {
        inverted: true,
        marginBottom: 170
    },
    title: {
        text: 'Inverted treegraph',
        align: 'left'
    },
    series: [
        {
            type: 'treegraph',
            data,
            tooltip: {
                pointFormat: '{point.name}'
            },
            dataLabels: {
                pointFormat: '{point.name}',
                style: {
                    whiteSpace: 'nowrap',
                    color: '#000000',
                    textOutline: '3px contrast'
                },
                crop: false
            },
            marker: {
                radius: 6
            },
            levels: [
                {
                    level: 1,
                    dataLabels: {
                        align: 'left',
                        x: 20
                    }
                },
                {
                    level: 2,
                    colorByPoint: true,
                    dataLabels: {
                        verticalAlign: 'bottom',
                        y: -20
                    }
                },
                {
                    level: 3,
                    colorVariation: {
                        key: 'brightness',
                        to: -0.5
                    },
                    dataLabels: {
                        align: 'left',
                        rotation: 90,
                        y: 20
                    }
                }
            ]
        }
    ]
}
*/
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
                       .formatSet(@"{point.name}")
                       .styleSet(AAStyle.new
                                 .whiteSpaceSet(@"nowrap")
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


/**
{
    title: {
        text: 'Treegraph with box layout'
    },
    series: [
        {
            type: 'treegraph',
            data,
            tooltip: {
                pointFormat: '{point.name}'
            },
            marker: {
                symbol: 'rect',
                width: '25%'
            },
            borderRadius: 10,
            dataLabels: {
                pointFormat: '{point.name}',
                style: {
                    whiteSpace: 'nowrap'
                }
            },
            levels: [
                {
                    level: 1,
                    levelIsConstant: false
                },
                {
                    level: 2,
                    colorByPoint: true
                },
                {
                    level: 3,
                    colorVariation: {
                        key: 'brightness',
                        to: -0.5
                    }
                },
                {
                    level: 4,
                    colorVariation: {
                        key: 'brightness',
                        to: 0.5
                    }
                }
            ]
        }
    ]
}
*/
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
                       .formatSet(@"{point.name}")
                       .styleSet(AAStyle.new
                                 .whiteSpaceSet(@"nowrap")
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
