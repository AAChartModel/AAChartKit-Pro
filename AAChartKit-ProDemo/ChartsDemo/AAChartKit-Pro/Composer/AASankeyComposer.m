//
//  AASankeyComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/1.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AASankeyComposer.h"
#import "AAChartKit-Pro.h"
#import "AAOptionsSeries.h"

@implementation AASankeyComposer

//Highcharts.chart('container', {
//
//    title: {
//        text: 'Estimated US Energy Consumption in 2022'
//    },
//    subtitle: {
//        text:
//      'Source: <a href=\'https://www.llnl.gov/\'> Lawrence Livermore National Laboratory</a>'
//    },
//    accessibility: {
//        point: {
//            valueDescriptionFormat: '{index}. {point.from} to {point.to}, ' +
//                '{point.weight}.'
//        }
//    },
//    tooltip: {
//        headerFormat: null,
//        pointFormat:
//      '{point.fromNode.name} \u2192 {point.toNode.name}: {point.weight:.2f} ' +
//      'quads',
//        nodeFormat: '{point.name}: {point.sum:.2f} quads'
//    },
//    series: 
//
//});

+ (AAOptions *)sankeyDiagramChart {
    return AAOptions.new
        .titleSet(AATitle.new
                  .textSet(@"Estimated US Energy Consumption in 2022"))
//        .subtitleSet(AASubtitle.new
//                     .textSet(@"Source: <a href='https://www.llnl.gov/'> Lawrence Livermore National Laboratory</a>"))
    //    .accessibilitySet(AAAccessibility.new
    //                        .pointSet(AAPoint.new
    //                                    .valueDescriptionFormatSet(@"{index}. {point.from} to {point.to}, {point.weight}.")
    //                                    )
    //                        )
        .tooltipSet(AATooltip.new
                    .headerFormatSet(@"null")
                    .pointFormatSet(@"{point.fromNode.name} \u2192 {point.toNode.name}: {point.weight:.2f} quads")
//                    .nodeFormatSet(@"{point.name}: {point.sum:.2f} quads")
                    )
        .seriesSet(AAOptionsSeries.sankeyDiagramSeries)
    ;
}
                 
    


@end
