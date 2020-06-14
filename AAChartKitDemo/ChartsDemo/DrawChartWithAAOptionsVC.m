
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

#import "DrawChartWithAAOptionsVC.h"
#import "AAOptionsData.h"
#import "AAChartKit.h"

#import "AADateUTCTool.h"
#import "AAOptionsSeries.h"
#define AAJSFunc(x) #x

@interface DrawChartWithAAOptionsVC ()

@end

@implementation DrawChartWithAAOptionsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = self.navigationItemTitle;
    
    AAChartView *aaChartView =[[AAChartView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    aaChartView.contentHeight = aaChartView.frame.size.height-80;
    aaChartView.isClearBackgroundColor = YES;
    [self.view addSubview:aaChartView];
    aaChartView.scrollEnabled = NO;
    
    AAOptions *aaOptions = [self configureChartOptions];
    [aaChartView aa_drawChartWithOptions:aaOptions];
}

- (AAOptions *)configureChartOptions {
    switch (self.selectedIndex) {
        case 0: return [self sankeyChart];
        case 1: return [self variablepieChart];
        case 2: return [self treemapChart];
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
        case 15: return [self simpleTreemapChart];
        case 16: return [self drilldownTreemapChart];
        case 17: return [self xrangeChart];
            //        case 15: return [self customChartLengendItemStyle];//自定义图表的 legend 图例样式
            
    }
    return nil;
}


- (AAOptions *)sankeyChart {
    return AAOptions.new
    .titleSet(AATitle.new
              .textSet(@"AAChartKit-Pro 桑基图"))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeSankey)
        .keysSet(@[@"from", @"to", @"weight"])
        .dataSet(AAOptionsData.sankeyChartData),
               ])
    ;
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
    
    NSArray *seriesElementArr = @[
        AASeriesElement.new
        .nameSet(@"countries")
        .innerSizeSet(@"20%")
        .dataSet(@[
            AASeriesDataElement.new
            .nameSet(@"西班牙")
            .ySet(@505370)
            .zSet(@92.9),
            AASeriesDataElement.new
            .nameSet(@"波兰")
            .ySet(@312685)
            .zSet(@124.6),
            AASeriesDataElement.new
            .nameSet(@"捷克共和国")
            .ySet(@78867)
            .zSet(@137.5),
            AASeriesDataElement.new
            .nameSet(@"意大利")
            .ySet(@301340)
            .zSet(@201.8),
            AASeriesDataElement.new
            .nameSet(@"瑞士")
            .ySet(@41277)
            .zSet(@214.5),
            AASeriesDataElement.new
            .nameSet(@"德国")
            .ySet(@357022)
            .zSet(@235.6),
                 ])
    ];
    
    AAOptions *aaOptionsQ = AAOptions.new
    .chartSet(aaChart)
    .titleSet(aaTitle)
    .subtitleSet(aaSubtitle)
    .tooltipSet(aaTooltip)
    .seriesSet(seriesElementArr);
    
    return aaOptionsQ;
  
}

- (AAOptions *)treemapChart {
    NSArray *seriesDataArr = @[
        AASeriesDataElement.new
        .idSet(@"A")
        .nameSet(@"Apple🍎")
        .colorSet(@"#EF2566"),
        AASeriesDataElement.new
        .idSet(@"B")
        .nameSet(@"Banana🍌")
        .colorSet(@"#EFE166"),
        AASeriesDataElement.new
        .idSet(@"O")
        .nameSet(@"Orange🍊")
        .colorSet(@"#EF9866"),
        AASeriesDataElement.new
        .nameSet(@"Angel Jill")
        .parentSet(@"A")
        .valueSet(@5),
        AASeriesDataElement.new
        .nameSet(@"Charles Bond")
        .parentSet(@"A")
        .valueSet(@3),
        AASeriesDataElement.new
        .nameSet(@"Babara Swift")
        .parentSet(@"A")
        .valueSet(@4),
        AASeriesDataElement.new
        .nameSet(@"Angel Jill")
        .parentSet(@"B")
        .valueSet(@4),
        AASeriesDataElement.new
        .nameSet(@"Charles Bond")
        .parentSet(@"B")
        .valueSet(@10),
        AASeriesDataElement.new
        .nameSet(@"Babara Swift")
        .parentSet(@"B")
        .valueSet(@1),
        AASeriesDataElement.new
        .nameSet(@"Angel Jill")
        .parentSet(@"O")
        .valueSet(@1),
        AASeriesDataElement.new
        .nameSet(@"Charles Bond")
        .parentSet(@"O")
        .valueSet(@3),
        AASeriesDataElement.new
        .nameSet(@"Babara Swift")
        .parentSet(@"O")
        .valueSet(@3),
        AASeriesDataElement.new
        .nameSet(@"阿苏")
        .parentSet(@"wiki")
        .valueSet(@2)
        .colorSet(@"#9EDE00"),
    ];
    
    AAOptions *aaOptions = AAOptions.new
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
                       .alignSet(AALegendAlignTypeLeft)
                       .verticalAlignSet(AALegendVerticalAlignTypeTop)
                       .styleSet(AAStyle.new
                                 .fontSizeSet(@"15 px")
                                 .fontWeightSet(AAChartFontWeightTypeBold)))
               ])
    .dataSet(seriesDataArr)]);
    
    return aaOptions;
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
    .titleSet(AATitle.new
              .textSet(@"* 柱子宽度与 GDP 成正比"));
    
    AATooltip *aaTooltip = AATooltip.new
    .enabledSet(true)
    .pointFormatSet(@"人工成本： <b>€ {point.y}/h</b><br>' + 'GDP: <b>€ {point.z} 百万</b><br>");
    
    AALegend *aaLegend = AALegend.new
    .enabledSet(false);
    
    NSArray *seriesElementArr = @[
        AASeriesElement.new
        .nameSet(@"人工成本")
        .dataSet(@[
            @[@"挪威", @50.2, @335504],
            @[@"丹麦", @42, @277339],
            @[@"比利时", @39.2, @421611],
            @[@"瑞典", @38, @462057],
            @[@"法国", @35.6, @2228857],
            @[@"荷兰", @34.3, @702641],
            @[@"芬兰", @33.2, @215615],
            @[@"德国", @33.0, @3144050],
            @[@"奥地利", @32.7, @349344],
            @[@"爱尔兰", @30.4, @275567],
            @[@"意大利", @27.8, @1672438],
            @[@"英国", @26.7, @2366911],
            @[@"西班牙", @21.3, @1113851],
            @[@"希腊", @14.2, @175887],
            @[@"葡萄牙", @13.7, @184933],
            @[@"捷克共和国", @10.2, @176564],
            @[@"波兰", @8.6, @424269],
            @[@"罗马尼亚", @5.5, @169578]
                 ])
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(true)
                       .formatSet(@"€{point.y:.0f}"))
        .colorByPointSet((id)@(true))];
    
    AAOptions *aaOptionsQ = AAOptions.new
    .chartSet(aaChart)
    .titleSet(aaTitle)
    .subtitleSet(aaSubtitle)
    .xAxisSet(aaXAxis)
    .tooltipSet(aaTooltip)
    .legendSet(aaLegend)
    .seriesSet(seriesElementArr);
    
    return aaOptionsQ;
    
}

- (AAOptions *)sunburstChart {
    AAChart *aaChart = AAChart.new
    .typeSet(@"variwide");
    
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
        .typeSet(AAChartTypeSunburst)
        .allowDrillToNodeSet(true)
        .levelsSet(@[
            AALevels.new
            .levelSet(@2)
            .colorByPointSet(@true)
            .layoutAlgorithmSet(@"sliceAndDice")
            .dataLabelsSet((id)@{
                    @"rotationMode": @"parallel"
            }),
            AALevels.new
            .levelSet(@3)
            .colorVariationSet(AAColorVariation.new
                               .keySet(@"brightness")
                               .toSet(@-0.5)),
            AALevels.new
            .levelSet(@4)
            .colorVariationSet(AAColorVariation.new
                               .keySet(@"brightness")
                               .toSet(@0.5))
            
        ])
        .dataSet(AAOptionsData.sunburstChartData)
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
        .dataSet(AAOptionsData.dependencywheelChartData)
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(true)
                       .colorSet(@"#333")
                       .textPathSet(@{
                           @"enabled": @true,
                           @"attributes": @{
                                   @"dy": @5
                           }
                                    })
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
              .titleSet(AATitle.new
                        .textSet(@"")))
    .colorAxisSet(AAColorAxis.new
                  .minSet(@0)
                  .minColorSet(@"#FFFFFF")
                  .maxColorSet(@"#7cb5ec"))
    .legendSet(AALegend.new
               .enabledSet(true)
               .alignSet(AAChartTitleAlignTypeRight)
               .layoutSet(@"vertical")
               .verticalAlignSet(@"top")
               .ySet(@25)
               )
    .tooltipSet(AATooltip.new
                .enabledSet(true)
//                .formatterSet(@AAJSFunc(function () {
//                    return '<b>' + this.series.xAxis.categories[this.point.x] + '</b> sold <br><b>' +
//                        this.point.value + '</b> items on <br><b>' + this.series.yAxis.categories[this.point.y] + '</b>';
//                }))
                )
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"Sales")
        .borderWidthSet(@1)
        .dataSet(@[
            @[@0, @0, @10], @[@0, @1, @19], @[@0, @2, @8], @[@0, @3, @24], @[@0, @4, @67], @[@1, @0, @92], @[@1, @1, @58], @[@1, @2, @78], @[@1, @3, @117],
            @[@1, @4, @48], @[@2, @0, @35], @[@2, @1, @15], @[@2, @2, @123], @[@2, @3, @64], @[@2, @4, @52], @[@3, @0, @72], @[@3, @1, @132], @[@3, @2, @114],
            @[@3, @3, @19], @[@3, @4, @16], @[@4, @0, @38], @[@4, @1, @5], @[@4, @2, @8], @[@4, @3, @117], @[@4, @4, @115], @[@5, @0, @88], @[@5, @1, @32],
            @[@5, @2, @12], @[@5, @3, @6], @[@5, @4, @120], @[@6, @0, @13], @[@6, @1, @44], @[@6, @2, @88], @[@6, @3, @98], @[@6, @4, @96], @[@7, @0, @31],
            @[@7, @1, @1], @[@7, @2, @82], @[@7, @3, @32], @[@7, @4, @30], @[@8, @0, @85], @[@8, @1, @97], @[@8, @2, @123], @[@8, @3, @64], @[@8, @4, @84],
            @[@9, @0, @47], @[@9, @1, @114], @[@9, @2, @31], @[@9, @3, @48], @[@9, @4, @91]
                 ])
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(true)
                       .colorSet(@"red")
                       )
               ])
    ;
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
                                     .layoutAlgorithmSet(AALayoutAlgorithm.new //只有layoutAlgorithm这一段不一样
                                                         .gravitationalConstantSet(@0.02)
                                                         .splitSeriesSet(@false)
                                                         )
                                     .dataLabelsSet(AADataLabels.new
                                                    .enabledSet(true)
                                                    .formatSet(@"{point.name}")
                                                    .filterSet(@{
                                                        @"property": @"y",
                                                        @"operator": @">",
                                                        @"value": @250
                                                               })
                                                    )))
    .seriesSet(AAOptionsSeries.packedbubbleChartSeries)
    ;
    
    
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
                                     .layoutAlgorithmSet(AALayoutAlgorithm.new //只有layoutAlgorithm这一段不一样
                                                         .gravitationalConstantSet(@0.05)
                                                         .splitSeriesSet(@true)
                                                         .seriesInteractionSet(@false)
                                                         .dragBetweenSeriesSet(@true)
                                                         .parentNodeLimitSet(@true))
                                     .dataLabelsSet(AADataLabels.new
                                                    .enabledSet(true)
                                                    .formatSet(@"{point.name}")
                                                    .filterSet(@{
                                                        @"property": @"y",
                                                        @"operator": @">",
                                                        @"value": @250
                                                               })
                                                    )))
    .seriesSet(AAOptionsSeries.packedbubbleChartSeries)
    ;
}


- (AAOptions *)vennChart {
    return AAOptions.new
    .titleSet(AATitle.new
              .textSet(@"The Unattainable Triangle"))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeVenn)
        .dataSet(AAOptionsData.vennChartData)])
    ;
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
    .typeSet(@"category")
    ;
    
    AAYAxis *aaYAxis = AAYAxis.new
    .visibleSet(true)
    .titleSet(AATitle.new
              .textSet(@"Life Expectancy (years)"))
    ;
    
    AATooltip *aaTooltip = AATooltip.new
    .enabledSet(true)
    ;
    
    AALegend *aaLegend = AALegend.new
    .enabledSet(false);
    
    NSArray *seriesElementArr = @[
        AASeriesElement.new
        .nameSet(@"各国预期寿命变化")
        .dataSet(AAOptionsData.dumbbellChartData)
    ];
    
    AAOptions *aaOptionsQ = AAOptions.new
    .chartSet(aaChart)
    .titleSet(aaTitle)
    .subtitleSet(aaSubtitle)
    .xAxisSet(aaXAxis)
    .yAxisSet(aaYAxis)
    .tooltipSet(aaTooltip)
    .legendSet(aaLegend)
    .seriesSet(seriesElementArr);
    
    return aaOptionsQ;
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
    .typeSet(@"category")
    ;
    
    AAYAxis *aaYAxis = AAYAxis.new
    .visibleSet(true)
    .titleSet(AATitle.new
              .textSet(@"人口"))
    ;
    
    AATooltip *aaTooltip = AATooltip.new
    .enabledSet(true)
    ;
    
    AALegend *aaLegend = AALegend.new
    .enabledSet(false);
    
    NSArray *seriesElementArr = @[
        AASeriesElement.new
        .nameSet(@"Population")
        .dataSet(AAOptionsData.lollipopChartData)
    ];
    
    AAOptions *aaOptionsQ = AAOptions.new
    .chartSet(aaChart)
    .titleSet(aaTitle)
    .subtitleSet(aaSubtitle)
    .xAxisSet(aaXAxis)
    .yAxisSet(aaYAxis)
    .tooltipSet(aaTooltip)
    .legendSet(aaLegend)
    .seriesSet(seriesElementArr);
    
    return aaOptionsQ;
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
    .seriesSet(AAOptionsSeries.streamgraphChartSeries);
}

- (AAOptions *)columnpyramidChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeColumnpyramid))
    .titleSet(AATitle.new
              .textSet(@"世界 5 大金字塔"))
    .xAxisSet(AAXAxis.new
              .visibleSet(true)
              .typeSet(@"category")
              )
    .yAxisSet(AAYAxis.new
              .visibleSet(true)
              .titleSet(AATitle.new
                        .textSet(@"高度 (m)")))
    .tooltipSet(AATooltip.new
                .enabledSet(true)
                .valueSuffixSet(@" m")
                )
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"Height")
        .colorByPointSet(@true)
        .dataSet(@[
            @[@"Pyramid of Khufu", @138.8],
            @[@"Pyramid of Khafre", @136.4],
            @[@"Red Pyramid", @104],
            @[@"Bent Pyramid", @101.1],
            @[@"Pyramid of the Sun", @75]
                 ])
               ])
    ;
}

- (AAOptions *)tilemapChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(@"tilemap"))
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
                                                        .textOutlineSet(@"none"))
                                              )))
    .seriesSet(@[
        AASeriesElement.new
        .nameSet(@"Height")
        .colorByPointSet(@true)
        .dataSet(AAOptionsData.tilemapChartData)
               ])
    ;
}

- (AAOptions *)simpleTreemapChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeTreemap))
    .titleSet(AATitle.new
              .textSet(@"矩形树图"))
    .colorAxisSet(AAColorAxis.new
                  .minColorSet(@"#FFFFFF")
                  .maxColorSet(@"#FF0000")
                  )
    .seriesSet(@[
        AASeriesElement.new
        .dataSet(@[
            @{
                @"name": @"A",
                @"value": @6,
                @"colorValue": @1
            }, @{
                @"name": @"B",
                @"value": @6,
                @"colorValue": @2
            }, @{
                @"name": @"C",
                @"value": @4,
                @"colorValue": @3
            }, @{
                @"name": @"D",
                @"value": @3,
                @"colorValue": @4
            }, @{
                @"name": @"E",
                @"value": @2,
                @"colorValue": @5
            }, @{
                @"name": @"F",
                @"value": @2,
                @"colorValue": @6
            }, @{
                @"name": @"G",
                @"value": @1,
                @"colorValue": @7
            }
                 ])
               ])
    ;
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
            .borderWidthSet(@3)])
        .dataSet(AAOptionsData.drilldownTreemapChartData)
               ])
    ;
}

- (AAOptions *)xrangeChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(@"xrange"))
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
              
              .titleSet(AATitle.new
                        .textSet(@""))
              .reversedSet(true)
              .categoriesSet(@[@"原型",@"开发",@"测试",@"上线"]))
    .legendSet(AALegend.new
               .enabledSet(false))
    .seriesSet(@[@{
                     @"borderRadius":@2,
            @"pointPadding": @0,
            @"groupPadding": @0,
            @"data": AAOptionsData.xrangeChartdata
        }])
    ;
}

@end
