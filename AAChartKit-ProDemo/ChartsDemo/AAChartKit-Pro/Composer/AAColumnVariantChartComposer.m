//
//  AAColumnVariantChartComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import "AAColumnVariantChartComposer.h"
#import "AAChartKit-Pro.h"
#import "AAOptionsData.h"
#import "AAOptionsSeries.h"

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
                .dataSet(AAOptionsData.bellcurveData)
                .idSet(@"s1")
                .markerSet(AAMarker.new
                           .fillColorSet(AAColor.whiteColor)//点的填充色(用来设置折线连接点的填充色)
                           .lineWidthSet(@2)//外沿线的宽度(用来设置折线连接点的轮廓描边的宽度)
                           .lineColorSet(@""))//外沿线的颜色(用来设置折线连接点的轮廓描边颜色，当值为空字符串时，默认取数据点或数据列的颜色))
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

+ (AAOptions *)bulletChart {
   return AAOptions.new
        .chartSet(AAChart.new
            .marginTopSet(@40)
            .invertedSet(true)
//            .marginLeftSet(@135)
            .heightSet(@200)
            .typeSet(AAChartTypeBullet))
        .titleSet(AATitle.new
            .textSet(@"2017 年公司运营情况"))
        .xAxisSet(AAXAxis.new
            .categoriesSet(@[@"<span style=color:#ff0000;font-weight:bold;font-size:13px>营收</span><br/>千美元", ]))
        .yAxisSet(AAYAxis.new
            .gridLineWidthSet(@0)
            .plotBandsSet(@[
                AAPlotBandsElement.new
                    .fromSet(@0)
                    .toSet(@150)
                    .colorSet(@"#666"),
                AAPlotBandsElement.new
                    .fromSet(@150)
                    .toSet(@225)
                    .colorSet(@"#999"),
                AAPlotBandsElement.new
                    .fromSet(@225)
                    .toSet(@9000000000)
                    .colorSet(@"#bbb")
                ])
            .titleSet((id)NSNull.new))
        .plotOptionsSet(AAPlotOptions.new
            .seriesSet(AASeries.new
                .pointPaddingSet(@0.25)
                .borderWidthSet(@0)
//                .colorSet(@"#000")
//                .targetOptionsSet(AATargetOptions.new
//                    .widthSet(@"200%"))
                       ))
        .legendSet(AALegend.new
            .enabledSet(false))
        .seriesSet(@[
            AASeriesElement.new
                .dataSet(@[
                    AABulletDataElement.new
                        .ySet(@275)
                        .targetSet(@250)
                    ])
            ])
        .tooltipSet(AATooltip.new
            .pointFormatSet(@"{point.y} （目标值 {point.target}）"));
}

@end
