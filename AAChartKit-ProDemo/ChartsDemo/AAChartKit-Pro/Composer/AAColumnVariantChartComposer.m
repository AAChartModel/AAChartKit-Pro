//
//  AAColumnVariantChartComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import "AAColumnVariantChartComposer.h"
#import "AAChartKit-Pro.h"

@implementation AAColumnVariantChartComposer

+ (AAOptions *)variwideChart {
    AAChart *aaChart = AAChart.new
    .typeSet(AAChartTypeVariwide);
    
    AATitle *aaTitle = AATitle.new
    .textSet(@"2016 年欧洲各国人工成本");
    
    AASubtitle *aaSubtitle = AASubtitle.new
    .textSet(@"数据来源:EUROSTAT");
    
    AAXAxis *aaXAxis = AAXAxis.new
    .visibleSet(true)
    .typeSet(@"category")
    .titleSet(AAAxisTitle.new
              .textSet(@"* 柱子宽度与 GDP 成正比"));
    
    AATooltip *aaTooltip = AATooltip.new
    .enabledSet(true)
    .pointFormatSet(@"人工成本： <b>€ {point.y}/h</b><br>' + 'GDP: <b>€ {point.z} 百万</b><br>");
    
    AALegend *aaLegend = AALegend.new
    .enabledSet(false);
    
    NSArray *seriesElementArr = @[
        AASeriesElement.new
        .nameSet(@"人工成本")
        .dataSet(AAOptionsData.variwideData)
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(true)
                       .formatSet(@"€{point.y:.0f}"))
        .colorByPointSet(@true)];
    
    AAOptions *aaOptions = AAOptions.new
    .chartSet(aaChart)
    .titleSet(aaTitle)
    .subtitleSet(aaSubtitle)
    .xAxisSet(aaXAxis)
    .tooltipSet(aaTooltip)
    .legendSet(aaLegend)
    .seriesSet(seriesElementArr);
    
    return aaOptions;
}

+ (AAOptions *)columnpyramidChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeColumnpyramid))
    .titleSet(AATitle.new
              .textSet(@"世界 5 大金字塔"))
    .xAxisSet(AAXAxis.new
              .visibleSet(true)
              .typeSet(AAChartAxisTypeCategory))
    .yAxisSet(AAYAxis.new
              .visibleSet(true)
              .titleSet(AAAxisTitle.new
                        .textSet(@"高度 (m)")))
    .tooltipSet(AATooltip.new
                .enabledSet(true)
                .valueSuffixSet(@" m"))
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"Height")
        .colorByPointSet(@true)
        .dataSet(AAOptionsData.columnpyramidData)
               ]);
}

+ (AAOptions *)dumbbellChart {
    AAChart *aaChart = AAChart.new
    .typeSet(AAChartTypeDumbbell)
    .invertedSet(true);
    
    AATitle *aaTitle = AATitle.new
    .textSet(@"各国预期寿命变化");
    
    AASubtitle *aaSubtitle = AASubtitle.new
    .textSet(@"1960 vs 2018");
    
    AAXAxis *aaXAxis = AAXAxis.new
    .visibleSet(true)
    .typeSet(AAChartAxisTypeCategory);
    
    AAYAxis *aaYAxis = AAYAxis.new
    .visibleSet(true)
    .titleSet(AAAxisTitle.new
              .textSet(@"Life Expectancy (years)"));
    
    AATooltip *aaTooltip = AATooltip.new
    .enabledSet(true);
    
    AALegend *aaLegend = AALegend.new
    .enabledSet(false);
    
    NSArray *seriesElementArr = @[
        AASeriesElement.new
        .nameSet(@"各国预期寿命变化")
        .dataSet(AAOptionsData.dumbbellData)
    ];
    
    AAOptions *aaOptions = AAOptions.new
    .chartSet(aaChart)
    .titleSet(aaTitle)
    .subtitleSet(aaSubtitle)
    .xAxisSet(aaXAxis)
    .yAxisSet(aaYAxis)
    .tooltipSet(aaTooltip)
    .legendSet(aaLegend)
    .seriesSet(seriesElementArr);
    
    return aaOptions;
}

+ (AAOptions *)lollipopChart {
    AAChart *aaChart = AAChart.new
    .typeSet(AAChartTypeLollipop);
    
    AATitle *aaTitle = AATitle.new
    .textSet(@"世界十大人口国家");
    
    AASubtitle *aaSubtitle = AASubtitle.new
    .textSet(@"2018");
    
    AAXAxis *aaXAxis = AAXAxis.new
    .visibleSet(true)
    .typeSet(AAChartAxisTypeCategory);
    
    AAYAxis *aaYAxis = AAYAxis.new
    .visibleSet(true)
    .titleSet(AAAxisTitle.new
              .textSet(@"人口"));
    
    AATooltip *aaTooltip = AATooltip.new
    .enabledSet(true);
    
    AALegend *aaLegend = AALegend.new
    .enabledSet(false);
    
    NSArray *seriesElementArr = @[
        AASeriesElement.new
        .nameSet(@"Population")
        .dataSet(AAOptionsData.lollipopData)
    ];
    
    AAOptions *aaOptions = AAOptions.new
    .chartSet(aaChart)
    .titleSet(aaTitle)
    .subtitleSet(aaSubtitle)
    .xAxisSet(aaXAxis)
    .yAxisSet(aaYAxis)
    .tooltipSet(aaTooltip)
    .legendSet(aaLegend)
    .seriesSet(seriesElementArr);
    
    return aaOptions;
}

+ (AAOptions *)xrangeChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeXrange))
    .colorsSet(@[
        @"#7cb5ec",@"#434348",@"#90ed7d",@"#f7a35c",@"#8085e9",
        @"rgb(255,143,179)",@"rgb(255,117,153)",
        @"#f15c80",@"#e4d354",@"#2b908f",@"#f45b5b",@"#91e8e1",@"#7cb5ec",@"#434348",@"#f7a35c",
        @"rgb(119,212,100)",@"rgb(93,186,74)",@"rgb(68,161,49)"
               ])
    .titleSet(AATitle.new
              .textSet(@""))
    .yAxisSet(AAYAxis.new
              .visibleSet(true)
              .titleSet(AAAxisTitle.new
                        .textSet(@""))
              .reversedSet(true)
              .categoriesSet(@[@"原型",@"开发",@"测试",@"上线"])
              .gridLineWidthSet(@0))
    .legendSet(AALegend.new
               .enabledSet(false))
    .plotOptionsSet(AAPlotOptions.new
                    .seriesSet(AASeries.new
                               .pointPaddingSet(@0)
                               .groupPaddingSet(@0)))
    .seriesSet(@[
        AASeriesElement.new
        .borderRadiusSet(@2)
        .dataSet(AAOptionsData.xrangeData)
               ]);
}

+ (AAOptions *)histogramChart {
    return AAOptions.new
        .titleSet(AATitle.new
            .textSet(@"AAChartKit-Pro Histogram"))
        .xAxisSet((id)@[
            AAXAxis.new
                .titleSet(AAAxisTitle.new
                    .textSet(@"Data")),
            AAXAxis.new
                .titleSet(AAAxisTitle.new
                    .textSet(@"Histogram"))
                .oppositeSet(true)
            ])
        .yAxisSet((id)@[
            AAYAxis.new
                .titleSet(AAAxisTitle.new
                    .textSet(@"Data")),
            AAYAxis.new
                .titleSet(AAAxisTitle.new
                    .textSet(@"Histogram"))
                .oppositeSet(true)
            ])
        .seriesSet(@[
            AASeriesElement.new
                .nameSet(@"Histogram")
                .typeSet(AAChartTypeHistogram)
                .xAxisSet(@1)
                .yAxisSet(@1)
                .baseSeriesSet((id)@"s1")
                .zIndexSet(@-1),
            AASeriesElement.new
                .nameSet(@"Data")
                .typeSet(AAChartTypeScatter)
                .dataSet(@[@3.5, @3, @3.2, @3.1, @3.6, @3.9, @3.4, @3.4, @2.9, @3.1, @3.7, @3.4, @3, @3, @4, @4.4, @3.9, @3.5, @3.8, @3.8, @3.4, @3.7, @3.6, @3.3, @3.4, @3, @3.4, @3.5, @3.4, @3.2, @3.1, @3.4, @4.1, @4.2, @3.1, @3.2, @3.5, @3.6, @3, @3.4, @3.5, @2.3, @3.2, @3.5, @3.8, @3, @3.8, @3.2, @3.7, @3.3, @3.2, @3.2, @3.1, @2.3, @2.8, @2.8, @3.3, @2.4, @2.9, @2.7, @2, @3, @2.2, @2.9, @2.9, @3.1, @3, @2.7, @2.2, @2.5, @3.2, @2.8, @2.5, @2.8, @2.9, @3, @2.8, @3, @2.9, @2.6, @2.4, @2.4, @2.7, @2.7, @3, @3.4, @3.1, @2.3, @3, @2.5, @2.6, @3, @2.6, @2.3, @2.7, @3, @2.9, @2.9, @2.5, @2.8, @3.3, @2.7, @3, @2.9, @3, @3, @2.5, @2.9, @2.5, @3.6, @3.2, @2.7, @3, @2.5, @2.8, @3.2, @3, @3.8, @2.6, @2.2, @3.2, @2.8, @2.8, @2.7, @3.3, @3.2, @2.8, @3, @2.8, @3, @2.8, @3.8, @2.8, @2.8, @2.6, @3, @3.4, @3.1, @3, @3.1, @3.1, @3.1, @2.7, @3.2, @3.3, @3, @2.5, @3, @3.4, @3])
                .idSet(@"s1")
                .markerSet(AAMarker.new
                    .radiusSet(@1.5))
            ]);
}

+ (AAOptions *)bellcurveChart {
    AAOptions *aaOptions = [self histogramChart];
    
    aaOptions.title.text = @"AAChartKit-Pro Bellcurve";
    
    NSArray *xAxisArr = (id)aaOptions.xAxis;
    AAXAxis *aaXAxis = xAxisArr[1];
    aaXAxis.title.text = @"Bellcurve";
    
    NSArray *yAxisArr = (id)aaOptions.yAxis;
    AAYAxis *aaYAxis = yAxisArr[1];
    aaYAxis.title.text = @"Bellcurve";
    
    AASeriesElement *aaSeriesElement = aaOptions.series.firstObject;
    aaSeriesElement
        .nameSet(@"Bellcurve")
        .typeSet(AAChartTypeBellcurve)
        ;
    return aaOptions;
}

@end
