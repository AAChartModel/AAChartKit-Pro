#import "ChartSampleProvider.h"

#import "AARelationshipChartComposer.h"
#import "AABubbleChartComposer.h"
#import "AAColumnVariantChartComposer.h"
#import "AAHeatmapChartComposer.h"
#import "AATilemapChartComposer.h"
#import "AATreemapChartComposer.h"
#import "AATreegraphChartComposer.h"
#import "AAOrganizationChartComposer.h"
#import "AASankeyChartComposer.h"


@implementation ChartSampleProvider

#pragma mark - Relationship Charts

+ (NSArray<AAOptions *> *)relationshipChartSamples {
    return @[
        [AARelationshipChartComposer sankeyChart],
        [AARelationshipChartComposer dependencywheelChart],
        [AARelationshipChartComposer arcdiagramChart1],
        [AARelationshipChartComposer arcdiagramChart2],
        [AARelationshipChartComposer arcdiagramChart3],
        [AARelationshipChartComposer organizationChart],
        [AARelationshipChartComposer networkgraphChart],
        [AARelationshipChartComposer simpleDependencyWheelChart],
        [AARelationshipChartComposer neuralNetworkChart],
        [AARelationshipChartComposer carnivoraPhylogenyOrganizationChart],
        [AAOrganizationChartComposer germanicLanguageTreeChart],
        [AASankeyChartComposer sankeyDiagramChart],
        [AASankeyChartComposer verticalSankeyChart]
    ];
}

#pragma mark - Bubble Charts

+ (NSArray<AAOptions *> *)bubbleChartSamples {
    return @[
        [AABubbleChartComposer packedbubbleChart],
        [AABubbleChartComposer packedbubbleSplitChart],
        [AABubbleChartComposer packedbubbleSpiralChart],
        [AABubbleChartComposer eulerChart],
        [AABubbleChartComposer vennChart],
        [AABubbleChartComposer vennChart2],
        [AABubbleChartComposer eulerChart2],
    ];
}

#pragma mark - Column Variant Charts

+ (NSArray<AAOptions *> *)columnVariantChartSamples {
    return @[
        [AAColumnVariantChartComposer variwideChart],
        [AAColumnVariantChartComposer columnpyramidChart],
        [AAColumnVariantChartComposer dumbbellChart],
        [AAColumnVariantChartComposer lollipopChart],
        [AAColumnVariantChartComposer xrangeChart],
        [AAColumnVariantChartComposer histogramChart],
        [AAColumnVariantChartComposer bellcurveChart],
        [AAColumnVariantChartComposer bulletChart],
        [AAColumnVariantChartComposer pictorial1Chart],
        [AAColumnVariantChartComposer pictorial2Chart]
    ];
}

#pragma mark - Heatmap & Tilemap Charts

+ (NSArray<AAOptions *> *)heatmapAndTilemapChartSamples {
    return @[
        [AAHeatmapChartComposer heatmapChart],
        [AAHeatmapChartComposer largeDataHeatmapChart],
        [AAHeatmapChartComposer calendarHeatmap],
        [AATreemapChartComposer treemapWithColorAxisData],
        [AATreemapChartComposer treemapWithLevelsData],
        [AATreemapChartComposer treemapWithLevelsData2],
        [AATreemapChartComposer drilldownLargeDataTreemapChart],
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
        [AATilemapChartComposer tilemapChartForAmericaWithSquareTileShape]
    ];
}

#pragma mark - Treegraph Charts

+ (NSArray<AAOptions *> *)treegraphChartSamples {
    return @[
        [AATreegraphChartComposer treegraph],
        [AATreegraphChartComposer invertedTreegraph],
        [AATreegraphChartComposer treegraphWithBoxLayout],
        [AATreegraphChartComposer evolutionDendrogramChart]
    ];
}

#pragma mark - Public API

+ (NSArray<AAOptions *> *)allProTypeSamples {
    NSMutableArray<AAOptions *> *samples = [NSMutableArray array];
    [samples addObjectsFromArray:[self relationshipChartSamples]];
    [samples addObjectsFromArray:[self bubbleChartSamples]];
    [samples addObjectsFromArray:[self columnVariantChartSamples]];
    [samples addObjectsFromArray:[self heatmapAndTilemapChartSamples]];
    [samples addObjectsFromArray:[self treegraphChartSamples]];
    return [samples copy];
}

@end
