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
    NSArray *darkerColors = @[@"#603EAC", @"#7560B1", @"#4390AD", @"#AF8D0E"]; // 预先计算的深色

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
            @"color": @{
                @"pattern": @{
                    @"color": d[@"patternColor"], // 图案线的颜色
                    // 图案形状在系列级别定义
                }
            }
        }];
    }

    // 准备哑铃装饰线（顶部和底部）的数据
    NSNumber *decorativeCapWidth = @0.40; // 装饰线沿值轴的“宽度/厚度”（视觉上像一条线）
    NSMutableArray *topCapsData = [NSMutableArray array];
    NSMutableArray *bottomCapsData = [NSMutableArray array];

    for (NSDictionary *d in idealRangeRawData) {
        [topCapsData addObject:@{
            @"x": d[@"x"],
            @"low": @([d[@"high"] floatValue] - [decorativeCapWidth floatValue] / 2),
            @"high": @([d[@"high"] floatValue] + [decorativeCapWidth floatValue] / 2),
            @"color": d[@"patternColor"] // 装饰线的纯色填充
        }];
        [bottomCapsData addObject:@{
            @"x": d[@"x"],
            @"low": @([d[@"low"] floatValue] - [decorativeCapWidth floatValue] / 2),
            @"high": @([d[@"low"] floatValue] + [decorativeCapWidth floatValue] / 2),
            @"color": d[@"patternColor"] // 装饰线的纯色填充
        }];
    }

    NSNumber *mainBarPointWidth = @20; // 主图案条和实际睡眠条的“厚度”（倒置图中的高度）
    // 定义装饰线的“高度”（在倒置图中为沿着类别轴的长度/宽度）
    NSNumber *decorativeCapHeight = @32; // 您可以在此处自定义装饰线的高度，例如 mainBarPointWidth * 1.6

    AAOptions *aaOptions = AAOptions.new;

    aaOptions.chart = AAChart.new
        .typeSet(AAChartTypeColumnrange) // 默认类型，可被系列覆盖
        .invertedSet(YES);       // 使图表水平显示

    aaOptions.title = AATitle.new
        .textSet(@"睡眠阶段 vs 理想区间");

    aaOptions.xAxis = AAXAxis.new
        .categoriesSet(categories);
        // 如果希望 '深睡' 在底部，则设置为 true (原 JS 中为 xAxis: { categories: categories, reversed: true })

    aaOptions.yAxis = AAYAxis.new
        .minSet(@0)             // 显式设置 Y 轴最小值
        .maxSet(@100)
        .titleSet(AATitle.new.textSet(nil))
        .gridLineWidthSet(@1)
        .tickIntervalSet(@10);    // 可选：设置 Y 轴刻度间隔

    aaOptions.plotOptions = AAPlotOptions.new
        .seriesSet(AASeries.new // 新增：全局禁用所有系列的 hover 状态
            .statesSet(AAStates.new
                .hoverSet(AAHover.new
                    .enabledSet(NO)
                )
            )
        )
        .columnrangeSet(AAColumnrange.new
            .groupingSet(NO)     // 允许系列重叠
            .groupPaddingSet(@0.15)  // 调整类别间的整体间距
            .pointPaddingSet(@0.1)   // 影响其槽内柱子计算出的宽度
            .borderWidthSet(@0)
            .dataLabelsSet(AADataLabels.new
                .enabledSet(NO)
            )
        )
        .barSet(AABar.new // Specific options for bar series if needed, for consistency
            .groupingSet(NO)     // Also allow bar series to overlap
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
    // 实际睡眠数据 - 中间层
    AASeriesElement *actualSleepSeries = AASeriesElement.new
        .nameSet(@"实际睡眠")
        .typeSet(AAChartTypeBar) // 'bar' is essentially an inverted 'column'
        .dataSet(@[
            @{ @"y": @27, @"color": @"#8B5CF6", @"label": @"1小时22分钟（27%）" },
            @{ @"y": @53, @"color": @"#A78BFA", @"label": @"3小时42分钟（53%）" },
            @{ @"y": @18, @"color": @"#60CDF5", @"label": @"1小时49分钟（18%）" },
            @{ @"y": @2,  @"color": @"#FACC15", @"label": @"5分钟（2%）" }
        ])
        .pointWidthSet(mainBarPointWidth) // 设置与理想区间相同的“厚度”
        .dataLabelsSet(AADataLabels.new
            .enabledSet(YES)
            .formatterSet(@"function () { return this.point.label; }")
        )
        .zIndexSet(@0); // 绘制在理想区间之下

    // 理想区间（绘制为斜线背景柱） - 背景层
    NSDictionary *idealRangeSeriesPatternShape = @{
        @"pattern": @{
            @"path": @{ @"d": @"M 0 0 L 6 6", @"strokeWidth": @1.5 },
            @"width": @6,
            @"height": @6,
        }
    };
    AASeriesElement *idealRangeSeries = AASeriesElement.new
        .nameSet(@"理想睡眠区间")
        .typeSet(AAChartTypeColumnrange)
        .dataSet(idealRangeSeriesData)
        .colorSet((id)idealRangeSeriesPatternShape)
        .pointWidthSet(mainBarPointWidth) // 与实际睡眠条具有相同的“厚度”
        .zIndexSet(@1)                     // 绘制在实际睡眠数据上层, 这样视觉效果才能不被覆盖
        .showInLegendSet(YES);

    // 哑铃顶部装饰线 - 最顶层
    AASeriesElement *topCapsSeries = AASeriesElement.new
        .nameSet(@"装饰线")
        .typeSet(AAChartTypeColumnrange)
        .dataSet(topCapsData)
        .pointWidthSet(decorativeCapHeight)     // 装饰线的“高度” (倒置图中的宽度)
        .zIndexSet(@2)                     // 在主图案条和实际睡眠条之上绘制
        .showInLegendSet(NO)
        .enableMouseTrackingSet(@NO)
        .clipSet(NO)
    ;

    // 哑铃底部装饰线 - 最顶层
    AASeriesElement *bottomCapsSeries = AASeriesElement.new
        .nameSet(@"装饰线")
        .typeSet(AAChartTypeColumnrange)
        .dataSet(bottomCapsData)
        .pointWidthSet(decorativeCapHeight)     // 装饰线的“高度” - 更宽
        .zIndexSet(@2)
        .showInLegendSet(NO)
        .enableMouseTrackingSet(@NO)
        .clipSet(NO)
    ;

    aaOptions.series = @[
        actualSleepSeries,
        idealRangeSeries,
        topCapsSeries,
        bottomCapsSeries
    ];

    // AAChartView *aaChartView = [[AAChartView alloc] init];
    // aaChartView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    // [self.view addSubview:aaChartView];
    // [aaChartView aa_drawChartWithOptions:aaOptions];
    
    return aaOptions;
}


@end
