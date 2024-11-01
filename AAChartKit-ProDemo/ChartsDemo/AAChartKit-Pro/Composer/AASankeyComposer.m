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
#import "NSString+toPureJSString.h"

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
            .subtitleSet(AASubtitle.new
                         .textSet(@"Source: <a href='https://www.llnl.gov/'> Lawrence Livermore National Laboratory</a>".aa_toPureHTMLString))
    //    .accessibilitySet(AAAccessibility.new
    //                        .pointSet(AAPoint.new
    //                                    .valueDescriptionFormatSet(@"{index}. {point.from} to {point.to}, {point.weight}.")
    //                                    )
    //                        )
        .tooltipSet(AATooltip.new
                    .headerFormatSet(@"null")
                    .pointFormatSet(@"{point.fromNode.name} \u2192 {point.toNode.name}: {point.weight:.2f} quads")
                    .nodeFormatSet(@"{point.name}: {point.sum:.2f} quads"))
        .seriesSet(AAOptionsSeries.sankeyDiagramSeries)
    ;
}
                 
//Highcharts.chart('container', {
//    chart: {
//        type: 'sankey',
//        inverted: true,
//        height: 1000
//    },
//    title: {
//        text: 'Evaluating the energy consumed for water use in the United ' +
//            'States',
//        align: 'left'
//    },
//    subtitle: {
//        text: 'Data source: <a href="https://iopscience.iop.org/article/10.1088/1748-9326/7/3/034034/pdf">The University of Texas at Austin</a>',
//        align: 'left'
//    },
//    accessibility: {
//        point: {
//            valueDescriptionFormat: '{index}. {point.from} to {point.to}, ' +
//                '{point.weight}.'
//        }
//    },
//    plotOptions: {
//        sankey: {
//            states: {
//                inactive: {
//                    enabled: false
//                }
//            },
//            tooltip: {
//                nodeFormat: '{point.name}: <b>{point.sum} quads</b><br/>'
//            }
//        }
//    },
//    tooltip: {
//        valueSuffix: ' quads'
//    },
//     series: [{
//name: 'Energy consumed for water use in U.S.',
//dataLabels: {
//    nodeFormatter() {
//        const maxLetters = this.point.shapeArgs.height / 8,
//            name = this.point.name,
//            firstWord = name.slice(0, maxLetters);
//
//        if (firstWord.length >= name.length) {
//            return firstWord.toUpperCase();
//        }
//        return name.toUpperCase();
//    },
//    style: {
//        textOutline: 'none',
//        color: '#4a4a4a'
//    }
//},
//});


+ (AAOptions *)verticalSankeyChart {
    return AAOptions.new
        .chartSet(AAChart.new
                  .typeSet(AAChartTypeSankey)
                  .invertedSet(true)
                  //                    .heightSet(@1000)
                  )
        .titleSet(AATitle.new
                  .textSet(@"Evaluating the energy consumed for water use in the United States")
                  .alignSet(AAChartAlignTypeLeft))
        .subtitleSet(AASubtitle.new
                     .textSet(@"Data source: <a href='https://iopscience.iop.org/article/10.1088/1748-9326/7/3/034034/pdf'>The University of Texas at Austin</a>".aa_toPureHTMLString)
                     .alignSet(AAChartAlignTypeLeft))
    //            .accessibilitySet(AAAccessibility.new
    //                            .pointSet(AAPoint.new
    //                                        .valueDescriptionFormatSet(@"{index}. {point.from} to {point.to}, {point.weight}.")
    //                                        )
    //                            )
        .plotOptionsSet(AAPlotOptions.new
                        .seriesSet(AASeries.new
                                   .statesSet(AAStates.new
                                              .inactiveSet(AAInactive.new
                                                           .enabledSet(false)))
                                   .tooltipSet(AATooltip.new
                                               .nodeFormatSet(@"{point.name}: <b>{point.sum} quads</b><br/>"))
                                   .dataLabelsSet(AADataLabels.new
                                                  .nodeFormatterSet(@AAJSFunc((function() {
                                                      const maxLetters = this.point.shapeArgs.height / 8,
                                                      name = this.point.name,
                                                      firstWord = name.slice(0, maxLetters);
                                                      
                                                      if (firstWord.length >= name.length) {
                                                          return firstWord.toUpperCase();
                                                      }
                                                      return name.toUpperCase();
                                                  })))
                                                  .styleSet(AAStyle.new
                                                            .textOutlineSet(@"none")
                                                            .colorSet(@"#4a4a4a")))))
        .tooltipSet(AATooltip.new
                    .valueSuffixSet(@"quads"))
        .seriesSet(AAOptionsSeries.verticalSankeySeries)
    ;
}



@end
