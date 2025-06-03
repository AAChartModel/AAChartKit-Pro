//
//  AAMixedChartComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2025/6/3.
//  Copyright © 2025 An An. All rights reserved.
//

#import "AAMixedChartComposer.h"
#import "AAChartKit-Pro.h"
//#import "AAOptionsData.h"
@implementation AAMixedChartComposer

+ (AAOptions *)barMixedColumnrangeWithPatternFillChart {
    // 为理想睡眠区间定义深色（用于图案和装饰线）
    NSArray *darkerColors = @[@"#603EAC", @"#7560B1", @"#4390AD", @"#AF8D0E"];
    
    // 理想区间原始数据
    NSArray *idealRangeRawData = @[
        @{ @"low": @20, @"high": @32, @"x": @0, @"category": @"深睡", @"patternColor": darkerColors[0] },
        @{ @"low": @40, @"high": @60, @"x": @1, @"category": @"浅睡", @"patternColor": darkerColors[1] },
        @{ @"low": @10, @"high": @25, @"x": @2, @"category": @"REM", @"patternColor": darkerColors[2] },
        @{ @"low": @0, @"high": @5, @"x": @3, @"category": @"清醒", @"patternColor": darkerColors[3] }
    ];
    
    NSMutableArray *categories = [NSMutableArray array];
    for (NSDictionary *item in idealRangeRawData) {
        [categories addObject:item[@"category"]];
    }
    
    // 准备 Highcharts 系列数据：理想区间（带图案的条形）
    NSMutableArray *idealRangeSeriesData = [NSMutableArray array];
    for (NSDictionary *d in idealRangeRawData) {
        [idealRangeSeriesData addObject:@{
            @"low": d[@"low"],
            @"high": d[@"high"],
            @"x": d[@"x"],
            @"color": @{ // 每个数据点的图案颜色
                @"pattern": @{
                    @"color": d[@"patternColor"]
                }
            }
        }];
    }
    
    // 准备哑铃装饰线（顶部和底部）的数据
    NSNumber *decorativeCapWidth = @0.20;
    NSMutableArray *topCapsData = [NSMutableArray array];
    NSMutableArray *bottomCapsData = [NSMutableArray array];
    
    for (NSDictionary *d in idealRangeRawData) {
        [topCapsData addObject:@{
            @"x": d[@"x"],
            @"low": @([d[@"high"] floatValue] - [decorativeCapWidth floatValue] / 2),
            @"high": @([d[@"high"] floatValue] + [decorativeCapWidth floatValue] / 2),
            @"color": d[@"patternColor"]
        }];
        [bottomCapsData addObject:@{
            @"x": d[@"x"],
            @"low": @([d[@"low"] floatValue] - [decorativeCapWidth floatValue] / 2),
            @"high": @([d[@"low"] floatValue] + [decorativeCapWidth floatValue] / 2),
            @"color": d[@"patternColor"]
        }];
    }
    
    NSNumber *mainBarPointWidth = @20;
    NSNumber *decorativeCapHeight = @32;
    
    AAOptions *aaOptions = AAOptions.new;
    
    aaOptions.chart = AAChart.new
        .typeSet(AAChartTypeColumnrange)
        .invertedSet(YES);
    
    aaOptions.title = AATitle.new
        .textSet(@"睡眠阶段 vs 理想区间");
    
    aaOptions.xAxis = AAXAxis.new
        .categoriesSet(categories);
    
    aaOptions.yAxis = AAYAxis.new
        .minSet(@0)
        .maxSet(@100)
        .titleSet(AATitle.new.textSet(nil)) // 设置标题文本为 nil 来隐藏标题
        .gridLineWidthSet(@1)
        .tickIntervalSet(@10);
    
    aaOptions.plotOptions = AAPlotOptions.new
        .seriesSet(AASeries.new // 全局系列配置
                   .statesSet(AAStates.new
                              .hoverSet(AAHover.new
                                        .enabledSet(NO) // 全局禁用 hover 状态
                                        )
                              )
                   )
        .columnrangeSet(AAColumnrange.new
                        .groupingSet(NO)
                        .groupPaddingSet(@0.15)
                        .pointPaddingSet(@0.1)
                        .borderWidthSet(@0)
                        .dataLabelsSet(AADataLabels.new
                                       .enabledSet(NO)
                                       )
                        )
        .barSet(AABar.new // 针对 bar 系列的特定配置
                .groupingSet(NO)
                .borderWidthSet(@0)
                );
    
    aaOptions.legend = AALegend.new
        .enabledSet(YES);
    
    aaOptions.tooltip = AATooltip.new
        .sharedSet(YES)
        .formatterSet(@AAJSFunc(function() {
            let s = `<b>${this.points[0].series.xAxis.categories[this.x]}</b>`; // 使用 category 名称
            this.points.forEach(point => {
                if (point.series.name === '理想睡眠区间') {
                    s += `<br/><span style=\"color:${point.point.color.pattern.color}\">●</span> ${point.series.name}: ${point.point.low} - ${point.point.high}`;
                } else if (point.series.name === '实际睡眠') {
                    s += `<br/><span style=\"color:${point.color}\">●</span> ${point.series.name}: ${point.y} (${point.point.label || point.y + '%'})`;
                }
                // 装饰线信息通常不在提示框中显示
            });
            return s;
        }))
    ;
    
    // 系列数据
    AASeriesElement *actualSleepSeries = AASeriesElement.new
        .nameSet(@"实际睡眠")
        .typeSet(AAChartTypeBar)
        .dataSet(@[
            @{ @"y": @27, @"color": @"#8B5CF6", @"label": @"1小时22分钟（27%）" },
            @{ @"y": @53, @"color": @"#A78BFA", @"label": @"3小时42分钟（53%）" },
            @{ @"y": @18, @"color": @"#60CDF5", @"label": @"1小时49分钟（18%）" },
            @{ @"y": @2,  @"color": @"#FACC15", @"label": @"5分钟（2%）" }
        ])
    //        .pointWidthSet(mainBarPointWidth)
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(YES)
                       .formatterSet(@"function () { return this.point.label; }")
                       )
        .zIndexSet(@0);
    
    // 理想睡眠区间系列 - 图案定义
    NSDictionary *idealRangePatternColor = @{
        @"pattern": @{
            @"path": @{ @"d": @"M 0 0 L 6 6", @"strokeWidth": @1.5 },
            @"width": @6,
            @"height": @6
        }
    };
    
    AASeriesElement *idealRangeSeries = AASeriesElement.new
        .nameSet(@"理想睡眠区间")
        .typeSet(AAChartTypeColumnrange)
        .dataSet(idealRangeSeriesData) // 数据点已包含各自的 pattern.color
        .colorSet((id)idealRangePatternColor) // 系列级别的图案结构, AASeriesElement.color 是 id 类型
    //        .pointWidthSet(mainBarPointWidth)
        .zIndexSet(@1)
        .showInLegendSet(YES);
    
    AASeriesElement *topCapsSeries = AASeriesElement.new
        .nameSet(@"装饰线")
        .typeSet(AAChartTypeColumnrange)
        .dataSet(topCapsData)
    //        .pointWidthSet(decorativeCapHeight)
        .zIndexSet(@2)
        .showInLegendSet(NO)
        .enableMouseTrackingSet(NO)
    //        .clipSet(NO)
    ; // 对应 JS 中的 clip: false
    
    AASeriesElement *bottomCapsSeries = AASeriesElement.new
        .nameSet(@"装饰线")
        .typeSet(AAChartTypeColumnrange)
        .dataSet(bottomCapsData)
    //        .pointWidthSet(decorativeCapHeight)
        .zIndexSet(@2)
        .showInLegendSet(NO)
        .enableMouseTrackingSet(NO)
    //        .clipSet(NO)
    ; // 对应 JS 中的 clip: false
    
    aaOptions.series = @[
        actualSleepSeries,
        idealRangeSeries,
        topCapsSeries,
        bottomCapsSeries
    ];
    
    return aaOptions;
}


@end
