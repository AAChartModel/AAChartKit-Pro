
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
//        case 7: return [self adjustChartLeftAndRightMargin];
//        case 8: return [self configureChartWithBackgroundImage];
//        case 9: return [self configureDoubleYAxisChartOptions];
//        case 10: return [self adjustChartSeriesDataAccuracy];
//        case 11: return [self adjustGroupPaddingForPolarChart];
//        case 12: return [self customStyleStackedColumnChart];
//        case 13: return [self specialStyleStepLineChart];
//        case 14: return [self disableChartAnimation];//禁用图表的渲染动画效果
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
        .typeSet(@"sankey")
        .nameSet(@"语言热度值")
        .keysSet(@[@"from", @"to", @"weight"])
        .dataSet(@[
            @[@"巴西", @"葡萄牙", @5 ],
            @[@"巴西", @"法国", @1 ],
            @[@"巴西", @"西班牙", @1 ],
            @[@"巴西", @"英国", @1 ],
            @[@"加拿大", @"葡萄牙", @1 ],
            @[@"加拿大", @"法国", @5 ],
            @[@"加拿大", @"英国", @1 ],
            @[@"墨西哥", @"葡萄牙", @1 ],
            @[@"墨西哥", @"法国", @1 ],
            @[@"墨西哥", @"西班牙", @5 ],
            @[@"墨西哥", @"英国", @1 ],
            @[@"美国", @"葡萄牙", @1 ],
            @[@"美国", @"法国", @1 ],
            @[@"美国", @"西班牙", @1 ],
            @[@"美国", @"英国", @5 ],
            @[@"葡萄牙", @"安哥拉", @2 ],
            @[@"葡萄牙", @"塞内加尔", @1 ],
            @[@"葡萄牙", @"摩洛哥", @1 ],
            @[@"葡萄牙", @"南非", @3 ],
            @[@"法国", @"安哥拉", @1 ],
            @[@"法国", @"塞内加尔", @3 ],
            @[@"法国", @"马里", @3 ],
            @[@"法国", @"摩洛哥", @3 ],
            @[@"法国", @"南非", @1 ],
            @[@"西班牙", @"塞内加尔", @1 ],
            @[@"西班牙", @"摩洛哥", @3 ],
            @[@"西班牙", @"南非", @1 ],
            @[@"英国", @"安哥拉", @1 ],
            @[@"英国", @"塞内加尔", @1 ],
            @[@"英国", @"摩洛哥", @2 ],
            @[@"英国", @"南非", @7 ],
            @[@"南非", @"中国", @5 ],
            @[@"南非", @"印度", @1 ],
            @[@"南非", @"日本", @3 ],
            @[@"安哥拉", @"中国", @5 ],
            @[@"安哥拉", @"印度", @1 ],
            @[@"安哥拉", @"日本", @3 ],
            @[@"塞内加尔", @"中国", @5 ],
            @[@"塞内加尔", @"印度", @1 ],
            @[@"塞内加尔", @"日本", @3 ],
            @[@"马里", @"中国", @5 ],
            @[@"马里", @"印度", @1 ],
            @[@"马里", @"日本", @3 ],
            @[@"摩洛哥", @"中国", @5 ],
            @[@"摩洛哥", @"印度", @1 ],
            @[@"摩洛哥", @"日本", @3 ]
                 ]),
               ])
    ;
}

- (AAOptions *)variablepieChart {
    AAChart *aaChart = AAChart.new
    .typeSet(@"variablepie");
    
    AATitle *aaTitle = AATitle.new
    .textSet(@"不同国家人口密度及面积对比");
    
    AASubtitle *aaSubtitle = AASubtitle.new
    .textSet(@"扇区长度（圆周方法）表示面积，宽度（纵向）表示人口密度");
    
    AATooltip *aaTooltip = AATooltip.new
    .enabledSet(true)
    .headerFormatSet(@"")
    .pointFormatSet(@"<span style=""color:{point.color}"">\u25CF</span> <b> {point.name}</b><br/>""面积 (平方千米): <b>{point.y}</b><br/>""人口密度 (每平方千米人数): <b>{point.z}</b><br/>""");
    
    NSArray *seriesElementArr = @[
        @{  @"minPointSize": @10,
            @"innerSize": @"20%",
            @"zMin": @0,
            @"name": @"countries",
            @"data": @[
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
            ]
        }];
    
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
    
    NSArray *seriesElementArr = @[
        AASeriesElement.new
        .typeSet(@"treemap")
        .levelsSet(@[
            @{@"level":@1,
              @"layoutAlgorithm":@"sliceAndDice",
              @"dataLabels": AADataLabels.new
              .enabledSet(true)
              .alignSet(AALegendAlignTypeLeft)
              .verticalAlignSet(AALegendVerticalAlignTypeTop)
              .styleSet(AAStyle.new
                        .fontSizeSet(@"15 px")
                        .fontWeightSet(AAChartFontWeightTypeBold)),
            }])
        .dataSet(seriesDataArr)];
    
    AAOptions *aaOptions = AAOptions.new
    .titleSet(AATitle.new
              .textSet(@"Fruit Consumption Situation"))
    .legendSet(AALegend.new
               .enabledSet(false))
    .seriesSet(seriesElementArr);
    
    return aaOptions;
}

- (AAOptions *)variwideChart {
    AAChart *aaChart = AAChart.new
    .typeSet(@"variwide");
    
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
    NSArray *dataArr = [AAOptionsData sunburstChartData] ;
    
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
        .typeSet(@"sunburst")
        .allowDrillToNodeSet(true)
        .levelsSet(@[
            @{  @"level":@2,
                @"colorByPoint":(id)@(true),
                @"layoutAlgorithm":@"sliceAndDice",
                @"dataLabels": @{
                        @"rotationMode": @"parallel"
                }
            },
            @{
                @"level": @3,
                @"colorVariation": @{
                        @"key": @"brightness",
                        @"to": @-0.5
                }},
            @{
                @"level": @4,
                @"colorVariation": @{
                        @"key": @"brightness",
                        @"to": @0.5
                }
            }])
        .dataSet(dataArr)
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
    .titleSet(AATitle.new
              .textSet(@"AAChartKit-Pro 和弦图"))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(@"dependencywheel")
        .nameSet(@"Dependency wheel series")
        .keysSet(@[@"from",@"to",@"weight"])
        .dataSet(@[
            @[@"Brazil", @"Portugal", @5],
            @[@"Brazil", @"France", @1],
            @[@"Brazil", @"Spain", @1],
            @[@"Brazil", @"England", @1],
            @[@"Canada", @"Portugal", @1],
            @[@"Canada", @"France", @5],
            @[@"Canada", @"England", @1],
            @[@"Mexico", @"Portugal", @1],
            @[@"Mexico", @"France", @1],
            @[@"Mexico", @"Spain", @5],
            @[@"Mexico", @"England", @1],
            @[@"USA", @"Portugal", @1],
            @[@"USA", @"France", @1],
            @[@"USA", @"Spain", @1],
            @[@"USA", @"England", @5],
            @[@"Portugal", @"Angola", @2],
            @[@"Portugal", @"Senegal", @1],
            @[@"Portugal", @"Morocco", @1],
            @[@"Portugal", @"South Africa", @3],
            @[@"France", @"Angola", @1],
            @[@"France", @"Senegal", @3],
            @[@"France", @"Mali", @3],
            @[@"France", @"Morocco", @3],
            @[@"France", @"South Africa", @1],
            @[@"Spain", @"Senegal", @1],
            @[@"Spain", @"Morocco", @3],
            @[@"Spain", @"South Africa", @1],
            @[@"England", @"Angola", @1],
            @[@"England", @"Senegal", @1],
            @[@"England", @"Morocco", @2],
            @[@"England", @"South Africa", @7],
            @[@"South Africa", @"China", @5],
            @[@"South Africa", @"India", @1],
            @[@"South Africa", @"Japan", @3],
            @[@"Angola", @"China", @5],
            @[@"Angola", @"India", @1],
            @[@"Angola", @"Japan", @3],
            @[@"Senegal", @"China", @5],
            @[@"Senegal", @"India", @1],
            @[@"Senegal", @"Japan", @3],
            @[@"Mali", @"China", @5],
            @[@"Mali", @"India", @1],
            @[@"Mali", @"Japan", @3],
            @[@"Morocco", @"China", @5],
            @[@"Morocco", @"India", @1],
            @[@"Morocco", @"Japan", @3],
            @[@"Japan", @"Brazil", @1]
        ])
        .dataLabelsSet((id)@{
                    @"color": @"#333",
                    @"textPath": @{
                        @"enabled": @true,
                        @"attributes": @{
                            @"dy": @5
                        }
                    },
                    @"distance": @10
                })
               ]);
}

// https://jshare.com.cn/demos/hhhhiz
- (AAOptions *)heatmapChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(@"heatmap"))
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


@end
