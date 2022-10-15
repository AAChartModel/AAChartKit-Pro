
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
        case  0: return [self volinPlotChart];
        case  1: return [self simpleDependencyWheelChart];
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

- (AAOptions *)volinPlotChart {
    return AAOptions.new
        .chartSet(AAChart.new
            .typeSet(AAChartTypeStreamgraph)
            .invertedSet(true))
        .titleSet(AATitle.new
            .textSet(@"The 2012 Olympic rowing athletes weight"))
        .xAxisSet(AAXAxis.new
            .reversedSet(false)
            .labelsSet(AALabels.new
                .formatSet(@"{value} kg"))
            .gridLineWidthSet(@1)
                  .crosshairSet(AACrosshair.new
                      .colorSet(AAColor.lightGrayColor)
                      .dashStyleSet(AAChartLineDashStyleTypeLongDashDotDot)))
        .yAxisSet((id)@[
            AAYAxis.new
                .widthSet((id)@"45%")
                .offsetSet(@0)
                .visibleSet(false),
            AAYAxis.new
                .widthSet((id)@"45%")
                .leftSet((id)@"55%")
                .offsetSet(@0)
                .visibleSet(false)
            ])
        .tooltipSet(AATooltip.new
            .splitSet(@true)
//            .crosshairsSet(true)
            .headerFormatSet(@"")
            .pointFormatSet(@"{series.name}: {point.x} kg"))
        .seriesSet(@[
            AASeriesElement.new
                .nameSet(@"Male")
                .dataSet(@[
                    @[@47, @5.608535227799803e-11],
                    @[@48, @1.372407067436998e-8],
                    @[@49, @0.0000012356924405721627],
                    @[@50, @0.0000409917113448592],
                    @[@51, @0.0005057902880102527],
                    @[@52, @0.0024790321383763515],
                    @[@53, @0.006672813041359025],
                    @[@54, @0.015635031430467725],
                    @[@55, @0.02259364291312416],
                    @[@56, @0.01344236488178583],
                    @[@57, @0.002991504270506708],
                    @[@58, @0.0002454699433028564],
                    @[@59, @0.000007412191665896888],
                    @[@60, @8.234147287550304e-8],
                    @[@61, @3.365948487844305e-10],
                    @[@62, @5.6676575246716064e-11],
                    @[@63, @1.378192736351844e-8],
                    @[@64, @0.0000012505948888979913],
                    @[@65, @0.00004251599284369339],
                    @[@66, @0.0005728216060598633],
                    @[@67, @0.003852828500580922],
                    @[@68, @0.019927884649780687],
                    @[@69, @0.07350237724179146],
                    @[@70, @0.14144741144263853],
                    @[@71, @0.16075870428789982],
                    @[@72, @0.15676850099064582],
                    @[@73, @0.13084487380374604],
                    @[@74, @0.08346512415283565],
                    @[@75, @0.05639598449124563],
                    @[@76, @0.039864097863405355],
                    @[@77, @0.022790431719549236],
                    @[@78, @0.012011758158727093],
                    @[@79, @0.01064640861932188],
                    @[@80, @0.014449220747767763],
                    @[@81, @0.013747629555726735],
                    @[@82, @0.01317397847699511],
                    @[@83, @0.018550040743350208],
                    @[@84, @0.032708960068479676],
                    @[@85, @0.054173265126786545],
                    @[@86, @0.06482550397827902],
                    @[@87, @0.06204350204053542],
                    @[@88, @0.06779006849698278],
                    @[@89, @0.09502794502566415],
                    @[@90, @0.12520786369753706],
                    @[@91, @0.12876410912856237],
                    @[@92, @0.1295199598786729],
                    @[@93, @0.13704746319593997],
                    @[@94, @0.14718449129408478],
                    @[@95, @0.15408158612826592],
                    @[@96, @0.1365084578198678],
                    @[@97, @0.11047040318043161],
                    @[@98, @0.08508481589742302],
                    @[@99, @0.07277154071987774],
                    @[@100, @0.07919601341247737],
                    @[@101, @0.06649595899224524],
                    @[@102, @0.04791740961016811],
                    @[@103, @0.03806852586791209],
                    @[@104, @0.03408065271481093],
                    @[@105, @0.02822403217458879],
                    @[@106, @0.017973359383565434],
                    @[@107, @0.01262602934702141],
                    @[@108, @0.011262419040580134],
                    @[@109, @0.009478587683679656],
                    @[@110, @0.008404044403162792],
                    @[@111, @0.004550219881361795],
                    @[@112, @0.0009992407967064237],
                    @[@113, @0.00008184624321178402],
                    @[@114, @0.000002470824114786898],
                    @[@115, @2.744729819042502e-8]
                    ])
                .colorSet(@"#a8d4ff")
                .yAxisSet(@0),
            AASeriesElement.new
                .nameSet(@"Female")
                .colorSet(@"#ffa8d4")
                .dataSet(@[
                    @[@38, @0],
                    @[@39, @0],
                    @[@40, @0],
                    @[@41, @0],
                    @[@42, @0],
                    @[@43, @1.7398814086959525e-10],
                    @[@44, @4.2738095400258076e-8],
                    @[@45, @0.000003887437286771067],
                    @[@46, @0.0001323598214453675],
                    @[@47, @0.001732535403876214],
                    @[@48, @0.00922734792388576],
                    @[@49, @0.021768546189023814],
                    @[@50, @0.024012929915311995],
                    @[@51, @0.011979910355387695],
                    @[@52, @0.0033388294748258334],
                    @[@53, @0.005227646441141197],
                    @[@54, @0.013771532251947839],
                    @[@55, @0.02919339926294712],
                    @[@56, @0.07570390197742677],
                    @[@57, @0.13365103542847676],
                    @[@58, @0.13076621964804375],
                    @[@59, @0.1078097770084547],
                    @[@60, @0.09010677069685188],
                    @[@61, @0.056582402708003965],
                    @[@62, @0.03308468727355079],
                    @[@63, @0.023455701911044388],
                    @[@64, @0.02457030480282277],
                    @[@65, @0.03632399183590655],
                    @[@66, @0.052880667866068654],
                    @[@67, @0.07723712616722567],
                    @[@68, @0.10112277607441206],
                    @[@69, @0.12481435329503127],
                    @[@70, @0.15172074777005065],
                    @[@71, @0.1672892277665827],
                    @[@72, @0.18246452053632298],
                    @[@73, @0.1755546923253718],
                    @[@74, @0.1838775533940472],
                    @[@75, @0.20966992614184968],
                    @[@76, @0.18927036028023367],
                    @[@77, @0.12351552590851589],
                    @[@78, @0.07196164152893701],
                    @[@79, @0.056531488980089674],
                    @[@80, @0.0534323580717955],
                    @[@81, @0.04235686946541823],
                    @[@82, @0.029216384766772643],
                    @[@83, @0.029091581174119197],
                    @[@84, @0.03132016604603416],
                    @[@85, @0.031774947357177896],
                    @[@86, @0.02920414463847989],
                    @[@87, @0.017870932795005387],
                    @[@88, @0.007443733922222755],
                    @[@89, @0.007878551612935955],
                    @[@90, @0.011467441221575675],
                    @[@91, @0.006915425022752088],
                    @[@92, @0.0015426205427402709],
                    @[@93, @0.00012662432753104478],
                    @[@94, @0.0000038237208668521435],
                    @[@95, @4.2477700493199295e-8]
                    ])
                .yAxisSet(@1)
            ]);
}

- (AAOptions *)simpleDependencyWheelChart {
    return AAOptions.new
        .titleSet(AATitle.new
            .textSet(@"2016 BRICS export in million USD"))
        .colorsSet(@[@"#058DC7", @"#8dc705", @"#c73f05", @"#ffc080", @"#dd69ba", ])
        .seriesSet(@[
            AASeriesElement.new
                .keysSet(@[@"from", @"to", @"weight", ])
                .dataSet(@[
                    @[@"Brazil", @"Russia", @2524],
                    @[@"Brazil", @"India", @4115],
                    @[@"Brazil", @"China", @45738],
                    @[@"Brazil", @"South Africa", @1401],
                    @[@"Russia", @"Brazil", @2021],
                    @[@"Russia", @"India", @5564],
                    @[@"Russia", @"China", @32229],
                    @[@"Russia", @"South Africa", @196],
                    @[@"India", @"Brazil", @2484],
                    @[@"India", @"Russia", @2398],
                    @[@"India", @"China", @11757],
                    @[@"India", @"South Africa", @3554],
                    @[@"China", @"Brazil", @23364],
                    @[@"China", @"India", @61311],
                    @[@"China", @"South Africa", @12848],
                    @[@"China", @"Russia", @38105],
                    @[@"South Africa", @"Russia", @255],
                    @[@"South Africa", @"Brazil", @336],
                    @[@"South Africa", @"India", @5814],
                    @[@"South Africa", @"China", @22491]
                    ])
                .typeSet(AAChartTypeDependencywheel)
                .nameSet(@"Dependency wheel series")
                .dataLabelsSet(AADataLabels.new
                    .colorSet(@"#333")
                    .textPathSet(AATextPath.new
                        .enabledSet(true)
//                        .attributesSet(AAAttributes.new
//                            .dySet(@5))
            )
//                    .distanceSet(@10)
            )
//                .sizeSet(@"95%")
            ]);
}


@end
