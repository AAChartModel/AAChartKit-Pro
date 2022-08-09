
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
 * StackOverflow : https://stackoverflow.com/users/12302132/codeforu
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
        case  0: return [self sunburstChart];
        case  1: return [self streamgraphChart];
        case  2: return [self vectorChart];
        case  3: return [self bellcurveChart];
        case  4: return [self timelineChart];
        case  5: return [self itemChart];
        case  6: return [self windbarbChart];
        case  7: return [self wordcloudChart];
        case  8: return [self flameChart];
        case  9: return [self itemChart2];
        case 10: return [self itemChart3];
        case 11: return [self icicleChart];
        case 12: return [self sunburstChart2];
        case 13: return [self solidgaugeChart];
        case 14: return [self parallelCoordinatesSplineChart];
        case 15: return [self parallelCoordinatesLineChart];

    }
    return [self sunburstChart];
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
            AALevelsElement.new
            .levelSet(@2)
            .colorByPointSet(@true)
            .layoutAlgorithmSet(@"sliceAndDice")
            ,
            AALevelsElement.new
            .levelSet(@3)
            .colorVariationSet(AAColorVariation.new
                               .keySet(@"brightness")
                               .toSet(@-0.5))
            ,
            AALevelsElement.new
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
                   .fillColorSet(AAColor.whiteColor)//点的填充色(用来设置折线连接点的填充色)
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
        AAItem.new
        .nameSet(@"Representatives")
        .keysSet(@[@"name",@"y",@"color",@"label"])
        .dataSet(AAOptionsData.itemData)
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(false))
        .startAngleSet(@-100)
        .endAngleSet(@+100)
               ]);
}

- (AAOptions *)itemChart2 {
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
        AAItem.new
        .nameSet(@"Representatives")
        .keysSet(@[@"name",@"y",@"color",@"label"])
        .dataSet(AAOptionsData.itemData)
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(true))
        .startAngleSet((id)NSNull.null)
        .endAngleSet((id)NSNull.null)
               ]);
}

- (AAOptions *)itemChart3 {
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
        AAItem.new
        .nameSet(@"Representatives")
        .keysSet(@[@"name",@"y",@"color",@"label"])
        .dataSet(AAOptionsData.itemData)
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(false))
        .startAngleSet(@0)
        .endAngleSet(@360)
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
                   .fillColorSet(AAColor.whiteColor)//点的填充色(用来设置折线连接点的填充色)
                   .lineWidthSet(@5)//外沿线的宽度(用来设置折线连接点的轮廓描边的宽度)
                   .lineColorSet(@""))//外沿线的颜色(用来设置折线连接点的轮廓描边颜色，当值为空字符串时，默认取数据点或数据列的颜色))
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

- (AAOptions *)flameChart {
    return AAOptions.new
        .chartSet(AAChart.new
            .invertedSet(true))
        .titleSet(AATitle.new
            .alignSet(AAChartAlignTypeLeft)
            .textSet(@"Flame chart (layout: flame)"))
        .subtitleSet(AASubtitle.new
            .alignSet(AAChartAlignTypeLeft)
            .textSet(@"Highcharts chart rendering process"))
        .legendSet(AALegend.new
            .enabledSet(false))
        .xAxisSet((id)@[
            AAXAxis.new
                .visibleSet(false),
            AAXAxis.new
                .reversedSet(true)
                .visibleSet(false)
                .startOnTickSet(false)
                .endOnTickSet(false)
                .minPaddingSet(@0)
                .maxPaddingSet(@0)
            ])
        .yAxisSet((id)@[
            AAYAxis.new
                .visibleSet(false),
            AAYAxis.new
                .visibleSet(false)
                .minSet(@0)
                .maxPaddingSet(@0)
                .startOnTickSet(false)
                .endOnTickSet(false)
            ])
        .seriesSet(@[
            AASeriesElement.new
                .typeSet(AAChartTypeFlame)
                .dataSet(AAOptionsData.flameData)
                .yAxisSet(@1)
                .xAxisSet(@1),
            AASeriesElement.new
                .visibleSet(false)
                .sizeSet((id)@"100%")
                .typeSet(AAChartTypeSunburst)
                .dataSet(AAOptionsData.sunburst2Data)
                .allowDrillToNodeSet(true)
                .cursorSet(@"pointer")
                .levelsSet(@[
                    AALevelsElement.new
                        .levelSet(@1)
//                        .levelIsConstantSet(false)
                        .dataLabelsSet(AADataLabels.new
                            .enabledSet(false))
                    ])
                .dataLabelsSet(AADataLabels.new
                    .textPathSet(AATextPath.new
                        .attributesSet(@{@"dy": @5})
                        .enabledSet(true)))
            ])
        .tooltipSet(AATooltip.new
            .headerFormatSet(@"")
            .pointFormatSet(@"selfSize of {point.name} is {point.value}"));
}

- (AAOptions *)icicleChart {
    AAOptions *aaOptions = [self flameChart];
    
    aaOptions.chart.invertedSet(true);
    
    NSArray *axisArr = (id)aaOptions.xAxis;
    AAXAxis *aaXAxisElement = axisArr[1];
    aaXAxisElement.reversedSet(false);
    
    aaOptions.title.textSet(@"Flame chart (layout: icicle)");
    
    AASeriesElement *aaSeriesElement1 = aaOptions.series[0];
    AASeriesElement *aaSeriesElement2 = aaOptions.series[1];
    aaSeriesElement1.visibleSet(true);
    aaSeriesElement2.visibleSet(false);
    
    return aaOptions;
}

- (AAOptions *)sunburstChart2 {
    AAOptions *aaOptions = [self flameChart];
    
    aaOptions.chart.invertedSet(false);
    
    NSArray *axisArr = (id)aaOptions.xAxis;
    AAXAxis *aaXAxisElement = axisArr[1];
    aaXAxisElement.reversedSet(true);
    
    aaOptions.title.textSet(@"Flame chart (layout: icicle)");
    
    AASeriesElement *aaSeriesElement1 = aaOptions.series[0];
    AASeriesElement *aaSeriesElement2 = aaOptions.series[1];
    aaSeriesElement1.visibleSet(false);
    aaSeriesElement2.visibleSet(true);
    
    return aaOptions;
}

- (AAOptions *)solidgaugeChart {
    return AAOptions.new
    .chartSet(AAChart.new
        .typeSet(AAChartTypeSolidgauge)
//        .heightSet(@"110%")
        .eventsSet(AAChartEvents.new
            .loadSet(@AAJSFunc(function () {
                if (!this.series[0].icon) {
                    this.series[0].icon = this.renderer.path(['M', -8, 0, 'L', 8, 0, 'M', 0, -8, 'L', 8, 0, 0, 8])
                        .attr({
                            stroke: '#303030',
                            'stroke-linecap': 'round',
                            'stroke-linejoin': 'round',
                            'stroke-width': 2,
                            zIndex: 10
                        })
                        .add(this.series[2].group);
                }
                this.series[0].icon.translate(
                    this.chartWidth / 2 - 10,
                    this.plotHeight / 2 - this.series[0].points[0].shapeArgs.innerR -
                        (this.series[0].points[0].shapeArgs.r - this.series[0].points[0].shapeArgs.innerR) / 2
                );

                if (!this.series[1].icon) {
                    this.series[1].icon = this.renderer.path(
                        ['M', -8, 0, 'L', 8, 0, 'M', 0, -8, 'L', 8, 0, 0, 8,
                            'M', 8, -8, 'L', 16, 0, 8, 8]
                    )
                        .attr({
                            stroke: '#ffffff',
                            'stroke-linecap': 'round',
                            'stroke-linejoin': 'round',
                            'stroke-width': 2,
                            zIndex: 10
                        })
                        .add(this.series[2].group);
                }
                this.series[1].icon.translate(
                    this.chartWidth / 2 - 10,
                    this.plotHeight / 2 - this.series[1].points[0].shapeArgs.innerR -
                        (this.series[1].points[0].shapeArgs.r - this.series[1].points[0].shapeArgs.innerR) / 2
                );

                if (!this.series[2].icon) {
                    this.series[2].icon = this.renderer.path(['M', 0, 8, 'L', 0, -8, 'M', -8, 0, 'L', 0, -8, 8, 0])
                        .attr({
                            stroke: '#303030',
                            'stroke-linecap': 'round',
                            'stroke-linejoin': 'round',
                            'stroke-width': 2,
                            zIndex: 10
                        })
                        .add(this.series[2].group);
                }

                this.series[2].icon.translate(
                    this.chartWidth / 2 - 10,
                    this.plotHeight / 2 - this.series[2].points[0].shapeArgs.innerR -
                        (this.series[2].points[0].shapeArgs.r - this.series[2].points[0].shapeArgs.innerR) / 2
                );
                })))
              )
    .titleSet(AATitle.new
        .textSet(@"Activity")
        .styleSet(AAStyle.new
            .fontSizeSet(@"24px")))
    .tooltipSet(AATooltip.new
        .borderWidthSet(@0)
        .backgroundColorSet(@"none")
        .shadowSet(false)
        .styleSet(AAStyle.new
            .fontSizeSet(@"16px")
            .textOutlineSet(@"3px"))
        .valueSuffixSet(@"%")
                .pointFormatSet(@"{series.name}<br><span style=""font-size:2em; color: {point.color}; font-weight: bold"">{point.y}</span>")
                .positionerSet(@AAJSFunc(function(labelWidth) {
                    let position = {};
                    position["x"] = (this.chart.chartWidth - labelWidth) / 2 - 100;
                    position["y"] = (this.chart.plotHeight / 2) + 15;
                    return position;
                })))
    .paneSet(AAPane.new
        .startAngleSet(@0)
        .endAngleSet(@360)
        .backgroundSet(@[
            AABackgroundElement.new
                .outerRadiusSet((id)@"112%")
                .innerRadiusSet((id)@"88%")
                .backgroundColorSet(@"rgba(124,181,236,0.3)")
                .borderWidthSet(@0),
            AABackgroundElement.new
                .outerRadiusSet((id)@"87%")
                .innerRadiusSet((id)@"63%")
                .backgroundColorSet(@"rgba(67,67,72,0.3)")
                .borderWidthSet(@0),
            AABackgroundElement.new
                .outerRadiusSet((id)@"62%")
                .innerRadiusSet((id)@"38%")
                .backgroundColorSet(@"rgba(144,237,125,0.3)")
                .borderWidthSet(@0)
            ]))
    .yAxisSet(AAYAxis.new
        .minSet(@0)
        .maxSet(@100)
        .lineWidthSet(@0)
        .tickPositionsSet(@[]))
    .plotOptionsSet(AAPlotOptions.new
        .solidgaugeSet(AASolidgauge.new
            .dataLabelsSet(AADataLabels.new
                .enabledSet(false))
            .linecapSet(@"round")
            .stickyTrackingSet(false)
            .roundedSet(true)))
    .seriesSet(@[
        AASeriesElement.new
            .nameSet(@"Move")
            .dataSet(@[
                AASolidgaugeDataElement.new
                    .colorSet(@"#7cb5ec")
                    .radiusSet(@"112%")
                    .innerRadiusSet(@"88%")
                    .ySet(@80)
                ]),
        AASeriesElement.new
            .nameSet(@"Exercise")
            .dataSet(@[
                AASolidgaugeDataElement.new
                    .colorSet(@"#434348")
                    .radiusSet(@"87%")
                    .innerRadiusSet(@"63%")
                    .ySet(@65)
                ]),
        AASeriesElement.new
            .nameSet(@"Stand")
            .dataSet(@[
                AASolidgaugeDataElement.new
                    .colorSet(@"#90ed7d")
                    .radiusSet(@"62%")
                    .innerRadiusSet(@"39%")
                    .ySet(@50)
                ]),
        AASeriesElement.new
            .nameSet(@"Move")
            .dataSet(@[
                AASolidgaugeDataElement.new
                    .colorSet(@"#f7a35c")
                    .radiusSet(@"38%")
                    .innerRadiusSet(@"28%")
                    .ySet(@80)
                ]),
        AASeriesElement.new
            .nameSet(@"Exercise")
            .dataSet(@[
                AASolidgaugeDataElement.new
                    .colorSet(@"#8085e9")
                    .radiusSet(@"27%")
                    .innerRadiusSet(@"17%")
                    .ySet(@65)
                ]),
        AASeriesElement.new
            .nameSet(@"Stand")
            .dataSet(@[
                AASolidgaugeDataElement.new
                    .colorSet(@"#f15c80")
                    .radiusSet(@"16%")
                    .innerRadiusSet(@"6%")
                    .ySet(@50)
                ])
        ]);
}

- (AAOptions *)parallelCoordinatesSplineChart {
    return AAOptions.new
        .chartSet(AAChart.new
            .typeSet(AAChartTypeSpline)
            .parallelCoordinatesSet(@true)
            .parallelAxesSet(AAParallelAxes.new
                .lineWidthSet(@2)))
        .titleSet(AATitle.new
            .textSet(@"Marathon set"))
        .plotOptionsSet(AAPlotOptions.new
            .seriesSet(AASeries.new
                .animationSet(false)
                .markerSet(AAMarker.new
                    .enabledSet(false)
                    .statesSet(AAMarkerStates.new
                        .hoverSet(AAMarkerHover.new
                            .enabledSet(false))))
                .statesSet(AAStates.new
                    .hoverSet(AAHover.new
                        .haloSet(AAHalo.new
                            .sizeSet(@0))))
                .eventsSet(AAEvents.new
                    .mouseOverSet(@AAJSFunc(function () {
                        this.group.toFront();
                    })))))
        .tooltipSet(AATooltip.new
            .pointFormatSet(@"●{series.name}: {point.formattedValue}"))
        .xAxisSet(AAXAxis.new
            .categoriesSet(@[
                @"Training date",
                @"Miles for training run",
                @"Training time",
                @"Shoe brand",
                @"Running pace per mile",
                @"Short or long",
                @"After 2004",
            ])
            .offsetSet(@10))
        .yAxisSet((id)@[
            AAYAxis.new
                .typeSet(AAChartAxisTypeDatetime)
                .tooltipValueFormatSet(@"{value:%Y-%m-%d}"),
            AAYAxis.new
                .minSet(@0)
                .tooltipValueFormatSet(@"{value} mile(s)"),
            AAYAxis.new
                .typeSet(AAChartAxisTypeDatetime)
                .minSet(@0)
                .labelsSet(AALabels.new
                    .formatSet(@"{value:%H:%M}")),
            AAYAxis.new
                .categoriesSet(@[
                    @"Other",
                    @"Adidas",
                    @"Mizuno",
                    @"Asics",
                    @"Brooks",
                    @"New Balance",
                    @"Izumi",
                ]),
            AAYAxis.new
                .typeSet(AAChartAxisTypeDatetime),
            AAYAxis.new
                .categoriesSet(@[
                    @"> 5miles",
                    @"< 5miles",
                ]),
            AAYAxis.new
                .categoriesSet(@[
                    @"Before",
                    @"After",
                ])
            ])
        .colorsSet(@[AARgbaColor(255, 0, 0, 0.1), ])
        .seriesSet(({
            NSArray *marathonDataArr = AAOptionsData.marathonData;
            NSMutableArray *seriesArr = [NSMutableArray arrayWithCapacity:marathonDataArr.count];
            [marathonDataArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                AASeriesElement *aaSeriesElement = AASeriesElement.new
                .nameSet(@"Runner")
                .dataSet(obj)
                .shadowSet((id)@false);
                [seriesArr addObject:aaSeriesElement];
            }];
            seriesArr;
        }));
}

- (AAOptions *)parallelCoordinatesLineChart {
    AAOptions *aaOptions = [self parallelCoordinatesSplineChart];
    
    aaOptions.chart.typeSet(AAChartTypeLine);
    aaOptions.colorsSet(@[({
        NSDictionary *gradientColor =
        [AAGradientColor gradientColorWithDirection:AALinearGradientDirectionToRight
                                         stopsArray:@[
            @[@0.00, @"#febc0f0F"],//颜色字符串设置支持十六进制类型和 rgba 类型
            @[@0.25, @"#FF14d4E6"],
            @[@0.50, @"#0bf8f5E6"],
            @[@0.75, @"#F33c52E6"],
            @[@1.00, @"#1904ddE6"],
        ]];
        gradientColor;
    })]);
    
    return aaOptions;
}


@end
