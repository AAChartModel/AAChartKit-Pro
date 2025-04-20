#import "ChartSampleProvider.h"
// 假设 ChartProVC 的方法在 Objective-C 中有等效实现
// 例如，通过一个包装类或直接定义
@interface ChartProVCWrapper : NSObject // 示例包装类
+ (AAOptions *)sunburstChart;
+ (AAOptions *)streamgraphChart;
+ (AAOptions *)vectorChart;
+ (AAOptions *)bellcurveChart;
+ (AAOptions *)timelineChart;
+ (AAOptions *)itemChart;
+ (AAOptions *)windbarbChart;
+ (AAOptions *)wordcloudChart;
+ (AAOptions *)flameChart;
+ (AAOptions *)itemChart2;
+ (AAOptions *)itemChart3;
+ (AAOptions *)icicleChart;
+ (AAOptions *)sunburstChart2;
+ (AAOptions *)solidgaugeChart;
+ (AAOptions *)volinPlotChart;
+ (AAOptions *)variablepieChart;
+ (AAOptions *)semicircleSolidGaugeChart;
@end


@implementation ChartSampleProvider

+ (NSArray<AAOptions *> *)allProTypeSamples {
    return @[
         [AAHeatmapChartComposer heatmapChart],
         [AATreemapChartComposer treemapWithColorAxisData],
         [AATreemapChartComposer treemapWithLevelsData],
         [AATreemapChartComposer drilldownLargeDataTreemapChart],
         [AAHeatmapChartComposer largeDataHeatmapChart],
         [AATilemapChartComposer simpleTilemapWithHexagonTileShape],
         [AATilemapChartComposer simpleTilemapWithCircleTileShape],
         [AATilemapChartComposer simpleTilemapWithDiamondTileShape],
         [AATilemapChartComposer simpleTilemapWithSquareTileShape],
         [AATilemapChartComposer tilemapForAfricaWithHexagonTileShape],
         [AATilemapChartComposer tilemapForAfricaWithCircleTileShape],
         [AATilemapChartComposer tilemapForAfricaWithDiamondTileShape],
         [AATilemapChartComposer tilemapForAfricaWithSquareTileShape],
         [AATilemapChartComposer tilemapChartForAmericaWithHexagonTileShape],
         [AATilemapChartComposer tilemapChartForAmericaWithCircleTileShape],
         [AATilemapChartComposer tilemapChartForAmericaWithDiamondTileShape],
         [AATilemapChartComposer tilemapChartForAmericaWithSquareTileShape],
         [AATreegraphChartComposer treegraph],
         [AATreegraphChartComposer invertedTreegraph],
         [AATreegraphChartComposer treegraphWithBoxLayout],
         [AAHeatmapChartComposer calendarHeatmap],
         [AATreemapChartComposer treemapWithLevelsData2],
    ];
}

@end

// 示例 ChartProVCWrapper 实现 (需要根据实际情况调整)
@implementation ChartProVCWrapper
// 实现 ChartProVCWrapper 的类方法，调用实际的图表生成逻辑
+ (AAOptions *)sunburstChart { return [AAOptions new]; /* 实际实现 */ }
+ (AAOptions *)streamgraphChart { return [AAOptions new]; /* 实际实现 */ }
+ (AAOptions *)vectorChart { return [AAOptions new]; /* 实际实现 */ }
+ (AAOptions *)bellcurveChart { return [AAOptions new]; /* 实际实现 */ }
+ (AAOptions *)timelineChart { return [AAOptions new]; /* 实际实现 */ }
+ (AAOptions *)itemChart { return [AAOptions new]; /* 实际实现 */ }
+ (AAOptions *)windbarbChart { return [AAOptions new]; /* 实际实现 */ }
+ (AAOptions *)wordcloudChart { return [AAOptions new]; /* 实际实现 */ }
+ (AAOptions *)flameChart { return [AAOptions new]; /* 实际实现 */ }
+ (AAOptions *)itemChart2 { return [AAOptions new]; /* 实际实现 */ }
+ (AAOptions *)itemChart3 { return [AAOptions new]; /* 实际实现 */ }
+ (AAOptions *)icicleChart { return [AAOptions new]; /* 实际实现 */ }
+ (AAOptions *)sunburstChart2 { return [AAOptions new]; /* 实际实现 */ }
+ (AAOptions *)solidgaugeChart { return [AAOptions new]; /* 实际实现 */ }
+ (AAOptions *)volinPlotChart { return [AAOptions new]; /* 实际实现 */ }
+ (AAOptions *)variablepieChart { return [AAOptions new]; /* 实际实现 */ }
+ (AAOptions *)semicircleSolidGaugeChart { return [AAOptions new]; /* 实际实现 */ }
@end
