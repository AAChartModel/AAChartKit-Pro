
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
#import "AAChartKit.h"

#import "AADateUTCTool.h"
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
        case 0: return [self configureTheAAOptionsOfAreaChart];
        case 1: return [self configureTheAAOptionsOfPieChart];
        case 2: return [self adjustPieChartTitleAndDataLabelFontStyle];
        case 3: return [self configureTheAAOptionsOfSpecialNestedColumnChart];
        case 4: return [self configureThePolygonPolarChart];
        case 5: return [self configureTheNoGapColunmChart];
        case 6: return [self configureCustomStyleTooltipChart];
        case 7: return [self adjustChartLeftAndRightMargin];
        case 8: return [self configureChartWithBackgroundImage];
        case 9: return [self configureDoubleYAxisChartOptions];
        case 10: return [self adjustChartSeriesDataAccuracy];
        case 11: return [self adjustGroupPaddingForPolarChart];
        case 12: return [self customStyleStackedColumnChart];
        case 13: return [self specialStyleStepLineChart];
        case 14: return [self disableChartAnimation];//禁用图表的渲染动画效果
        case 15: return [self customChartLengendItemStyle];//自定义图表的 legend 图例样式

    }
    return nil;
}

- (AAOptions *)configureTheAAOptionsOfAreaChart {
    
    //标题
    AATitle *aaTitle = AAObject(AATitle)
    .textSet(@"Highcharts 桑基图");//标题文本内容
    
    //数据源
    NSArray *aaSeries = @[
                          AAObject(AASeriesElement)
                          .typeSet(@"sankey")
                          .nameSet(@"语言热度值")
                          .keysSet(@[@"from", @"to", @"weight"])
                          .dataSet(
                                   @[
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
                                     ]
                                   ),
                          ];
    
    AAOptions *aaOptions = AAObject(AAOptions);
    aaOptions.title = aaTitle;
    aaOptions.series = aaSeries;
    return aaOptions;

}

- (AAOptions *)configureTheAAOptionsOfPieChart {
    
    AAChart *aaChart = AAObject(AAChart)
    .typeSet(@"variablepie");
    
    AATitle *aaTitle = AAObject(AATitle)
    .textSet(@"不同国家人口密度及面积对比");
    
    AASubtitle *aaSubtitle = AAObject(AASubtitle)
    .textSet(@"扇区长度（圆周方法）表示面积，宽度（纵向）表示人口密度");
    
    AATooltip *aaTooltip = AAObject(AATooltip)
    .enabledSet(true)
    .headerFormatSet(@"")
    .pointFormatSet(@"<span style=""color:{point.color}"">\u25CF</span> <b> {point.name}</b><br/>""面积 (平方千米): <b>{point.y}</b><br/>""人口密度 (每平方千米人数): <b>{point.z}</b><br/>""");
    
    NSArray *seriesElementArr = @[@{
                                      @"minPointSize": @10,
                                      @"innerSize": @"20%",
                                      @"zMin": @0,
                                      @"name": @"countries",
                                      @"data": @[
                                              AAObject(AASeriesDataElement)
                                              .nameSet(@"西班牙")
                                              .ySet(@505370)
                                              .zSet(@92.9),
                                              AAObject(AASeriesDataElement)
                                              .nameSet(@"波兰")
                                              .ySet(@312685)
                                              .zSet(@124.6),
                                              AAObject(AASeriesDataElement)
                                              .nameSet(@"捷克共和国")
                                              .ySet(@78867)
                                              .zSet(@137.5),
                                              AAObject(AASeriesDataElement)
                                              .nameSet(@"意大利")
                                              .ySet(@301340)
                                              .zSet(@201.8),
                                              AAObject(AASeriesDataElement)
                                              .nameSet(@"瑞士")
                                              .ySet(@41277)
                                              .zSet(@214.5),
                                              AAObject(AASeriesDataElement)
                                              .nameSet(@"德国")
                                              .ySet(@357022)
                                              .zSet(@235.6),
                                              ]
                                      }];
    
    AAOptions *aaOptionsQ = AAObject(AAOptions)
    .chartSet(aaChart)
    .titleSet(aaTitle)
    .subtitleSet(aaSubtitle)
    .tooltipSet(aaTooltip)
    .seriesSet(seriesElementArr);
    
    return aaOptionsQ;
  
}

- (AAOptions *)adjustPieChartTitleAndDataLabelFontStyle {
    
    NSArray *seriesDataArr = @[
                               AAObject(AASeriesDataElement)
                               .idSet(@"A")
                               .nameSet(@"Apple🍎")
                               .colorSet(@"#EF2566"),
                               AAObject(AASeriesDataElement)
                               .idSet(@"B")
                               .nameSet(@"Banana🍌")
                               .colorSet(@"#EFE166"),
                               AAObject(AASeriesDataElement)
                               .idSet(@"O")
                               .nameSet(@"Orange🍊")
                               .colorSet(@"#EF9866"),
                               AAObject(AASeriesDataElement)
                               .nameSet(@"Angel Jill")
                               .parentSet(@"A")
                               .valueSet(@5),
                               AAObject(AASeriesDataElement)
                               .nameSet(@"Charles Bond")
                               .parentSet(@"A")
                               .valueSet(@3),
                               AAObject(AASeriesDataElement)
                               .nameSet(@"Babara Swift")
                               .parentSet(@"A")
                               .valueSet(@4),
                               AAObject(AASeriesDataElement)
                               .nameSet(@"Angel Jill")
                               .parentSet(@"B")
                               .valueSet(@4),
                               AAObject(AASeriesDataElement)
                               .nameSet(@"Charles Bond")
                               .parentSet(@"B")
                               .valueSet(@10),
                               AAObject(AASeriesDataElement)
                               .nameSet(@"Babara Swift")
                               .parentSet(@"B")
                               .valueSet(@1),
                               AAObject(AASeriesDataElement)
                               .nameSet(@"Angel Jill")
                               .parentSet(@"O")
                               .valueSet(@1),
                               AAObject(AASeriesDataElement)
                               .nameSet(@"Charles Bond")
                               .parentSet(@"O")
                               .valueSet(@3),
                               AAObject(AASeriesDataElement)
                               .nameSet(@"Babara Swift")
                               .parentSet(@"O")
                               .valueSet(@3),
                               AAObject(AASeriesDataElement)
                               .nameSet(@"阿苏")
                               .parentSet(@"wiki")
                               .valueSet(@2)
                               .colorSet(@"#9EDE00"),
                               ];
    
    NSArray *seriesElementArr = @[AAObject(AASeriesElement)
                                  .typeSet(@"treemap")
                                  .levelsSet(@[@{
                                                   @"level":@1,
                                                   @"layoutAlgorithm":@"sliceAndDice",
                                                   @"dataLabels": AAObject(AADataLabels)
                                                   .enabledSet(true)
                                                   .alignSet(AALegendAlignTypeLeft)
                                                   .verticalAlignSet(AALegendVerticalAlignTypeTop)
                                                   .styleSet(AAObject(AAStyle)
                                                             .fontSizeSet(@"15 px")
                                                             .fontWeightSet(AAChartFontWeightTypeBold)),
                                                   }])
                                  .dataSet(seriesDataArr)];
    
    AAOptions *aaOptions = AAObject(AAOptions)
    .titleSet(AAObject(AATitle)
              .textSet(@"Fruit Consumption Situation"))
    .legendSet(AAObject(AALegend)
               .enabledSet(false))
    .seriesSet(seriesElementArr);
   
    return aaOptions;
}

- (AAOptions *)configureTheAAOptionsOfSpecialNestedColumnChart {
    
    AAChart *aaChart = AAChart.new.typeSet(@"variwide");
    
    AATitle *aaTitle = AATitle.new.textSet(@"2016 年欧洲各国人工成本");
    
    AASubtitle *aaSubtitle = AASubtitle.new.textSet(@"数据来源:EUROSTAT");

    AAXAxis *aaXAxis = AAXAxis.new
    .visibleSet(true)
    .typeSet(@"category")
    .titleSet(AATitle.new.textSet(@"* 柱子宽度与 GDP 成正比"));
    
    AATooltip *aaTooltip = AATooltip.new
    .enabledSet(true)
    .pointFormatSet(@"人工成本： <b>€ {point.y}/h</b><br>' + 'GDP: <b>€ {point.z} 百万</b><br>");
    
    AALegend *aaLegend = AALegend.new.enabledSet(false);
    
    NSArray *seriesElementArr = @[ AASeriesElement.new
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

- (AAOptions *)configureThePolygonPolarChart {
  NSArray *dataArr =  @[@{
          @"id": @"0.0",
          @"parent": @"",
          @"name": @"The World"
          }, @{
          @"id": @"1.3",
          @"parent": @"0.0",
          @"name": @"亚洲"
          }, @{
          @"id": @"1.1",
          @"parent": @"0.0",
          @"name": @"非洲"
          }, @{
          @"id": @"1.2",
          @"parent": @"0.0",
          @"name": @"美洲"
          }, @{
          @"id": @"1.4",
          @"parent": @"0.0",
          @"name": @"欧洲"
          }, @{
          @"id": @"1.5",
          @"parent": @"0.0",
          @"name": @"大洋洲"
          },
      
    /* Africa */
  @{
          @"id": @"2.1",
          @"parent": @"1.1",
          @"name": @"东非"
          },
      
  @{
          @"id": @"3.1",
          @"parent": @"2.1",
          @"name": @"埃塞俄比亚",
          @"value": @104957438
          }, @{
          @"id": @"3.2",
          @"parent": @"2.1",
          @"name": @"坦桑尼亚",
          @"value": @57310019
          }, @{
          @"id": @"3.3",
          @"parent": @"2.1",
          @"name": @"肯尼亚",
          @"value": @49699862
          }, @{
          @"id": @"3.4",
          @"parent": @"2.1",
          @"name": @"乌干达",
          @"value": @42862958
          }, @{
          @"id": @"3.5",
          @"parent": @"2.1",
          @"name": @"莫桑比克",
          @"value": @29668834
          }, @{
          @"id": @"3.6",
          @"parent": @"2.1",
          @"name": @"马达加斯加岛",
          @"value": @25570895
          }, @{
          @"id": @"3.7",
          @"parent": @"2.1",
          @"name": @"马拉维",
          @"value": @18622104
          }, @{
          @"id": @"3.8",
          @"parent": @"2.1",
          @"name": @"赞比亚",
          @"value": @17094130
          }, @{
          @"id": @"3.9",
          @"parent": @"2.1",
          @"name": @"津巴布韦",
          @"value": @16529904
          }, @{
          @"id": @"3.10",
          @"parent": @"2.1",
          @"name": @"索马里",
          @"value": @14742523
          }, @{
          @"id": @"3.11",
          @"parent": @"2.1",
          @"name": @"南苏丹",
          @"value": @12575714
          }, @{
          @"id": @"3.12",
          @"parent": @"2.1",
          @"name": @"卢旺达",
          @"value": @12208407
          }, @{
          @"id": @"3.13",
          @"parent": @"2.1",
          @"name": @"布隆迪",
          @"value": @10864245
          }, @{
          @"id": @"3.14",
          @"parent": @"2.1",
          @"name": @"厄立特里亚国",
          @"value": @5068831
          }, @{
          @"id": @"3.15",
          @"parent": @"2.1",
          @"name": @"毛里求斯",
          @"value": @1265138
          }, @{
          @"id": @"3.16",
          @"parent": @"2.1",
          @"name": @"吉布提",
          @"value": @956985
          }, @{
          @"id": @"3.17",
          @"parent": @"2.1",
          @"name": @"留尼汪岛",
          @"value": @876562
          }, @{
          @"id": @"3.18",
          @"parent": @"2.1",
          @"name": @"科摩罗",
          @"value": @813912
          }, @{
          @"id": @"3.19",
          @"parent": @"2.1",
          @"name": @"马约特岛",
          @"value": @253045
          }, @{
          @"id": @"3.20",
          @"parent": @"2.1",
          @"name": @"塞舌尔群岛",
          @"value": @94737
          },
      
  @{
          @"id": @"2.5",
          @"parent": @"1.1",
          @"name": @"西非"
          },
      
  @{
          @"id": @"3.42",
          @"parent": @"2.5",
          @"name": @"尼日利亚",
          @"value": @190886311
          }, @{
          @"id": @"3.43",
          @"parent": @"2.5",
          @"name": @"加纳",
          @"value": @28833629
          }, @{
          @"id": @"3.44",
          @"parent": @"2.5",
          @"name": @"科特迪瓦共和国",
          @"value": @24294750
          }, @{
          @"id": @"3.45",
          @"parent": @"2.5",
          @"name": @"尼日尔",
          @"value": @21477348
          }, @{
          @"id": @"3.46",
          @"parent": @"2.5",
          @"name": @"布基纳法索",
          @"value": @19193382
          }, @{
          @"id": @"3.47",
          @"parent": @"2.5",
          @"name": @"马里",
          @"value": @18541980
          }, @{
          @"id": @"3.48",
          @"parent": @"2.5",
          @"name": @"塞内加尔",
          @"value": @15850567
          }, @{
          @"id": @"3.49",
          @"parent": @"2.5",
          @"name": @"几内亚共和国",
          @"value": @12717176
          }, @{
          @"id": @"3.50",
          @"parent": @"2.5",
          @"name": @"贝宁",
          @"value": @11175692
          }, @{
          @"id": @"3.51",
          @"parent": @"2.5",
          @"name": @"多哥",
          @"value": @7797694
          }, @{
          @"id": @"3.52",
          @"parent": @"2.5",
          @"name": @"塞拉利昂",
          @"value": @7557212
          }, @{
          @"id": @"3.53",
          @"parent": @"2.5",
          @"name": @"利比里亚",
          @"value": @4731906
          }, @{
          @"id": @"3.54",
          @"parent": @"2.5",
          @"name": @"毛里塔尼亚",
          @"value": @4420184
          }, @{
          @"id": @"3.55",
          @"parent": @"2.5",
          @"name": @"The Gambia",
          @"value": @2100568
          }, @{
          @"id": @"3.56",
          @"parent": @"2.5",
          @"name": @"Guinea-Bissau",
          @"value": @1861283
          }, @{
          @"id": @"3.57",
          @"parent": @"2.5",
          @"name": @"Cabo Verde",
          @"value": @546388
          }, @{
          @"id": @"3.58",
          @"parent": @"2.5",
          @"name": @"Saint Helena, Ascension and Tristan da Cunha",
          @"value": @4049
          },
      
  @{
          @"id": @"2.3",
          @"parent": @"1.1",
          @"name": @"北非"
          },
      
  @{
          @"id": @"3.30",
          @"parent": @"2.3",
          @"name": @"Egypt",
          @"value": @97553151
          }, @{
          @"id": @"3.31",
          @"parent": @"2.3",
          @"name": @"Algeria",
          @"value": @41318142
          }, @{
          @"id": @"3.32",
          @"parent": @"2.3",
          @"name": @"Sudan",
          @"value": @40533330
          }, @{
          @"id": @"3.33",
          @"parent": @"2.3",
          @"name": @"Morocco",
          @"value": @35739580
          }, @{
          @"id": @"3.34",
          @"parent": @"2.3",
          @"name": @"Tunisia",
          @"value": @11532127
          }, @{
          @"id": @"3.35",
          @"parent": @"2.3",
          @"name": @"Libya",
          @"value": @6374616
          }, @{
          @"id": @"3.36",
          @"parent": @"2.3",
          @"name": @"Western Sahara",
          @"value": @552628
          },
      
  @{
          @"id": @"2.2",
          @"parent": @"1.1",
          @"name": @"Central Africa"
          },
      
  @{
          @"id": @"3.21",
          @"parent": @"2.2",
          @"name": @"Democratic Republic of the Congo",
          @"value": @81339988
          }, @{
          @"id": @"3.22",
          @"parent": @"2.2",
          @"name": @"Angola",
          @"value": @29784193
          }, @{
          @"id": @"3.23",
          @"parent": @"2.2",
          @"name": @"Cameroon",
          @"value": @24053727
          }, @{
          @"id": @"3.24",
          @"parent": @"2.2",
          @"name": @"Chad",
          @"value": @14899994
          }, @{
          @"id": @"3.25",
          @"parent": @"2.2",
          @"name": @"Congo",
          @"value": @5260750
          }, @{
          @"id": @"3.26",
          @"parent": @"2.2",
          @"name": @"Central African Republic",
          @"value": @4659080
          }, @{
          @"id": @"3.27",
          @"parent": @"2.2",
          @"name": @"Gabon",
          @"value": @2025137
          }, @{
          @"id": @"3.28",
          @"parent": @"2.2",
          @"name": @"Equatorial Guinea",
          @"value": @1267689
          }, @{
          @"id": @"3.29",
          @"parent": @"2.2",
          @"name": @"Sao Tome and Principe",
          @"value": @204327
          },
      
  @{
          @"id": @"2.4",
          @"parent": @"1.1",
          @"name": @"南美洲"
          },
      
  @{
          @"id": @"3.37",
          @"parent": @"2.4",
          @"name": @"南非",
          @"value": @56717156
          }, @{
          @"id": @"3.38",
          @"parent": @"2.4",
          @"name": @"Namibia",
          @"value": @2533794
          }, @{
          @"id": @"3.39",
          @"parent": @"2.4",
          @"name": @"Botswana",
          @"value": @2291661
          }, @{
          @"id": @"3.40",
          @"parent": @"2.4",
          @"name": @"Lesotho",
          @"value": @2233339
          }, @{
          @"id": @"3.41",
          @"parent": @"2.4",
          @"name": @"Swaziland",
          @"value": @1367254
          },
      
    /***********/
      
    /* America */
  @{
          @"id": @"2.9",
          @"parent": @"1.2",
          @"name": @"南美洲"
          },
      
  @{
          @"id": @"3.98",
          @"parent": @"2.9",
          @"name": @"Brazil",
          @"value": @209288278
          }, @{
          @"id": @"3.99",
          @"parent": @"2.9",
          @"name": @"Colombia",
          @"value": @49065615
          }, @{
          @"id": @"3.100",
          @"parent": @"2.9",
          @"name": @"Argentina",
          @"value": @44271041
          }, @{
          @"id": @"3.101",
          @"parent": @"2.9",
          @"name": @"Peru",
          @"value": @32165485
          }, @{
          @"id": @"3.102",
          @"parent": @"2.9",
          @"name": @"Venezuela",
          @"value": @31977065
          }, @{
          @"id": @"3.103",
          @"parent": @"2.9",
          @"name": @"Chile",
          @"value": @18054726
          }, @{
          @"id": @"3.104",
          @"parent": @"2.9",
          @"name": @"Ecuador",
          @"value": @16624858
          }, @{
          @"id": @"3.105",
          @"parent": @"2.9",
          @"name": @"Bolivia",
          @"value": @11051600
          }, @{
          @"id": @"3.106",
          @"parent": @"2.9",
          @"name": @"Paraguay",
          @"value": @6811297
          }, @{
          @"id": @"3.107",
          @"parent": @"2.9",
          @"name": @"Uruguay",
          @"value": @3456750
          }, @{
          @"id": @"3.108",
          @"parent": @"2.9",
          @"name": @"Guyana",
          @"value": @777859
          }, @{
          @"id": @"3.109",
          @"parent": @"2.9",
          @"name": @"Suriname",
          @"value": @563402
          }, @{
          @"id": @"3.110",
          @"parent": @"2.9",
          @"name": @"French Guiana",
          @"value": @282731
          }, @{
          @"id": @"3.111",
          @"parent": @"2.9",
          @"name": @"Falkland Islands",
          @"value": @2910
          },
      
  @{
          @"id": @"2.8",
          @"parent": @"1.2",
          @"name": @"北美洲"
          },
      
  @{
          @"id": @"3.93",
          @"parent": @"2.8",
          @"name": @"美国",
          @"value": @324459463
          }, @{
          @"id": @"3.94",
          @"parent": @"2.8",
          @"name": @"加拿大",
          @"value": @36624199
          }, @{
          @"id": @"3.95",
          @"parent": @"2.8",
          @"name": @"百慕大群岛",
          @"value": @61349
          }, @{
          @"id": @"3.96",
          @"parent": @"2.8",
          @"name": @"格陵兰",
          @"value": @56480
          }, @{
          @"id": @"3.97",
          @"parent": @"2.8",
          @"name": @"Saint Pierre and Miquelon",
          @"value": @6320
          },
      
  @{
          @"id": @"2.7",
          @"parent": @"1.2",
          @"name": @"中美洲"
          },
      
  @{
          @"id": @"3.85",
          @"parent": @"2.7",
          @"name": @"墨西哥",
          @"value": @129163276
          }, @{
          @"id": @"3.86",
          @"parent": @"2.7",
          @"name": @"危地马拉",
          @"value": @16913503
          }, @{
          @"id": @"3.87",
          @"parent": @"2.7",
          @"name": @"Honduras",
          @"value": @9265067
          }, @{
          @"id": @"3.88",
          @"parent": @"2.7",
          @"name": @"El Salvador",
          @"value": @6377853
          }, @{
          @"id": @"3.89",
          @"parent": @"2.7",
          @"name": @"Nicaragua",
          @"value": @6217581
          }, @{
          @"id": @"3.90",
          @"parent": @"2.7",
          @"name": @"Costa Rica",
          @"value": @4905769
          }, @{
          @"id": @"3.91",
          @"parent": @"2.7",
          @"name": @"Panama",
          @"value": @4098587
          }, @{
          @"id": @"3.92",
          @"parent": @"2.7",
          @"name": @"Belize",
          @"value": @374681
          },
      
  @{
          @"id": @"2.6",
          @"parent": @"1.2",
          @"name": @"Caribbean"
          },
      
  @{
          @"id": @"3.59",
          @"parent": @"2.6",
          @"name": @"Cuba",
          @"value": @11484636
          }, @{
          @"id": @"3.60",
          @"parent": @"2.6",
          @"name": @"Haiti",
          @"value": @10981229
          }, @{
          @"id": @"3.61",
          @"parent": @"2.6",
          @"name": @"Dominican Republic",
          @"value": @10766998
          }, @{
          @"id": @"3.62",
          @"parent": @"2.6",
          @"name": @"Puerto Rico",
          @"value": @3663131
          }, @{
          @"id": @"3.63",
          @"parent": @"2.6",
          @"name": @"Jamaica",
          @"value": @2890299
          }, @{
          @"id": @"3.64",
          @"parent": @"2.6",
          @"name": @"Trinidad and Tobago",
          @"value": @1369125
          }, @{
          @"id": @"3.65",
          @"parent": @"2.6",
          @"name": @"Guadeloupe",
          @"value": @449568
          }, @{
          @"id": @"3.66",
          @"parent": @"2.6",
          @"name": @"Bahamas",
          @"value": @395361
          }, @{
          @"id": @"3.67",
          @"parent": @"2.6",
          @"name": @"Martinique",
          @"value": @384896
          }, @{
          @"id": @"3.68",
          @"parent": @"2.6",
          @"name": @"Barbados",
          @"value": @285719
          }, @{
          @"id": @"3.69",
          @"parent": @"2.6",
          @"name": @"Saint Lucia",
          @"value": @178844
          }, @{
          @"id": @"3.70",
          @"parent": @"2.6",
          @"name": @"Curaçao",
          @"value": @160539
          }, @{
          @"id": @"3.71",
          @"parent": @"2.6",
          @"name": @"Saint Vincent and the Grenadines",
          @"value": @109897
          }, @{
          @"id": @"3.72",
          @"parent": @"2.6",
          @"name": @"Grenada",
          @"value": @107825
          }, @{
          @"id": @"3.73",
          @"parent": @"2.6",
          @"name": @"Aruba",
          @"value": @105264
          }, @{
          @"id": @"3.74",
          @"parent": @"2.6",
          @"name": @"United States Virgin Islands",
          @"value": @104901
          }, @{
          @"id": @"3.75",
          @"parent": @"2.6",
          @"name": @"Antigua and Barbuda",
          @"value": @102012
          }, @{
          @"id": @"3.76",
          @"parent": @"2.6",
          @"name": @"Dominica",
          @"value": @73925
          }, @{
          @"id": @"3.77",
          @"parent": @"2.6",
          @"name": @"Cayman Islands",
          @"value": @61559
          }, @{
          @"id": @"3.78",
          @"parent": @"2.6",
          @"name": @"Saint Kitts and Nevis",
          @"value": @55345
          }, @{
          @"id": @"3.79",
          @"parent": @"2.6",
          @"name": @"Sint Maarten",
          @"value": @40120
          }, @{
          @"id": @"3.80",
          @"parent": @"2.6",
          @"name": @"Turks and Caicos Islands",
          @"value": @35446
          }, @{
          @"id": @"3.81",
          @"parent": @"2.6",
          @"name": @"British Virgin Islands",
          @"value": @31196
          }, @{
          @"id": @"3.82",
          @"parent": @"2.6",
          @"name": @"Caribbean Netherlands",
          @"value": @25398
          }, @{
          @"id": @"3.83",
          @"parent": @"2.6",
          @"name": @"Anguilla",
          @"value": @14909
          }, @{
          @"id": @"3.84",
          @"parent": @"2.6",
          @"name": @"Montserrat",
          @"value": @5177
          },
    /***********/
      
    /* Asia */
  @{
          @"id": @"2.13",
          @"parent": @"1.3",
          @"name": @"南亚"
          },
      
  @{
          @"id": @"3.136",
          @"parent": @"2.13",
          @"name": @"印度",
          @"value": @1339180127
          }, @{
          @"id": @"3.137",
          @"parent": @"2.13",
          @"name": @"巴基斯坦",
          @"value": @197015955
          }, @{
          @"id": @"3.138",
          @"parent": @"2.13",
          @"name": @"孟加拉国",
          @"value": @164669751
          }, @{
          @"id": @"3.139",
          @"parent": @"2.13",
          @"name": @"伊朗",
          @"value": @81162788
          }, @{
          @"id": @"3.140",
          @"parent": @"2.13",
          @"name": @"阿富汗",
          @"value": @35530081
          }, @{
          @"id": @"3.141",
          @"parent": @"2.13",
          @"name": @"尼泊尔",
          @"value": @29304998
          }, @{
          @"id": @"3.142",
          @"parent": @"2.13",
          @"name": @"斯里兰卡",
          @"value": @20876917
          }, @{
          @"id": @"3.143",
          @"parent": @"2.13",
          @"name": @"不丹",
          @"value": @807610
          }, @{
          @"id": @"3.144",
          @"parent": @"2.13",
          @"name": @"马尔代夫",
          @"value": @436330
          },
      
  @{
          @"id": @"2.11",
          @"parent": @"1.3",
          @"name": @"东亚"
          },
      
  @{
          @"id": @"3.117",
          @"parent": @"2.11",
          @"name": @"中国",
          @"value": @(1409517397 + 622567 + 7364883 + 23626456)
          }, @{
          @"id": @"3.118",
          @"parent": @"2.11",
          @"name": @"日本",
          @"value": @127484450
          }, @{
          @"id": @"3.119",
          @"parent": @"2.11",
          @"name": @"南韩",
          @"value": @50982212
          }, @{
          @"id": @"3.120",
          @"parent": @"2.11",
          @"name": @"朝鲜",
          @"value": @25490965
          }, /*@{
              @"id": @"3.121",
              @"parent": @"2.11",
              @"name": @"台湾省（中国）",
              @"value": @23626456
              }, @{
              @"id": @"3.122",
              @"parent": @"2.11",
              @"name": @"香港特别行政区（中国）",
              @"value": @7364883
              }, */@{
          @"id": @"3.123",
          @"parent": @"2.11",
          @"name": @"蒙古",
          @"value": @3075647
          }, /*@{
              @"id": @"3.124",
              @"parent": @"2.11",
              @"name": @"澳门特别行政区（中国）",
              @"value": @622567
              },*/
      
  @{
          @"id": @"2.12",
          @"parent": @"1.3",
          @"name": @"东南亚"
          },
      
  @{
          @"id": @"3.125",
          @"parent": @"2.12",
          @"name": @"印尼",
          @"value": @263991379
          }, @{
          @"id": @"3.126",
          @"parent": @"2.12",
          @"name": @"菲律宾",
          @"value": @104918090
          }, @{
          @"id": @"3.127",
          @"parent": @"2.12",
          @"name": @"越南",
          @"value": @95540800
          }, @{
          @"id": @"3.128",
          @"parent": @"2.12",
          @"name": @"泰国",
          @"value": @69037513
          }, @{
          @"id": @"3.129",
          @"parent": @"2.12",
          @"name": @"缅甸",
          @"value": @53370609
          }, @{
          @"id": @"3.130",
          @"parent": @"2.12",
          @"name": @"马来西亚",
          @"value": @31624264
          }, @{
          @"id": @"3.131",
          @"parent": @"2.12",
          @"name": @"柬埔寨",
          @"value": @16005373
          }, @{
          @"id": @"3.132",
          @"parent": @"2.12",
          @"name": @"老挝",
          @"value": @6858160
          }, @{
          @"id": @"3.133",
          @"parent": @"2.12",
          @"name": @"新加坡",
          @"value": @5708844
          }, @{
          @"id": @"3.134",
          @"parent": @"2.12",
          @"name": @"东帝汶民主共和国",
          @"value": @1296311
          }, @{
          @"id": @"3.135",
          @"parent": @"2.12",
          @"name": @"文莱",
          @"value": @428697
          // @"color": @""
          },
      
  @{
          @"id": @"2.14",
          @"parent": @"1.3",
          @"name": @"西亚"
          },
      
  @{
          @"id": @"3.145",
          @"parent": @"2.14",
          @"name": @"土耳其",
          @"value": @80745020
          }, @{
          @"id": @"3.146",
          @"parent": @"2.14",
          @"name": @"伊拉克",
          @"value": @38274618
          }, @{
          @"id": @"3.147",
          @"parent": @"2.14",
          @"name": @"沙特阿拉伯",
          @"value": @32938213
          }, @{
          @"id": @"3.148",
          @"parent": @"2.14",
          @"name": @"也门",
          @"value": @28250420
          }, @{
          @"id": @"3.149",
          @"parent": @"2.14",
          @"name": @"叙利亚",
          @"value": @18269868
          }, @{
          @"id": @"3.150",
          @"parent": @"2.14",
          @"name": @"阿塞拜疆",
          @"value": @9827589
          }, @{
          @"id": @"3.151",
          @"parent": @"2.14",
          @"name": @"约旦",
          @"value": @9702353
          }, @{
          @"id": @"3.152",
          @"parent": @"2.14",
          @"name": @"阿拉伯联合酋长国",
          @"value": @9400145
          }, @{
          @"id": @"3.153",
          @"parent": @"2.14",
          @"name": @"以色列",
          @"value": @8321570
          }, @{
          @"id": @"3.154",
          @"parent": @"2.14",
          @"name": @"黎巴嫩",
          @"value": @6082357
          }, @{
          @"id": @"3.155",
          @"parent": @"2.14",
          @"name": @"勒斯坦",
          @"value": @4920724
          }, @{
          @"id": @"3.156",
          @"parent": @"2.14",
          @"name": @"阿曼",
          @"value": @4636262
          }, @{
          @"id": @"3.157",
          @"parent": @"2.14",
          @"name": @"科威特",
          @"value": @4136528
          }, @{
          @"id": @"3.158",
          @"parent": @"2.14",
          @"name": @"乔治亚州",
          @"value": @3912061
          }, @{
          @"id": @"3.159",
          @"parent": @"2.14",
          @"name": @"美尼亚",
          @"value": @2930450
          }, @{
          @"id": @"3.160",
          @"parent": @"2.14",
          @"name": @"卡塔尔",
          @"value": @2639211
          }, @{
          @"id": @"3.161",
          @"parent": @"2.14",
          @"name": @"巴林王国",
          @"value": @1492584
          },
      
  @{
          @"id": @"2.10",
          @"parent": @"1.3",
          @"name": @"中亚"
          },
      
  @{
          @"id": @"3.112",
          @"parent": @"2.10",
          @"name": @"乌兹别克斯坦",
          @"value": @31910641
          }, @{
          @"id": @"3.113",
          @"parent": @"2.10",
          @"name": @"哈萨克斯坦",
          @"value": @18204499
          }, @{
          @"id": @"3.114",
          @"parent": @"2.10",
          @"name": @"塔吉克斯坦",
          @"value": @8921343
          }, @{
          @"id": @"3.115",
          @"parent": @"2.10",
          @"name": @"吉尔吉斯斯坦",
          @"value": @6045117
          }, @{
          @"id": @"3.116",
          @"parent": @"2.10",
          @"name": @"土库曼斯坦",
          @"value": @5758075
          },
    /***********/
      
    /* Europe */
  @{
          @"id": @"2.15",
          @"parent": @"1.4",
          @"name": @"东欧"
          },
      
  @{
          @"id": @"3.162",
          @"parent": @"2.15",
          @"name": @"俄罗斯",
          @"value": @143989754
          }, @{
          @"id": @"3.163",
          @"parent": @"2.15",
          @"name": @"乌克兰",
          @"value": @44222947
          }, @{
          @"id": @"3.164",
          @"parent": @"2.15",
          @"name": @"波兰",
          @"value": @38170712
          }, @{
          @"id": @"3.165",
          @"parent": @"2.15",
          @"name": @"罗马尼亚",
          @"value": @19679306
          }, @{
          @"id": @"3.166",
          @"parent": @"2.15",
          @"name": @"捷克",
          @"value": @10618303
          }, @{
          @"id": @"3.167",
          @"parent": @"2.15",
          @"name": @"匈牙利",
          @"value": @9721559
          }, @{
          @"id": @"3.168",
          @"parent": @"2.15",
          @"name": @"白俄罗斯",
          @"value": @9468338
          }, @{
          @"id": @"3.169",
          @"parent": @"2.15",
          @"name": @"保加利亚",
          @"value": @7084571
          }, @{
          @"id": @"3.170",
          @"parent": @"2.15",
          @"name": @"斯洛伐克",
          @"value": @5447662
          }, @{
          @"id": @"3.171",
          @"parent": @"2.15",
          @"name": @"摩尔多瓦",
          @"value": @4051212
          }, @{
          @"id": @"3.172",
          @"parent": @"2.15",
          @"name": @"塞浦路斯",
          @"value": @1179551
          },
      
  @{
          @"id": @"2.16",
          @"parent": @"1.4",
          @"name": @"北欧"
          },
      
  @{
          @"id": @"3.173",
          @"parent": @"2.16",
          @"name": @"英国",
          @"value": @66181585
          }, @{
          @"id": @"3.174",
          @"parent": @"2.16",
          @"name": @"瑞典",
          @"value": @9910701
          }, @{
          @"id": @"3.175",
          @"parent": @"2.16",
          @"name": @"丹麦",
          @"value": @5733551
          }, @{
          @"id": @"3.176",
          @"parent": @"2.16",
          @"name": @"芬兰",
          @"value": @5523231
          }, @{
          @"id": @"3.177",
          @"parent": @"2.16",
          @"name": @"挪威",
          @"value": @5305383
          }, @{
          @"id": @"3.178",
          @"parent": @"2.16",
          @"name": @"爱尔兰",
          @"value": @4761657
          }, @{
          @"id": @"3.179",
          @"parent": @"2.16",
          @"name": @"立陶宛",
          @"value": @2890297
          }, @{
          @"id": @"3.180",
          @"parent": @"2.16",
          @"name": @"拉脱维亚",
          @"value": @1949670
          }, @{
          @"id": @"3.181",
          @"parent": @"2.16",
          @"name": @"爱沙尼亚",
          @"value": @1309632
          }, @{
          @"id": @"3.182",
          @"parent": @"2.16",
          @"name": @"冰岛",
          @"value": @335025
          }, @{
          @"id": @"3.183",
          @"parent": @"2.16",
          @"name": @"Guernsey and  Jersey",
          @"value": @165314
          }, @{
          @"id": @"3.184",
          @"parent": @"2.16",
          @"name": @"Isle of Man",
          @"value": @84287
          }, @{
          @"id": @"3.185",
          @"parent": @"2.16",
          @"name": @"Faroe Islands",
          @"value": @49290
          },
      
  @{
          @"id": @"2.17",
          @"parent": @"1.4",
          @"name": @"Southern Europe"
          },
      
  @{
          @"id": @"3.186",
          @"parent": @"2.17",
          @"name": @"Italy",
          @"value": @59359900
          }, @{
          @"id": @"3.187",
          @"parent": @"2.17",
          @"name": @"Spain",
          @"value": @46354321
          }, @{
          @"id": @"3.188",
          @"parent": @"2.17",
          @"name": @"Greece",
          @"value": @11159773
          }, @{
          @"id": @"3.189",
          @"parent": @"2.17",
          @"name": @"Portugal",
          @"value": @10329506
          }, @{
          @"id": @"3.190",
          @"parent": @"2.17",
          @"name": @"Serbia",
          @"value": @8790574
          }, @{
          @"id": @"3.191",
          @"parent": @"2.17",
          @"name": @"Croatia",
          @"value": @4189353
          }, @{
          @"id": @"3.192",
          @"parent": @"2.17",
          @"name": @"Bosnia and Herzegovina",
          @"value": @3507017
          }, @{
          @"id": @"3.193",
          @"parent": @"2.17",
          @"name": @"Albania",
          @"value": @2930187
          }, @{
          @"id": @"3.194",
          @"parent": @"2.17",
          @"name": @"Republic of Macedonia",
          @"value": @2083160
          }, @{
          @"id": @"3.195",
          @"parent": @"2.17",
          @"name": @"Slovenia",
          @"value": @2079976
          }, @{
          @"id": @"3.196",
          @"parent": @"2.17",
          @"name": @"Montenegro",
          @"value": @628960
          }, @{
          @"id": @"3.197",
          @"parent": @"2.17",
          @"name": @"Malta",
          @"value": @430835
          }, @{
          @"id": @"3.198",
          @"parent": @"2.17",
          @"name": @"Andorra",
          @"value": @76965
          }, @{
          @"id": @"3.199",
          @"parent": @"2.17",
          @"name": @"Gibraltar",
          @"value": @34571
          }, @{
          @"id": @"3.200",
          @"parent": @"2.17",
          @"name": @"San Marino",
          @"value": @33400
          }, @{
          @"id": @"3.201",
          @"parent": @"2.17",
          @"name": @"Vatican City",
          @"value": @792
          },
      
  @{
          @"id": @"2.18",
          @"parent": @"1.4",
          @"name": @"Western Europe"
          },
      
  @{
          @"id": @"3.202",
          @"parent": @"2.18",
          @"name": @"Germany",
          @"value": @82114224
          }, @{
          @"id": @"3.203",
          @"parent": @"2.18",
          @"name": @"France",
          @"value": @64979548
          }, @{
          @"id": @"3.204",
          @"parent": @"2.18",
          @"name": @"Netherlands",
          @"value": @17035938
          }, @{
          @"id": @"3.205",
          @"parent": @"2.18",
          @"name": @"Belgium",
          @"value": @11429336
          }, @{
          @"id": @"3.206",
          @"parent": @"2.18",
          @"name": @"Austria",
          @"value": @8735453
          }, @{
          @"id": @"3.207",
          @"parent": @"2.18",
          @"name": @"Switzerland",
          @"value": @8476005
          }, @{
          @"id": @"3.208",
          @"parent": @"2.18",
          @"name": @"Luxembourg",
          @"value": @583455
          }, @{
          @"id": @"3.209",
          @"parent": @"2.18",
          @"name": @"Monaco",
          @"value": @38695
          }, @{
          @"id": @"3.210",
          @"parent": @"2.18",
          @"name": @"Liechtenstein",
          @"value": @37922
          },
    /***********/
      
    /* Oceania */
  @{
          @"id": @"2.19",
          @"parent": @"1.5",
          @"name": @"Australia and New Zealand"
          },
      
  @{
          @"id": @"3.211",
          @"parent": @"2.19",
          @"name": @"Australia",
          @"value": @24450561
          }, @{
          @"id": @"3.212",
          @"parent": @"2.19",
          @"name": @"New Zealand",
          @"value": @4705818
          },
      
  @{
          @"id": @"2.20",
          @"parent": @"1.5",
          @"name": @"Melanesia"
          },
      
  @{
          @"id": @"3.213",
          @"parent": @"2.20",
          @"name": @"Papua New Guinea"
          }, @{
          @"id": @"3.214",
          @"parent": @"2.20",
          @"name": @"Fiji",
          @"value": @905502
          }, @{
          @"id": @"3.215",
          @"parent": @"2.20",
          @"name": @"Solomon Islands",
          @"value": @611343
          }, @{
          @"id": @"3.216",
          @"parent": @"2.20",
          @"name": @"New Caledonia",
          @"value": @276255
          }, @{
          @"id": @"3.217",
          @"parent": @"2.20",
          @"name": @"Vanuatu",
          @"value": @276244
          },
      
  @{
          @"id": @"2.21",
          @"parent": @"1.5",
          @"name": @"Micronesia"
          },
      
  @{
          @"id": @"3.218",
          @"parent": @"2.21",
          @"name": @"Guam",
          @"value": @164229
          }, @{
          @"id": @"3.219",
          @"parent": @"2.21",
          @"name": @"Kiribati",
          @"value": @116398
          }, @{
          @"id": @"3.220",
          @"parent": @"2.21",
          @"name": @"Federated States of Micronesia",
          @"value": @105544
          }, @{
          @"id": @"3.221",
          @"parent": @"2.21",
          @"name": @"Northern Mariana Islands",
          @"value": @55144
          }, @{
          @"id": @"3.222",
          @"parent": @"2.21",
          @"name": @"Marshall Islands",
          @"value": @53127
          }, @{
          @"id": @"3.223",
          @"parent": @"2.21",
          @"name": @"Palau",
          @"value": @21729
          }, @{
          @"id": @"3.224",
          @"parent": @"2.21",
          @"name": @"Nauru",
          @"value": @11359
          },
      
  @{
          @"id": @"2.22",
          @"parent": @"1.5",
          @"name": @"Polynesia"
          },
      
  @{
          @"id": @"3.225",
          @"parent": @"2.22",
          @"name": @"French Polynesia",
          @"value": @283007
          }, @{
          @"id": @"3.226",
          @"parent": @"2.22",
          @"name": @"Samoa",
          @"value": @196440
          }, @{
          @"id": @"3.227",
          @"parent": @"2.22",
          @"name": @"Tonga",
          @"value": @108020
          }, @{
          @"id": @"3.228",
          @"parent": @"2.22",
          @"name": @"American Samoa",
          @"value": @55641
          }, @{
          @"id": @"3.229",
          @"parent": @"2.22",
          @"name": @"Cook Islands",
          @"value": @17380
          }, @{
          @"id": @"3.230",
          @"parent": @"2.22",
          @"name": @"Wallis and Futuna",
          @"value": @11773
          }, @{
          @"id": @"3.231",
          @"parent": @"2.22",
          @"name": @"Tuvalu",
          @"value": @11192
          }, @{
          @"id": @"3.232",
          @"parent": @"2.22",
          @"name": @"Niue",
          @"value": @1618
          }, @{
          @"id": @"3.233",
          @"parent": @"2.22",
          @"name": @"Tokelau",
          @"value": @1300
          }];
    
    
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
    
    NSArray *seriesElementArr = @[ AASeriesElement.new
                                   .typeSet(@"sunburst")
                                   .allowDrillToNodeSet(true)
                                   .levelsSet(@[@{
                                                    @"level":@2,
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

- (AAOptions *)configureTheNoGapColunmChart {
    AAChartModel *aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeColumn)//图表类型
    .titleSet(@"Y轴在右侧的柱状图📊")//图表主标题
    .subtitleSet(@"设置 aaOptions.yAxis.opposite = YES 即可")//图表副标题
    .colorsThemeSet(@[@"#ffc069",@"#fe117c",@"#06caf4",@"#7dffc0"])//设置主体颜色数组
    .yAxisTitleSet(@"摄氏度℃")//设置 Y 轴标题
    .tooltipValueSuffixSet(@"℃")//设置浮动提示框单位后缀
    .yAxisGridLineWidthSet(@1)//y轴横向分割线宽度为0(即是隐藏分割线)
    .xAxisGridLineWidthSet(@0.5)
    .markerRadiusSet(@0)
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"2020")
                 .dataSet(@[@3.9, @4.2, @5.7, @8.5, @11.9, @15.2,]),
                 ]
               );
    
    AAOptions *aaOptions = [AAOptionsConstructor configureChartOptionsWithAAChartModel:aaChartModel];
    //是否将坐标轴显示在对立面，默认情况下 x 轴是在图表的下方显示，y 轴是在左方，
    //坐标轴显示在对立面后，x 轴是在上方显示，y 轴是在右方显示（即坐标轴会显示在对立面）。
    //该配置一般是用于多坐标轴区分展示，另外在 Highstock 中，y 轴默认是在对立面显示的。
    //默认是：false.
    aaOptions.yAxis.opposite = YES;
    
    
//    aaOptions.plotOptions.column.groupPadding = @0;//设置棱柱之间的间距百分比
//    aaOptions.plotOptions.column.dataLabels = (id)@{
//                                                @"enabled": @(true),
//                                                @"verticalAlign": @"bottom",
//                                                @"y": @(-10),
//                                                @"shape":@"callout",
//                                                @"backgroundColor":@"rgba(0, 0, 0, 0.75)",
//                                                @"style": @{
//                                                        @"color":@"#FFFFFF",
//                                                        @"textOutline":@"none"
//                                                        }
//                                                };
    return aaOptions;
}

- (AAOptions *)configureCustomStyleTooltipChart {
    AAChartModel *aaChartModel = AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeArea)//图表类型
    .titleSet(@"近三个月金价起伏周期图")//图表主标题
    .subtitleSet(@"金价(元/克)")//图表副标题
    .colorsThemeSet(@[@"#FFD700"/*(纯金色)*/,@"#ffc069",@"#06caf4",@"#7dffc0"])//设置主体颜色数组
    .symbolStyleSet(AAChartSymbolStyleTypeBorderBlank)//折线连接点样式为外边缘空白
    .xAxisTickIntervalSet(@15)//x轴刻度点间隔数(设置每隔几个点显示一个 X轴的内容)
    .yAxisTitleSet(@"")//设置 Y 轴标题
    .yAxisGridLineWidthSet(@0.8)//y轴横向分割线宽度(为0即是隐藏分割线)
    .categoriesSet(@[
                     @"10-01",@"10-02",@"10-03",@"10-04",@"10-05",@"10-06",@"10-07",@"10-08",@"10-09",@"10-10",@"10-11",
                     @"10-12",@"10-13",@"10-14",@"10-15",@"10-16",@"10-17",@"10-18",@"10-19",@"10-20",@"10-21",@"10-22",
                     @"10-23",@"10-024",@"10-25",@"10-26",@"10-27",@"10-28",@"10-29",@"10-30",@"10-31",@"11-01",@"11-02",
                     @"11-03",@"11-04",@"11-05",@"11-06",@"11-07",@"11-08",@"11-09",@"11-10",@"11-11",@"11-12",@"11-13",
                     @"11-14",@"11-15",@"11-16",@"11-17",@"11-18",@"11-19",@"11-20",@"11-21",@"11-22",@"11-23",@"11-024",
                     @"11-25",@"11-26",@"11-27",@"11-28",@"11-29",@"11-30",@"12-01",@"12-02",@"12-03",@"12-04",@"12-05",
                     @"12-06",@"12-07",@"12-08",@"12-09",@"12-10",@"12-11",@"12-12",@"12-13",@"12-14",@"12-15",@"12-16",
                     @"12-17",@"12-18",@"12-19",@"12-20",@"12-21",@"12-22",@"12-23",@"12-024",@"12-25",@"12-26",@"12-27",
                     @"12-28",@"12-29",@"12-30"])
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .lineWidthSet(@1.5)
                 .fillOpacitySet(@0.4)
                 .nameSet(@"2018")
                 .dataSet(
                          @[@1.51, @6.7, @0.94, @1.44, @1.6, @1.63, @1.56, @1.91, @2.45, @3.87, @3.24, @4.90, @4.61, @4.10,
                            @4.17, @3.85, @4.17, @3.46, @3.46, @3.55, @3.50, @4.13, @2.58, @2.28,@1.51, @12.7, @0.94, @1.44,
                            @18.6, @1.63, @1.56, @1.91, @2.45, @3.87, @3.24, @4.90, @4.61, @4.10, @4.17, @3.85, @4.17, @3.46,
                            @3.46, @3.55, @3.50, @4.13, @2.58, @2.28,@1.33, @4.68, @1.31, @1.10, @13.9, @1.10, @1.16, @1.67,
                            @2.64, @2.86, @3.00, @3.21, @4.14, @4.07, @3.68, @3.11, @3.41, @3.25, @3.32, @3.07, @3.92, @3.05,
                            @2.18, @3.24,@3.23, @3.15, @2.90, @1.81, @2.11, @2.43, @5.59, @3.09, @4.09, @6.14, @5.33, @6.05,
                            @5.71, @6.22, @6.56, @4.75, @5.27, @6.02, @5.48])
                 ]
               );
    
    /*Custom Tooltip Style --- 自定义图表浮动提示框样式及内容*/
    AAOptions *options = [AAOptionsConstructor configureChartOptionsWithAAChartModel:aaChartModel];
    AATooltip *tooltip = options.tooltip;
    tooltip
    .useHTMLSet(true)
    .headerFormatSet(@"{series.name}-<b>{point.key}</b> &nbsp12:00<br>")
    .pointFormatSet(@"<b>{point.y}</b>&nbsp元/克")
    .valueDecimalsSet(@2)//设置取值精确到小数点后几位
    .backgroundColorSet(@"#000000")
    .borderColorSet(@"#000000")
    .styleSet(@{@"color":@"#FFD700"/*(纯金色)*/,
                @"fontSize":@"12px",})
    ;

    return options;
    
    
}

- (AAOptions *)adjustChartLeftAndRightMargin {
    AAChartModel *aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeColumn)//图表类型
    .titleSet(@"")//图表主标题
    .subtitleSet(@"")//图表副标题
    .colorsThemeSet(@[@"#fe117c",@"#ffc069",@"#06caf4",@"#7dffc0"])//设置主体颜色数组
    .yAxisTitleSet(@"")//设置 Y 轴标题
    .polarSet(true)
    .categoriesSet(@[@"Java", @"Swift", @"Python", @"Ruby", @"PHP", @"Go", @"C", @"C#", @"C++", @"Perl", @"R", @"MATLAB", @"SQL"])
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"2017")
                 .dataSet(@[@7.0, @6.9, @9.5, @14.5, @18.2, @21.5, @25.2, @26.5, @23.3, @18.3, @13.9, @9.6]),
                 ]
               );
    
    AAOptions *aaOptions = [AAOptionsConstructor configureChartOptionsWithAAChartModel:aaChartModel];
    aaOptions.chart.marginLeft = @70;
    aaOptions.chart.marginRight = @70;
    return aaOptions;
}

- (AAOptions *)configureChartWithBackgroundImage {
    AAChartModel *aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypePie)
    .titleSet(@"编程语言热度")
    .subtitleSet(@"虚拟数据")
    .dataLabelEnabledSet(true)//是否直接显示扇形图数据
    .yAxisTitleSet(@"摄氏度")
    .seriesSet(
               @[AAObject(AASeriesElement)
                 .nameSet(@"语言热度占比")
                 .dataSet(@[
                            @[@"Java"  , @67],
                            @[@"Swift" , @44],
                            @[@"Python", @83],
                            @[@"OC"    , @11],
                            @[@"Ruby"  , @42],
                            @[@"PHP"   , @31],
                            @[@"Go"    , @63],
                            @[@"C"     , @24],
                            @[@"C#"    , @888],
                            @[@"C++"   , @66],
                            ]),
                 ]
               )
    ;
    
    AAOptions *aaOptions = [AAOptionsConstructor configureChartOptionsWithAAChartModel:aaChartModel];
    aaOptions.chart.plotBackgroundImage = @"https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2859216016,2109779587&fm=27&gp=0.jpg";
    return aaOptions;
}

- (AAOptions *)configureDoubleYAxisChartOptions {
    AATitle *aaTitle = AAObject(AATitle)
    .textSet(@"双Y轴混合图");
    
    AALabels *labels = (AAObject(AALabels)
                        .enabledSet(true)//设置 y 轴是否显示数字
                        .styleSet(AAObject(AAStyle)
                                  .colorSet(@"#ff0000")//yAxis Label font color
                                  .fontSizeSet(@"15px")//yAxis Label font size
                                  .fontWeightSet(AAChartFontWeightTypeBold)//yAxis Label font weight
                                  )
                        .formatSet(@"{value:.,0f}°C")//让y轴的值完整显示 而不是100000显示为100k,同时单位后缀为°C
                        );
    
    AAYAxis *yAxisOne = AAObject(AAYAxis)
    .visibleSet(true)
    .labelsSet(labels)
    .titleSet(AAObject(AATitle)
              .textSet(@"温度")
              )
    .oppositeSet(true);
    
    
    AAYAxis *yAxisTwo = AAObject(AAYAxis)
    .visibleSet(true)
    .labelsSet(labels.formatSet(@"{value}mm"))
    .titleSet(AAObject(AATitle)
              .textSet(@"降雨量")
              );
    
    
    NSArray *yAxisArr = @[yAxisOne,// Primary yAxis
                          yAxisTwo // Secondary yAxis
                          ];
    AATooltip *aaTooltip = AAObject(AATooltip).sharedSet(true).enabledSet(true);
    NSArray *aaSeries = @[
                          AAObject(AASeriesElement)
                          .nameSet(@"2017")
                          .typeSet(AAChartTypeColumn)
                          .yAxisSet(@1)
                          .dataSet(@[@7.0, @6.9, @9.5, @14.5, @18.2, @21.5, @25.2, @26.5, @23.3, @18.3, @13.9, @9.6])
                          .dataLabelsSet(AAObject(AADataLabels)
                                         .enabledSet(true)
                                         )
                          ,
                          AAObject(AASeriesElement)
                          .nameSet(@"2018")
                          .typeSet(AAChartTypeLine)
                          .dataSet(@[@0.2, @0.8, @5.7, @11.3, @17.0, @22.0, @24.8, @24.1, @20.1, @14.1, @8.6, @2.5])
                          .dataLabelsSet(AAObject(AADataLabels)
                                         .enabledSet(true)
                                         )
                          ];
    
    AAOptions *chartOptions = AAObject(AAOptions);
    chartOptions.title = aaTitle;
    chartOptions.yAxis = (id)yAxisArr;
    chartOptions.tooltip = aaTooltip;
    chartOptions.series = aaSeries;
    chartOptions.chart = AAObject(AAChart);
    
    return chartOptions;
}


- (AAOptions *)adjustChartSeriesDataAccuracy {
    AAChartModel *aaChartModel = AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeArea)
    .titleSet(@"Adjust data accuracy")
    .yAxisTitleSet(@"")
    .dataLabelEnabledSet(true)
    .symbolSet(AAChartSymbolTypeCircle)
    .markerRadiusSet(@6)//设置折线连接点宽度为0,即是隐藏连接点
    .yAxisGridLineWidthSet(@0.5)
    .symbolStyleSet(AAChartSymbolStyleTypeInnerBlank)
    .seriesSet(@[AAObject(AASeriesElement)
                 .nameSet(@"2017")
                 .dataSet(@[@(0.0000001),@(0.0000002),@(0.0000003),@(0.0000004),@(0.0000005)])
                 .lineWidthSet(@5)
                 ]
               );
    //数值格式化字符串是采用了 C 语言浮点型格式化的子集，格式化字符是在大括号内，变量之后，用冒号（:）分隔的内容。
    //默认情况下点号（.）表示小数点，空格（ ）代表千分符，当然这两个符号可以在 语言文字 选项集里中来设定。
    //具体参见 https://www.hcharts.cn/docs/basic-labels-string-formatting#h2-1
    AAOptions *aaOptions = [AAOptionsConstructor configureChartOptionsWithAAChartModel:aaChartModel];
    aaOptions.tooltip.valueDecimals = @9;//设置tooltip取值精确到小数点后9位
    aaOptions.plotOptions.area.dataLabels.format = @"{point.y:.9f}";//设置dataLabels取值精确到小数点后9位

    return aaOptions;
}

- (AAOptions *)adjustGroupPaddingForPolarChart {
    AAChartModel *aaChartModel = AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeColumn)
    .titleSet(@"Colorful Column Chart")
    .subtitleSet(@"single data array colorful column chart")
    .borderRadiusSet(@5)
    .polarSet(true)
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"2017")
                 .dataSet(@[@211,@183,@157,@133,@111]),
                 ]
               );
    AAOptions *aaOptions = [AAOptionsConstructor configureChartOptionsWithAAChartModel:aaChartModel];
    AAColumn *aaColumn = aaOptions.plotOptions.column;
    aaOptions.tooltip.hideDelay = @0;
    aaColumn.groupPadding = @0.05;
    aaColumn.colorByPoint = true;
    
    return aaOptions;
    
}

- (AAOptions *)customStyleStackedColumnChart {
    
    //Method 1
    AAChart *aaChart = AAObject(AAChart)
                        .typeSet(AAChartTypeColumn);

    AATitle *aaTitle = AAObject(AATitle)
                        .textSet(@"Stacked column chart");

    AAXAxis *aaXAsix = AAObject(AAXAxis)
                        .visibleSet(true)
                        .categoriesSet(@[@"Apples", @"Oranges", @"Pears", @"Grapes", @"Bananas"]);

    AAYAxis *aaYAxis = AAObject(AAYAxis)
                        .visibleSet(true)
                        .minSet(@0)
                        .titleSet(AAObject(AATitle)
                                  .textSet(@"Total fruit consumption")
                                  )
                        .stackLabelsSet(AAObject(AALabels)
                                        .enabledSet(true)
                                        .styleSet(AAObject(AAStyle)
                                                  .fontWeightSet(AAChartFontWeightTypeBold)
                                                  )
                                        );

    AALegend *aaLegend = AAObject(AALegend)
                          .enabledSet(true)
                          .alignSet(AALegendAlignTypeRight)
                          .xSet(@(-30))
                          .verticalAlignSet(AALegendVerticalAlignTypeTop)
                          .ySet(@25)
                          .borderColorSet(@"#ccc")
                          .borderWidthSet(@1);

    AATooltip *aaTooltip = AAObject(AATooltip)
                            .headerFormatSet(@"<b>{point.x}</b><br/>")
                            .pointFormatSet(@"{series.name}: {point.y}<br/>Total: {point.stackTotal}");

    AAPlotOptions *aaPlotOptions = AAObject(AAPlotOptions)
                                    .seriesSet(AAObject(AASeries)
                                               .animationSet(AAObject(AAAnimation)
                                                             .easingSet(AAChartAnimationBounce)
                                                             .durationSet(@1000)
                                                             )
                                               )
                                    .columnSet(AAObject(AAColumn)
                                               .stackingSet(AAChartStackingTypeNormal)
                                               .dataLabelsSet(AAObject(AADataLabels)
                                                              .enabledSet(true)
                                                              )
                                               );

    NSArray *seriesElementArr = @[
                                  AAObject(AASeriesElement)
                                  .nameSet(@"John")
                                  .dataSet(@[@5, @3, @4, @7, @2]),
                                  AAObject(AASeriesElement)
                                  .nameSet(@"Jane")
                                  .dataSet(@[@5, @3, @4, @7, @2]),
                                  AAObject(AASeriesElement)
                                  .nameSet(@"Joe")
                                  .dataSet(@[@5, @3, @4, @7, @2]),
                                  ];

    AAOptions *aaOptions = AAObject(AAOptions)
    .chartSet(aaChart)
    .titleSet(aaTitle)
    .xAxisSet(aaXAsix)
    .yAxisSet(aaYAxis)
    .legendSet(aaLegend)
    .tooltipSet(aaTooltip)
    .plotOptionsSet(aaPlotOptions)
    .seriesSet(seriesElementArr);

    return aaOptions;
    



     // Method 2
    AAOptions *options2 = AAObject(AAOptions)
    .chartSet(AAObject(AAChart)
              .typeSet(AAChartTypeColumn)
              )
    .titleSet(AAObject(AATitle)
              .textSet(@"Stacked column chart")
              )
    .xAxisSet(AAObject(AAXAxis)
              .visibleSet(true)
              .categoriesSet(@[@"Apples", @"Oranges", @"Pears", @"Grapes", @"Bananas"])
              )
    .yAxisSet(AAObject(AAYAxis)
              .visibleSet(true)
              .minSet(@0)
              .titleSet(AAObject(AATitle)
                        .textSet(@"Total fruit consumption")
                        )
              .stackLabelsSet(AAObject(AALabels)
                              .enabledSet(true)
                              .styleSet(AAObject(AAStyle)
                                        .fontWeightSet(AAChartFontWeightTypeBold)
                                        )
                              )
              )
    .legendSet(AAObject(AALegend)
               .enabledSet(true)
               .alignSet(AALegendAlignTypeRight)
               .xSet(@(-30))
               .verticalAlignSet(AALegendVerticalAlignTypeTop)
               .ySet(@25)
               .borderColorSet(@"#ccc")
               .borderWidthSet(@1)
               )
    .tooltipSet(AAObject(AATooltip)
                .headerFormatSet(@"<b>{point.x}</b><br/>")
                .pointFormatSet(@"{series.name}: {point.y}<br/>Total: {point.stackTotal}")
                )
    .plotOptionsSet(AAObject(AAPlotOptions)
                    .seriesSet(AAObject(AASeries)
                               .animationSet(AAObject(AAAnimation)
                                             .easingSet(AAChartAnimationBounce)
                                             .durationSet(@1000)
                                             )
                               )
                    .columnSet(AAObject(AAColumn)
                               .stackingSet(AAChartStackingTypeNormal)
                               .dataLabelsSet(AAObject(AADataLabels)
                                              .enabledSet(true)
                                              )
                               )
                    )
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"John")
                 .dataSet(@[@5, @3, @4, @7, @2]),
                 AAObject(AASeriesElement)
                 .nameSet(@"Jane")
                 .dataSet(@[@5, @3, @4, @7, @2]),
                 AAObject(AASeriesElement)
                 .nameSet(@"Joe")
                 .dataSet(@[@5, @3, @4, @7, @2]),
                 ]);

    return options2;
    
    //Method 3
    AAOptions *options3 = (id)@{
                            @"chart": @{
                                    @"type": @"column"
                                    },
                            @"title": @{
                                    @"text": @"Stacked column chart"
                                    },
                            @"xAxis": @{
                                    @"categories": @[@"Apples", @"Oranges", @"Pears", @"Grapes", @"Bananas"]
                                    },
                            @"yAxis": @{
                                    @"min": @0,
                                    @"title": @{
                                            @"text": @"Total fruit consumption"
                                            },
                                    @"stackLabels": @{
                                            @"enabled": @(true),
                                            @"style": @{
                                                    @"fontWeight": @"bold",
                                                    }
                                            }
                                    },
                            @"legend": @{
                                    @"align": @"right",
                                    @"x": @-30,
                                    @"verticalAlign": @"top",
                                    @"y": @25,
                                    @"floating": @(true),
                                    
                                    @"borderColor": @"#CCC",
                                    @"borderWidth": @1,
                                    @"shadow": @(false)
                                    },
                            @"tooltip": @{
                                    @"headerFormat": @"<b>{point.x}</b><br/>",
                                    @"pointFormat": @"{series.name}: {point.y}<br/>Total: {point.stackTotal}"
                                    },
                            @"plotOptions": @{
                                    @"series":@{
                                            @"animation":@{
                                                    @"easing":@(AAChartAnimationBounce),
                                                    @"duration":@1000
                                                    }
                                            },
                                    @"column": @{
                                            @"stacking": @"normal",
                                            @"dataLabels": @{
                                                    @"enabled": @(true),
                                                    
                                                    }
                                            }
                                    },
                            @"series": @[@{
                                             @"name": @"John",
                                             @"data": @[@5, @3, @4, @7, @2]
                                             }, @{
                                             @"name": @"Jane",
                                             @"data": @[@2, @2, @3, @2, @1]
                                             }, @{
                                             @"name": @"Joe",
                                             @"data": @[@3, @4, @4, @2, @5]
                                             }]
                            };
    
    return options3;
}

- (AAOptions *)specialStyleStepLineChart {
    
    //Method 1
    AAChartModel *aaChartModel = AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeLine)//图形类型
    .animationTypeSet(AAChartAnimationBounce)//图形渲染动画类型为"bounce"
    .titleSet(@"STEP LINE CHART")//图形标题
    .subtitleSet(@"2020/08/08")//图形副标题
    .dataLabelEnabledSet(NO)//是否显示数字
    .symbolStyleSet(AAChartSymbolStyleTypeBorderBlank)//折线连接点样式
    .markerRadiusSet(@7)//折线连接点半径长度,为0时相当于没有折线连接点
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"價格")
                 .colorSet(@"#003386")
                 .stepSet(@true)
                 .dataSet(@[
                            @[AADateUTC(2016, 9 - 1, 2),   @389.00],
                            @[AADateUTC(2016, 10 - 1, 4),  @350.10],
                            @[AADateUTC(2016, 10 - 1, 4),  @350.10],
                            @[AADateUTC(2016, 10 - 1, 17), @389.00],
                            @[AADateUTC(2016, 11 - 1, 24), @233.40],
                            @[AADateUTC(2016, 11 - 1, 29), @389.00],
                            @[AADateUTC(2016, 12 - 1, 20), @233.40],
                            @[AADateUTC(2017, 1 - 1, 5),   @389.00],
                            @[AADateUTC(2017, 2 - 1, 1),   @233.40],
                            @[AADateUTC(2017, 2 - 1, 9),   @389.00],
                            @[AADateUTC(2017, 4 - 1, 26),  @233.40],
                            @[AADateUTC(2017, 5 - 1, 9),   @389.00],
                            @[AADateUTC(2017, 7 - 1, 19),  @291.75],
                            @[AADateUTC(2017, 8 - 1, 2),   @389.00],
                            @[AADateUTC(2017, 10 - 1, 18), @155.60],
                            @[AADateUTC(2017, 10 - 1, 31), @389.00],
                            @[AADateUTC(2017, 11 - 1, 21), @194.50],
                            @[AADateUTC(2017, 11 - 1, 28), @389.00],
                            @[AADateUTC(2017, 11 - 1, 29), @194.50],
                            @[AADateUTC(2017, 12 - 1, 13), @389.00],
                            @[AADateUTC(2017, 12 - 1, 25), @194.50],
                            @[AADateUTC(2018, 1 - 1, 9),   @389.00],
                            @[AADateUTC(2018, 2 - 1, 8),   @194.50],
                            @[AADateUTC(2018, 2 - 1, 21),  @389.00],
                            @[AADateUTC(2018, 3 - 1, 8),   @155.60],
                            @[AADateUTC(2018, 3 - 1, 18),  @389.00],
                            @[AADateUTC(2018, 6 - 1, 8),   @155.60],
                            @[AADateUTC(2018, 6 - 1, 18),  @389.00],
                            @[AADateUTC(2018, 7 - 1, 12),  @194.50],
                            //                                      @[Date.now(), @194.50]
                            ]),
                 AAObject(AASeriesElement)
                 .nameSet(@"PS+")
                 .colorSet(@"#FFC535")
                 .stepSet(@true)
                 .dataSet(@[
                            @[AADateUTC(2016, 9 - 1, 2),   @389.00],
                            @[AADateUTC(2016, 10 - 1, 4),  @311.20],
                            @[AADateUTC(2016, 10 - 1, 4),  @311.20],
                            @[AADateUTC(2016, 10 - 1, 17), @389.00],
                            @[AADateUTC(2016, 11 - 1, 24), @233.40],
                            @[AADateUTC(2016, 11 - 1, 29), @389.00],
                            @[AADateUTC(2016, 12 - 1, 20), @233.40],
                            @[AADateUTC(2017, 1 - 1, 5),   @389.00],
                            @[AADateUTC(2017, 2 - 1, 1),   @194.50],
                            @[AADateUTC(2017, 2 - 1, 9),   @389.00],
                            @[AADateUTC(2017, 4 - 1, 26),  @194.50],
                            @[AADateUTC(2017, 5 - 1, 9),   @389.00],
                            @[AADateUTC(2017, 7 - 1, 19),  @194.50],
                            @[AADateUTC(2017, 8 - 1, 2),   @389.00],
                            @[AADateUTC(2017, 10 - 1, 18), @155.60],
                            @[AADateUTC(2017, 10 - 1, 31), @389.00],
                            @[AADateUTC(2017, 11 - 1, 21), @155.60],
                            @[AADateUTC(2017, 11 - 1, 28), @389.00],
                            @[AADateUTC(2017, 11 - 1, 29), @155.60],
                            @[AADateUTC(2017, 12 - 1, 13), @389.00],
                            @[AADateUTC(2017, 12 - 1, 25), @155.60],
                            @[AADateUTC(2018, 1 - 1, 9),   @389.00],
                            @[AADateUTC(2018, 2 - 1, 8),   @155.60],
                            @[AADateUTC(2018, 2 - 1, 21),  @389.00],
                            @[AADateUTC(2018, 3 - 1, 8),   @155.60],
                            @[AADateUTC(2018, 3 - 1, 18),  @389.00],
                            @[AADateUTC(2018, 6 - 1, 8),   @155.60],
                            @[AADateUTC(2018, 6 - 1, 18),  @389.00],
                            @[AADateUTC(2018, 7 - 1, 12),  @155.60],
                            //                                      @[Date.now(), @155.60]
                            ]),
                 ]
               )
    ;
    AAOptions *aaOptions = [AAOptionsConstructor configureChartOptionsWithAAChartModel:aaChartModel];
    NSDictionary *xAxisDic = @{
                               @"type": @"datetime",
                               @"dateTimeLabelFormats": @{
                                       @"month": @"%e.%m.%y"
                                       }
                               };
    
    aaOptions.xAxis = (id)xAxisDic;
//    return aaOptions;
    
 //Method 2
  NSDictionary *aaOptions2 = @{
                   @"title": @false,
                   @"credits": @false,
                   @"chart": @{
                           @"type": @"line",
                           @"backgroundColor": @"#ffffff"
                           },
                   @"plotOptions": @{
                           @"series":@{
                                   @"animation":@{
                                           @"easing":@(AAChartAnimationLinear),
                                           @"duration":@1000
                                           }
                                   },
                           @"line": @{
                                   @"color": @"#003386",
                                   @"lineWidth": @1,
                                   @"dataLabels": @{
                                           @"enabled": @false,
                                           @"backgroundColor": @"rgba(255, 255, 255, 1.0)",
                                           @"format": @"{y} HK$",
                                           @"zIndex": @3
                                           },
                                   @"enableMouseTracking": @true,
                                   @"marker": @{
                                           @"fillColor": @"white",
                                           @"symbol": @"circle",
                                           @"lineWidth": @1,
                                           @"lineColor": @"#003386"
                                           }
                                   }
                           },
                   @"legend": @{
                           @"layout": @"horizontal",
                           @"align": @"left",
                           @"verticalAlign": @"bottom"
                           },
                   @"tooltip": @{
                           @"shared": @true,
                           @"shadow": @false,
                           @"crosshairs": @true,
                           @"backgroundColor": @"#fff",
                           @"borderColor": @"#5177b4",
                           @"borderWidth": @1,
                           @"xDateFormat": @"%Y-%m-%d",
                           @"valueSuffix": @"  HK$"
                           },
                   @"xAxis": @{
                           @"type": @"datetime",
                           @"dateTimeLabelFormats": @{
                                   @"month": @"%e.%m.%y"
                                   }
                           },
                   @"yAxis": @{
                           @"title": @false,
                           @"tickPixelInterval": @40,
                           @"alternateGridColor": @"#fafafa",
                           @"gridLineColor": @"#f0f0f0",
                           @"gridLineDashStyle": @"dash",
                           @"labels": @{
                                   @"enabled": @true,
                                   @"format": @"{value} HK$"
                                   },
                           @"min": @0,
                           @"showFirstLabel": @false
                           },
                   @"series": @[@{
                                     @"zIndex": @2,
                                     @"name": @"價格",
                                     @"color": @"#003386",
                                     @"step": @"left",
                                     @"data": @[
                                             @[@1472774400000, @389],
                                             @[@1475539200000, @350.1],
                                             @[@1475539200000, @350.1],
                                             @[@1476662400000, @389],
                                             @[@1479945600000, @233.4],
                                             @[@1480377600000, @389],
                                             @[@1482192000000, @233.4],
                                             @[@1483574400000, @389],
                                             @[@1485907200000, @233.4],
                                             @[@1486598400000, @389],
                                             @[@1493164800000, @233.4],
                                             @[@1494288000000, @389],
                                             @[@1500422400000, @291.75],
                                             @[@1501632000000, @389],
                                             @[@1508284800000, @155.6],
                                             @[@1509408000000, @389],
                                             @[@1511222400000, @194.5],
                                             @[@1511827200000, @389],
                                             @[@1511913600000, @194.5],
                                             @[@1513123200000, @389],
                                             @[@1514160000000, @194.5],
                                             @[@1515456000000, @389],
                                             @[@1518048000000, @194.5],
                                             @[@1519171200000, @389],
                                             @[@1520467200000, @155.6],
                                             @[@1521331200000, @389],
                                             @[@1528416000000, @155.6],
                                             @[@1529280000000, @389],
                                             @[@1531353600000, @194.5],
                                             @[@1532052447381, @194.5]
                                             ]
                                     }, @{
                                     @"zIndex": @1,
                                     @"name": @"PS+",
                                     @"color": @"#FFC535",
                                     @"marker": @{
                                             @"lineColor": @"#FFC535"
                                             },
                                     @"step": @"left",
                                     @"data": @[
                                             @[@1472774400000, @389],
                                             @[@1475539200000, @311.2],
                                             @[@1475539200000, @311.2],
                                             @[@1476662400000, @389],
                                             @[@1479945600000, @233.4],
                                             @[@1480377600000, @389],
                                             @[@1482192000000, @233.4],
                                             @[@1483574400000, @389],
                                             @[@1485907200000, @194.5],
                                             @[@1486598400000, @389],
                                             @[@1493164800000, @194.5],
                                             @[@1494288000000, @389],
                                             @[@1500422400000, @194.5],
                                             @[@1501632000000, @389],
                                             @[@1508284800000, @155.6],
                                             @[@1509408000000, @389],
                                             @[@1511222400000, @155.6],
                                             @[@1511827200000, @389],
                                             @[@1511913600000, @155.6],
                                             @[@1513123200000, @389],
                                             @[@1514160000000, @155.6],
                                             @[@1515456000000, @389],
                                             @[@1518048000000, @155.6],
                                             @[@1519171200000, @389],
                                             @[@1520467200000, @155.6],
                                             @[@1521331200000, @389],
                                             @[@1528416000000, @155.6],
                                             @[@1529280000000, @389],
                                             @[@1531353600000, @155.6],
                                             @[@1532052447381, @155.6]
                                             ]
                                     }]
                   };

    return aaOptions2;
}

- (AAOptions *)disableChartAnimation {
    AAChartModel *aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeColumn)//图表类型
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"2018")
                 .dataSet(@[@0.2, @0.8, @5.7, @11.3, @17.0, @22.0, @24.8, @24.1, @20.1, @14.1, @8.6, @2.5]),
                 ]
               );
    AAOptions *aaOptions = [AAOptionsConstructor configureChartOptionsWithAAChartModel:aaChartModel];
    aaOptions.plotOptions.series.animation = (id)@(false);//禁用图表的渲染动画效果
    return aaOptions;
}


- (AAOptions *)customChartLengendItemStyle {
    
    AAChartModel *aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(AAChartTypeLine)
    .titleSet(@"")
    .subtitleSet(@"")
    .categoriesSet(@[@"Java",@"Swift",@"Python",@"Ruby", @"PHP",@"Go",@"C",@"C#",@"C++",@"Perl",@"R",@"MATLAB",@"SQL"])
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"2018")
                 .dataSet(@[@31,@22,@33,@54,@35,@36,@27,@38,@39,@54,@41,@29]),
                 ]
               );

    //设定图例项的CSS样式。只支持有关文本的CSS样式设定。 默认是：{ "color": "#333333", "cursor": "pointer", "fontSize": "12px", "fontWeight": "bold" }.
    AAItemStyle *aaItemStyle = AAObject(AAItemStyle)
    .colorSet(@"#ff0000")//字体颜色
    .cursorSet(@"pointer")//(在移动端这个属性没什么意义,其实不用设置)指定鼠标滑过数据列时鼠标的形状。当绑定了数据列点击事件时，可以将此参数设置为 "pointer"，用来提醒用户改数据列是可以点击的。
    .fontSizeSet(@"20px")//字体大小
    .fontWeightSet(AAChartFontWeightTypeThin);//字体为细体字
    
    
    
    AAOptions *aaOptions = [AAOptionsConstructor configureChartOptionsWithAAChartModel:aaChartModel];
    aaOptions.legend.itemStyle = aaItemStyle;
//    aaOptions.xAxis.tickmarkPlacement = @"on";//本参数只对分类轴有效。 当值为 on 时刻度线将在分类上方显示；当值为 between 时，刻度线将在两个分类中间显示。当 tickInterval 为 1 时，默认是 between，其他情况默认是 on。 默认是：null.
//    aaOptions.yAxis.minPadding = @0;
    aaOptions.yAxis.lineWidth = @0;
    
    return aaOptions;
}

@end
