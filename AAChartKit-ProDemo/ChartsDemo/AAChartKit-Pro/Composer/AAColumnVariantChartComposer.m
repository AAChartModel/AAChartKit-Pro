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

//Highcharts.chart('container', {
//    chart: {
//        type: 'pictorial'
//    },
//
//    colors: ['#B0FDFE', '#E3FED4', '#F9F492', '#FAF269', '#FAE146', '#FDA003'],
//
//    title: {
//        text: 'Kelvin color temperature scale chart'
//    },
//
//    subtitle: {
//        text: 'Source: ' +
//          '<a href="https://en.wikipedia.org/wiki/Color_temperature"' +
//          'target="_blank">Wikipedia.org</a> '
//    },
//
//
//    xAxis: {
//        visible: false,
//        min: 0.2
//    },
//
//    yAxis: {
//        visible: false
//    },
//
//    legend: {
//        align: 'right',
//        floating: true,
//        itemMarginTop: 5,
//        itemMarginBottom: 5,
//        layout: 'vertical',
//        margin: 0,
//        padding: 0,
//        verticalAlign: 'middle'
//    },
//
//    tooltip: {
//        headerFormat: '',
//        valueSuffix: ' K'
//    },
//
//    plotOptions: {
//        series: {
//            pointPadding: 0,
//            groupPadding: 0,
//            borderWidth: 0,
//            dataLabels: {
//                enabled: true,
//                align: 'center',
//                format: '{y} K'
//            },
//            stacking: 'percent',
//            paths: [{
//            }]
//        }
//    },
//
//    series: [{
//        name: 'Daylight',
//        data: [6500]
//    }, {
//        name: 'Moonlight',
//        data: [4000]
//    },
//    {
//        name: 'Morning/Evening Sun',
//        data: [3500]
//    },
//    {
//        name: 'Lightbulb',
//        data: [3000]
//    },
//    {
//        name: 'Sunrise/sunset',
//        data: [2500]
//    },
//    {
//        name: 'Candle flame',
//        data: [1800]
//    }
//    ]
//});

//Kelvin color temperature scale chart
+ (AAOptions *)pictorial1Chart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypePictorial))
    .colorsSet(@[@"#B0FDFE", @"#E3FED4", @"#F9F492", @"#FAF269", @"#FAE146", @"#FDA003"])
    .titleSet(AATitle.new
              .textSet(@"Kelvin color temperature scale chart"))
    .subtitleSet(AASubtitle.new
                 .textSet(@"Source: <a href='https://en.wikipedia.org/wiki/Color_temperature' target='_blank'>Wikipedia.org</a> "))
    .xAxisSet(AAXAxis.new
                .visibleSet(true)
                .minSet(@0.2))
    .yAxisSet(AAYAxis.new
                .visibleSet(true))
    .legendSet(AALegend.new
                .alignSet(AAChartAlignTypeRight)
                .floatingSet(true)
                .itemMarginTopSet(@5)
                .itemMarginBottomSet(@5)
                .layoutSet(AAChartLayoutTypeVertical)
//                .marginSet(@0)
//                .paddingSet(@0)
                .verticalAlignSet(AAChartVerticalAlignTypeMiddle))
    .tooltipSet(AATooltip.new
                .headerFormatSet(@"")
                .valueSuffixSet(@" K"))
            .plotOptionsSet(AAPlotOptions.new
            .seriesSet(AASeries.new
                    .pointPaddingSet(@0)
                    .groupPaddingSet(@0)
                    .borderWidthSet(@0)
                    .dataLabelsSet(AADataLabels.new
                            .enabledSet(true)
                            .alignSet(AAChartAlignTypeCenter)
                            .formatSet(@"{y} K")
                    )
                    .stackingSet(AAChartStackingTypePercent)
            ))
            .seriesSet(AAOptionsSeries.pictorial2Series);
}

//Highcharts.chart('container', {
//    chart: {
//        type: 'pictorial'
//    },
//
//    title: {
//        text: 'Composition of the human body'
//    },
//
//    xAxis: {
//        categories: ['Woman', 'Man'],
//        lineWidth: 0,
//        opposite: true
//    },
//
//    yAxis: {
//        visible: false,
//        stackShadow: {
//            enabled: true
//        },
//        max: 100
//    },
//
//    legend: {
//        itemMarginTop: 15,
//        itemMarginBottom: 15,
//        layout: 'vertical',
//        padding: 0,
//        verticalAlign: 'middle',
//        align: 'center',
//        margin: 0
//    },
//
//    tooltip: {
//        headerFormat: ''
//    },
//
//    plotOptions: {
//        series: {
//            pointPadding: 0,
//            groupPadding: 0,
//            dataLabels: {
//                enabled: true,
//                align: 'center',
//                format: '{y} %'
//            },
//            stacking: 'normal',
//            paths: [{
//
//            }]
//        }
//    },
//
//    series: [{
//        name: 'Other',
//        data: [25, 25]
//    }, {
//        name: 'Essential Fat',
//        data: [12, 3]
//    },
//    {
//        name: 'Non-Essential Fat',
//        data: [15, 12]
//    }, {
//        name: 'Muscle Tissue',
//        data: [36, 45]
//    },
//    {
//        name: 'Bone',
//        data: [12, 15]
//    }
//    ],
//
//
//});

//将以上 json 内容转化为 AAOptions 实例对象
+ (AAOptions *)pictorial2Chart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypePictorial))
    .titleSet(AATitle.new
            .textSet(@"Composition of the human body"))
            .xAxisSet(AAXAxis.new
                    .categoriesSet(@[@"Woman", @"Man"])
                    .lineWidthSet(@0)
                    .oppositeSet(@YES))
    .yAxisSet(AAYAxis.new
                .visibleSet(false)
//                .stackShadowSet(AAStackingShadow.new
//                                .enabledSet(true))
                .maxSet(@100))
    .legendSet(AALegend.new
                .itemMarginTopSet(@15)
                .itemMarginBottomSet(@15)
                .layoutSet(AAChartLayoutTypeVertical)
//                .paddingSet(@0)
                .verticalAlignSet(AAChartVerticalAlignTypeMiddle)
                .alignSet(AAChartAlignTypeCenter)
//                .marginSet(@0)
    )
            .tooltipSet(AATooltip.new
                    .headerFormatSet(@""))
    .plotOptionsSet(AAPlotOptions.new
                    .seriesSet(AASeries.new
                            .pointPaddingSet(@0)
                            .groupPaddingSet(@0)
                            .dataLabelsSet(AADataLabels.new
                                    .enabledSet(true)
                                    .alignSet(AAChartAlignTypeCenter)
                                    .formatSet(@"{y} %"))
                            .stackingSet(AAChartStackingTypeNormal)
//                            .pathsSet(@[
//                            ])
                    ))
    .seriesSet(AAOptionsSeries.pictorial2Series);

}

@end
