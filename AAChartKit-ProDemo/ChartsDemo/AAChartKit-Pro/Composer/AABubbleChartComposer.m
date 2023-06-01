//
//  AABubbleChartComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import "AABubbleChartComposer.h"
#import "AAChartKit-Pro.h"
#import "AAOptionsData.h"
#import "AAOptionsSeries.h"

@implementation AABubbleChartComposer

+ (AAOptions *)packedbubbleChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypePackedbubble))
    .titleSet(AATitle.new
              .textSet(@"2014 年世界各地碳排放量"))
    .tooltipSet(AATooltip.new
                .enabledSet(true)
                .useHTMLSet(true)
                .pointFormatSet(@"<b>{point.name}:</b> {point.y}m CO<sub>2</sub>"))
    .plotOptionsSet(AAPlotOptions.new
                    .packedbubbleSet(AAPackedbubble.new
                                     .minSizeSet(@"30%")
                                     .maxSizeSet(@"120%")
                                     .zMinSet(@0)
                                     .zMaxSet(@1000)
                                     .layoutAlgorithmSet(AALayoutAlgorithm.new //packedbubbleChart 和 packedbubbleSplitChart 只有layoutAlgorithm这一段不一样
                                                         .gravitationalConstantSet(@0.02)
                                                         .splitSeriesSet(@false))
                                     .dataLabelsSet(AADataLabels.new
                                                    .enabledSet(true)
                                                    .formatSet(@"{point.name}")
                                                    .filterSet(AAFilter.new
                                                               .propertySet(@"y")
                                                               .operatorSet(@">")
                                                               .valueSet(@250)))))
    .seriesSet(AAOptionsSeries.packedbubbleSeries);
}

+ (AAOptions *)packedbubbleSplitChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypePackedbubble))
    .titleSet(AATitle.new
              .textSet(@"2014 年世界各地碳排放量"))
    .tooltipSet(AATooltip.new
                .enabledSet(true)
                .useHTMLSet(true)
                .pointFormatSet(@"<b>{point.name}:</b> {point.y}m CO<sub>2</sub>"))
    .plotOptionsSet(AAPlotOptions.new
                    .packedbubbleSet(AAPackedbubble.new
                                     .minSizeSet(@"30%")
                                     .maxSizeSet(@"120%")
                                     .zMinSet(@0)
                                     .zMaxSet(@1000)
                                     .layoutAlgorithmSet(AALayoutAlgorithm.new //packedbubbleChart 和 packedbubbleSplitChart 只有layoutAlgorithm这一段不一样
                                                         .gravitationalConstantSet(@0.05)
                                                         .splitSeriesSet(@true)
                                                         .seriesInteractionSet(@false)
                                                         .dragBetweenSeriesSet(@true)
                                                         .parentNodeLimitSet(@true))
                                     .dataLabelsSet(AADataLabels.new
                                                    .enabledSet(true)
                                                    .formatSet(@"{point.name}")
                                                    .filterSet(AAFilter.new
                                                               .propertySet(@"y")
                                                               .operatorSet(@">")
                                                               .valueSet(@250)))))
    .seriesSet(AAOptionsSeries.packedbubbleSeries);
}

+ (AAOptions *)packedbubbleSpiralChart {
    return AAOptions.new
        .chartSet(AAChart.new
                  .typeSet(AAChartTypePackedbubble)
//                  .heightSet((id)@"100%")
                  )
        .titleSet(AATitle.new
                  .textSet(@"Carbon emissions around the world (2014)"))
        .tooltipSet(AATooltip.new
                    .useHTMLSet(true)
                    .pointFormatSet(@"{point.name}: {point.y}m CO2"))
        .plotOptionsSet(AAPlotOptions.new
                        .packedbubbleSet(AAPackedbubble.new
                                         .useSimulationSet(@false)
                                         .minSizeSet(@"20%")
                                         .maxSizeSet(@"80%")
                                         .dataLabelsSet(AADataLabels.new
                                                        .enabledSet(true)
                                                        .formatSet(@"{point.name}")
                                                        .filterSet(AAFilter.new
                                                                   .propertySet(@"y")
                                                                   .operatorSet(@">")
                                                                   .valueSet(@250))
                                                        .styleSet(AAStyle.new
                                                                  .colorSet(AAColor.blackColor)
                                                                  .textOutlineSet(@"none")
                                                                  .fontWeightSet(@"normal")))))
        .seriesSet(AAOptionsSeries.packedbubbleSeries);
}

+ (AAOptions *)eulerChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeVenn))
    .titleSet(AATitle.new
              .textSet(@"欧拉图和韦恩图的关系"))
    .tooltipSet(AATooltip.new
                .enabledSet(true)
                .headerFormatSet([NSString stringWithFormat:@"%@%@",
                                  @"<span style=""color:{point.color}"">\u2022</span>",
                                  @"<span style=""font-size: 14px""> {point.point.name}</span><br/>"])
                .pointFormatSet(@"{point.description}<br><span style=""font-size: 10px"">Source: Wikipedia</span>"))
    .seriesSet(@[
        AASeriesElement.new
        .dataSet(AAOptionsData.eulerData),
               ]);
}

+ (AAOptions *)vennChart {
    return AAOptions.new
    .titleSet(AATitle.new
              .textSet(@"The Unattainable Triangle"))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeVenn)
        .dataSet(AAOptionsData.vennData)]);
}

@end
