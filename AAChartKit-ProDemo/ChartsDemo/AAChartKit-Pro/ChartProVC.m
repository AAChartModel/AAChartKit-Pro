
//  SpecialChartVC.m
//  AAChartKit
//
//  Created by An An on 17/3/23.
//  Copyright © 2017年 An An. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

/*
 
 * -------------------------------------------------------------------------------
 *
 * 🌕 🌖 🌗 🌘  ❀❀❀   WARM TIPS!!!   ❀❀❀ 🌑 🌒 🌓 🌔
 *
 * Please contact me on GitHub,if there are any problems encountered in use.
 * GitHub Issues : https://github.com/AAChartModel/AAChartKit/issues
 * -------------------------------------------------------------------------------
 * And if you want to contribute for this project, please contact me as well
 * GitHub        : https://github.com/AAChartModel
 * StackOverflow : https://stackoverflow.com/users/7842508/codeforu
 * JianShu       : http://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 * -------------------------------------------------------------------------------
 
 */

#import "ChartProVC.h"
#import "AAOptionsData.h"
#import "AAOptionsSeries.h"

@interface ChartProVC ()

@end

@implementation ChartProVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// https://www.highcharts.com/demo
- (id)chartConfigurationWithSelectedIndex:(NSUInteger)selectedIndex {
    switch (self.selectedIndex) {
        case 0: return [self sankeyChart];
        case 1: return [self variablepieChart];
        case 2: return [self treemapWithLevelsData];
        case 3: return [self variwideChart];
        case 4: return [self sunburstChart];
        case 5: return [self dependencywheelChart];
        case 6: return [self heatmapChart];
        case 7: return [self packedbubbleChart];
        case 8: return [self packedbubbleSplitChart];
        case 9: return [self vennChart];
        case 10: return [self dumbbellChart];
        case 11: return [self lollipopChart];
        case 12: return [self streamgraphChart];
        case 13: return [self columnpyramidChart];
        case 14: return [self tilemapChart];
        case 15: return [self treemapWithColorAxisData];
        case 16: return [self drilldownTreemapChart];
        case 17: return [self xrangeChart];
        case 18: return [self vectorChart];
        case 19: return [self bellcurveChart];
        case 20: return [self timelineChart];
        case 21: return [self itemChart];
        case 22: return [self windbarbChart];
        case 23: return [self networkgraphChart];
        case 24: return [self wordcloudChart];
        case 25: return [self eulerChart];
    }
    return nil;
}


- (AAOptions *)sankeyChart {
    return AAOptions.new
    .titleSet(AATitle.new
              .textSet(@"AAChartKit-Pro 桑基图"))
    .colorsSet(@[
        @"rgb(137,78,36)",
        @"rgb(220,36,30)",
        @"rgb(255,206,0)",
        @"rgb(1,114,41)",
        @"rgb(0,175,173)",
        @"rgb(215,153,175)",
        @"rgb(106,114,120)",
        @"rgb(114,17,84)",
        @"rgb(0,0,0)",
        @"rgb(0,24,168)",
        @"rgb(0,160,226)",
        @"rgb(106,187,170)"
               ])
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeSankey)
        .keysSet(@[@"from", @"to", @"weight"])
        .dataSet(AAOptionsData.sankeyData),
               ]);
}

- (AAOptions *)variablepieChart {
    AAChart *aaChart = AAChart.new
    .typeSet(AAChartTypeVariablepie);
    
    AATitle *aaTitle = AATitle.new
    .textSet(@"不同国家人口密度及面积对比");
    
    AASubtitle *aaSubtitle = AASubtitle.new
    .textSet(@"扇区长度（圆周方法）表示面积，宽度（纵向）表示人口密度");
    
    AATooltip *aaTooltip = AATooltip.new
    .enabledSet(true)
    .headerFormatSet(@"")
    .pointFormatSet(@"<span style=""color:{point.color}"">\u25CF</span> <b> {point.name}</b><br/>""面积 (平方千米): <b>{point.y}</b><br/>""人口密度 (每平方千米人数): <b>{point.z}</b><br/>""");
    
    AAOptions *aaOptions = AAOptions.new
    .chartSet(aaChart)
    .titleSet(aaTitle)
    .subtitleSet(aaSubtitle)
    .tooltipSet(aaTooltip)
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"countries")
        .innerSizeSet(@"20%")
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(false))
        .dataSet(AAOptionsData.variablepieData)
               ]);
    
    return aaOptions;
}

- (AAOptions *)treemapWithLevelsData {
    return AAOptions.new
    .titleSet(AATitle.new
              .textSet(@"Fruit Consumption Situation"))
    .legendSet(AALegend.new
               .enabledSet(false))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeTreemap)
        .levelsSet(@[
            AALevels.new
            .levelSet(@1)
            .layoutAlgorithmSet(@"sliceAndDice")
            .dataLabelsSet(AADataLabels.new
                           .enabledSet(true)
                           .alignSet(AAChartAlignTypeLeft)
                           .verticalAlignSet(AAChartVerticalAlignTypeTop)
                           .styleSet(AAStyle.new
                                     .fontSizeSet(@"15 px")
                                     .fontWeightSet(AAChartFontWeightTypeBold)))
                   ])
        .dataSet(AAOptionsData.treemapWithLevelsData)]);
}

- (AAOptions *)variwideChart {
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
        .colorByPointSet((id)@(true))];
    
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

- (AAOptions *)sunburstChart {
    AAChart *aaChart = AAChart.new
    .typeSet(AAChartTypeSunburst);
    
    AATitle *aaTitle = AATitle.new
    .textSet(@"2017 世界人口分布");
    
    AASubtitle *aaSubtitle = AASubtitle.new
    .textSet(@"数据来源:<href=""https://en.wikipedia.org/wiki/List_of_countries_by_population_(United_Nations)"">Wikipedia</a>");
    
    AATooltip *aaTooltip = AATooltip.new
    .enabledSet(true)
    .pointFormatSet(@"<b>{point.name}</b>的人口数量是：<b>{point.value}</b>");
    
    AALegend *aaLegend = AALegend.new
    .enabledSet(false);
    
    NSArray *seriesElementArr = @[
        AASeriesElement.new
        .allowDrillToNodeSet(true)
        .levelsSet(@[
            AALevels.new
            .levelSet(@2)
            .colorByPointSet(@true)
            .layoutAlgorithmSet(@"sliceAndDice")
            ,
            AALevels.new
            .levelSet(@3)
            .colorVariationSet(AAColorVariation.new
                               .keySet(@"brightness")
                               .toSet(@-0.5))
            ,
            AALevels.new
            .levelSet(@4)
            .colorVariationSet(AAColorVariation.new
                               .keySet(@"brightness")
                               .toSet(@0.5))
            
                   ])
        .dataSet(AAOptionsData.sunburstData)
    ];
    
    AAOptions *aaOptions = AAOptions.new
    .chartSet(aaChart)
    .titleSet(aaTitle)
    .subtitleSet(aaSubtitle)
    .tooltipSet(aaTooltip)
    .legendSet(aaLegend)
    .seriesSet(seriesElementArr);
    
    return aaOptions;
}

- (AAOptions *)dependencywheelChart {
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

// https://jshare.com.cn/demos/hhhhiz
- (AAOptions *)heatmapChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeHeatmap))
    .titleSet(AATitle.new
              .textSet(@"Sales per employee per weekday"))
    .xAxisSet(AAXAxis.new
              .visibleSet(true)
              .categoriesSet(@[
                  @"Alexander", @"Marie", @"Maximilian", @"Sophia",
                  @"Lukas", @"Maria", @"Leon", @"Anna", @"Tim", @"Laura"
                             ]))
    .yAxisSet(AAYAxis.new
              .visibleSet(true)
              .categoriesSet(@[@"Monday", @"Tuesday", @"Wednesday", @"Thursday", @"Friday"])
              .titleSet(AAAxisTitle.new
                        .textSet(@"")))
    .colorAxisSet(AAColorAxis.new
                  .minSet(@0)
                  .minColorSet(@"#FFFFFF")
                  .maxColorSet(@"#7cb5ec"))
    .legendSet(AALegend.new
               .enabledSet(true)
               .alignSet(AAChartAlignTypeRight)
               .layoutSet(@"vertical")
               .verticalAlignSet(@"top")
               .ySet(@25))
    .tooltipSet(AATooltip.new
                .enabledSet(true)
                .formatterSet(@AAJSFunc(function () {
                    return '<b>' + this.series.xAxis.categories[this.point.x] + '</b> sold <br><b>' +
                        this.point.value + '</b> items on <br><b>' + this.series.yAxis.categories[this.point.y] + '</b>';
                })))
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"Sales")
        .borderWidthSet(@1)
        .dataSet(AAOptionsData.heatmapData)
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(true)
                       .colorSet(@"red"))
               ]);
}


// https://www.highcharts.com.cn/demo/highcharts/packed-bubble
- (AAOptions *)packedbubbleChart {
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

// https://www.highcharts.com.cn/demo/highcharts/packed-bubble-split
- (AAOptions *)packedbubbleSplitChart {
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


- (AAOptions *)vennChart {
    return AAOptions.new
    .titleSet(AATitle.new
              .textSet(@"The Unattainable Triangle"))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeVenn)
        .dataSet(AAOptionsData.vennData)]);
}

- (AAOptions *)dumbbellChart {
    AAChart *aaChart = AAChart.new
    .typeSet(AAChartTypeDumbbell)
    .invertedSet(true);
    
    AATitle *aaTitle = AATitle.new
    .textSet(@"各国预期寿命变化");
    
    AASubtitle *aaSubtitle = AASubtitle.new
    .textSet(@"1960 vs 2018");
    
    AAXAxis *aaXAxis = AAXAxis.new
    .visibleSet(true)
    .typeSet(@"category");
    
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

- (AAOptions *)lollipopChart {
    AAChart *aaChart = AAChart.new
    .typeSet(AAChartTypeLollipop);
    
    AATitle *aaTitle = AATitle.new
    .textSet(@"世界十大人口国家");
    
    AASubtitle *aaSubtitle = AASubtitle.new
    .textSet(@"2018");
    
    AAXAxis *aaXAxis = AAXAxis.new
    .visibleSet(true)
    .typeSet(@"category");
    
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

- (AAOptions *)streamgraphChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeStreamgraph))
    .colorsSet(@[
        @"#7cb5ec",@"#434348",@"#90ed7d",@"#f7a35c",@"#8085e9",
        @"rgb(255,143,179)",@"rgb(255,117,153)",
        @"#f15c80",@"#e4d354",@"#2b908f",@"#f45b5b",@"#91e8e1",@"#7cb5ec",@"#434348",@"#f7a35c",
        @"rgb(119,212,100)",@"rgb(93,186,74)",@"rgb(68,161,49)"
               ])
    .titleSet(AATitle.new
              .textSet(@"冬季奥运会奖牌分布"))
    .subtitleSet(AASubtitle.new
                 .textSet(@"1924-2014"))
    .xAxisSet(AAXAxis.new
              .visibleSet(true)
              .typeSet(@"category")
              .categoriesSet(@[
                  @"", @"1924", @"1928", @"1932", @"1936", @"1940", @"1944", @"1948", @"1952", @"1956", @"1960",
                  @"1964", @"1968", @"1972", @"1976", @"1980", @"1984", @"1988", @"1992", @"1994", @"1998",
                  @"2002", @"2006", @"2010", @"2014"
                             ]))
    .yAxisSet(AAYAxis.new
              .visibleSet(false))
    .tooltipSet(AATooltip.new
                .enabledSet(true))
    .legendSet(AALegend.new
               .enabledSet(false))
    .seriesSet(AAOptionsSeries.streamgraphSeries);
}

- (AAOptions *)columnpyramidChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeColumnpyramid))
    .titleSet(AATitle.new
              .textSet(@"世界 5 大金字塔"))
    .xAxisSet(AAXAxis.new
              .visibleSet(true)
              .typeSet(@"category"))
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

- (AAOptions *)tilemapChart {
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
                      AADataClasses.new
                      .fromSet(@0)
                      .toSet(@1000000)
                      .colorSet(@"#F9EDB3")
                      .nameSet(@"< 1M"),
                      AADataClasses.new
                      .fromSet(@1000000)
                      .toSet(@5000000)
                      .colorSet(@"#FFC428")
                      .nameSet(@"1M - 5M"),
                      AADataClasses.new
                      .fromSet(@5000000)
                      .toSet(@20000000)
                      .colorSet(@"#F9EDB3")
                      .nameSet(@"5M - 20M"),
                      AADataClasses.new
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
                                              .colorSet(@"#ffffff")
                                              .styleSet(AAStyle.new
                                                        .textOutlineSet(@"none")))))
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"Height")
        .colorByPointSet(@true)
        .dataSet(AAOptionsData.tilemapData)
               ]);
}

- (AAOptions *)treemapWithColorAxisData {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeTreemap))
    .titleSet(AATitle.new
              .textSet(@"矩形树图"))
    .colorAxisSet(AAColorAxis.new
                  .minColorSet(@"#FFFFFF")
                  .maxColorSet(@"#FF0000"))
    .seriesSet(@[
        AASeriesElement.new
        .dataSet(AAOptionsData.treemapWithColorAxisData)
               ]);
}

- (AAOptions *)drilldownTreemapChart {
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
            AALevels.new
            .levelSet(@1)
            .dataLabelsSet(AADataLabels.new
                           .enabledSet(true))
            .borderWidthSet(@3)
                   ])
        .dataSet(AAOptionsData.drilldownTreemapData)
               ]);
}

- (AAOptions *)xrangeChart {
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

- (AAOptions *)vectorChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeVector))
    .colorsSet(@[@"red"])
    .titleSet(AATitle.new
              .textSet(@"AAChartKit-Pro Vector plot"))
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"Sample vector field")
        .dataSet(AAOptionsData.vectorData)
               ]);
}

- (AAOptions *)bellcurveChart {
    return AAOptions.new
    .titleSet(AATitle.new
              .textSet(@"Bell curve"))
    .xAxisSet((id)@[
        AATitle.new
        .textSet(@"Data"),
        AATitle.new
        .textSet(@"Bell curve")
                  ])
    .yAxisSet((id)@[
        AATitle.new
        .textSet(@"Data"),
        AATitle.new
        .textSet(@"Bell curve")
                  ])
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"Bell curve")
        .typeSet(AAChartTypeBellcurve)
        .xAxisSet(@1)
        .yAxisSet(@1)
        .baseSeriesSet(@1)
        .zIndexSet(@-1)
        ,
        AASeriesElement.new
        .nameSet(@"Data")
        .typeSet(AAChartTypeScatter)
        .markerSet(AAMarker.new
                   .fillColorSet(@"#ffffff")//点的填充色(用来设置折线连接点的填充色)
                   .lineWidthSet(@2)//外沿线的宽度(用来设置折线连接点的轮廓描边的宽度)
                   .lineColorSet(@""))//外沿线的颜色(用来设置折线连接点的轮廓描边颜色，当值为空字符串时，默认取数据点或数据列的颜色))
        .dataSet(AAOptionsData.bellcurveData)
               ]);
}

- (AAOptions *)timelineChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeTimeline))
    .titleSet(AATitle.new
              .textSet(@"人类太空探索时间表"))
    .subtitleSet(AASubtitle.new
                 .textSet(@"数据来源: https://en.wikipedia.org/wiki/Timeline_of_space_exploration"))
    .yAxisSet(AAYAxis.new
              .visibleSet(false))
    .seriesSet(@[
        AASeriesElement.new
        .dataSet(AAOptionsData.timelineData)
               ]);
}

- (AAOptions *)itemChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeItem))
    .titleSet(AATitle.new
              .textSet(@"AAChartKit-Pro item chart"))
    .subtitleSet(AASubtitle.new
                 .textSet(@"Parliament visualization"))
    .legendSet(AALegend.new
               .enabledSet(false))
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"Representatives")
        .keysSet(@[@"name",@"y",@"color",@"label"])
        .dataSet(AAOptionsData.itemData)
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(false))
        .sizeSet((id)@"170%")
               ]);
}

- (AAOptions *)windbarbChart {
    return AAOptions.new
    .titleSet(AATitle.new
              .textSet(@"AAChartKit-Pro Wind Barbst"))
    .xAxisSet(AAXAxis.new
              .offsetSet(@40))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeWindbarb)
        .nameSet(@"Wind")
        .dataSet(AAOptionsData.windbarbData),
        AASeriesElement.new
        .typeSet(AAChartTypeArea)
        .nameSet(@"Wind speed")
        .dataSet(AAOptionsData.windbarbData)
        .keysSet(@[@"y"])
        .markerSet(AAMarker.new
                   .fillColorSet(@"#ffffff")//点的填充色(用来设置折线连接点的填充色)
                   .lineWidthSet(@5)//外沿线的宽度(用来设置折线连接点的轮廓描边的宽度)
                   .lineColorSet(@""))//外沿线的颜色(用来设置折线连接点的轮廓描边颜色，当值为空字符串时，默认取数据点或数据列的颜色))
               ]);
}

- (AAOptions *)networkgraphChart {
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

- (AAOptions *)wordcloudChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeWordcloud))
    .titleSet(AATitle.new
              .textSet(@"词云图"))
    .seriesSet(@[
        AASeriesElement.new
        .dataSet(AAOptionsData.wordcloudData),
               ]);
}

- (AAOptions *)eulerChart {
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

@end
