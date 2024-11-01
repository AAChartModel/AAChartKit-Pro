//
//  AAHeatOrTreeMapChartVC.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import "AATilemapChartVC.h"
#import "AATilemapComposer.h"
#import "AATreemapComposer.h"
#import "AAHeatmapComposer.h"
#import "AATreegraphComposer.h"

@implementation AATilemapChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


//- (id)chartConfigurationWithSelectedIndex:(NSUInteger)selectedIndex {
//    switch (self.selectedIndex) {
//        case  0: return [AAHeatOrTreeMapChartComposer heatmapChart];
//        case  1: return [AAHeatOrTreeMapChartComposer tilemapChart];
//        case  2: return [AAHeatOrTreeMapChartComposer treemapWithColorAxisData];
//        case  3: return [AAHeatOrTreeMapChartComposer treemapWithLevelsData];
//        case  4: return [AAHeatOrTreeMapChartComposer drilldownLargeDataTreemapChart];
//        case  5: return [AAHeatOrTreeMapChartComposer largeDataHeatmapChart];
//
//    }
//    return nil;
//}
//
//override func chartConfigurationWithSelectedIndex(_ selectedIndex: Int) -> Any? {
//    switch (selectedIndex) {
//        case 0: return AAHeatOrTreeMapChartComposer.heatmapChart()
//        case 1: return AAHeatOrTreeMapChartComposer.treemapWithColorAxisData()
//        case 2: return AAHeatOrTreeMapChartComposer.treemapWithLevelsData()
//        case 3: return AAHeatOrTreeMapChartComposer.drilldownLargeDataTreemapChart()
//        case 4: return AAHeatOrTreeMapChartComposer.largeDataHeatmapChart()
//        case 5: return AAHeatOrTreeMapChartComposer.simpleTilemapWithHexagonTileShape()
//        case 6: return AAHeatOrTreeMapChartComposer.simpleTilemapWithCircleTileShape()
//        case 7: return AAHeatOrTreeMapChartComposer.simpleTilemapWithDiamondTileShape()
//        case 8: return AAHeatOrTreeMapChartComposer.simpleTilemapWithSquareTileShape()
//        case 9: return AAHeatOrTreeMapChartComposer.tilemapForAfricaWithHexagonTileShape()
//        case 10: return AAHeatOrTreeMapChartComposer.tilemapForAfricaWithCircleTileShape()
//        case 11: return AAHeatOrTreeMapChartComposer.tilemapForAfricaWithDiamondTileShape()
//        case 12: return AAHeatOrTreeMapChartComposer.tilemapForAfricaWithSquareTileShape()
//        case 13: return AAHeatOrTreeMapChartComposer.tilemapChartForAmericaWithHexagonTileShape()
//        case 14: return AAHeatOrTreeMapChartComposer.tilemapChartForAmericaWithCircleTileShape()
//        case 15: return AAHeatOrTreeMapChartComposer.tilemapChartForAmericaWithDiamondTileShape()
//        case 16: return AAHeatOrTreeMapChartComposer.tilemapChartForAmericaWithSquareTileShape()
//
//        default: return nil
//    }
//}

- (id)chartConfigurationWithSelectedIndex:(NSUInteger)selectedIndex {
    switch (selectedIndex) {
        case 0: return [AAHeatmapComposer heatmapChart];
        case 1: return [AATreemapComposer treemapWithColorAxisData];
        case 2: return [AATreemapComposer treemapWithLevelsData];
        case 3: return [AATreemapComposer drilldownLargeDataTreemapChart];
        case 4: return [AAHeatmapComposer largeDataHeatmapChart];
        case 5: return [AATilemapComposer simpleTilemapWithHexagonTileShape];
        case 6: return [AATilemapComposer simpleTilemapWithCircleTileShape];
        case 7: return [AATilemapComposer simpleTilemapWithDiamondTileShape];
        case 8: return [AATilemapComposer simpleTilemapWithSquareTileShape];
        case 9: return [AATilemapComposer tilemapForAfricaWithHexagonTileShape];
        case 10: return [AATilemapComposer tilemapForAfricaWithCircleTileShape];
        case 11: return [AATilemapComposer tilemapForAfricaWithDiamondTileShape];
        case 12: return [AATilemapComposer tilemapForAfricaWithSquareTileShape];
        case 13: return [AATilemapComposer tilemapChartForAmericaWithHexagonTileShape];
        case 14: return [AATilemapComposer tilemapChartForAmericaWithCircleTileShape];
        case 15: return [AATilemapComposer tilemapChartForAmericaWithDiamondTileShape];
        case 16: return [AATilemapComposer tilemapChartForAmericaWithSquareTileShape];
        case 17: return [AATreegraphComposer treegraph];
        case 18: return [AATreegraphComposer invertedTreegraph];
        case 19: return [AATreegraphComposer treegraphWithBoxLayout];
        case 20: return [AAHeatmapComposer calendarHeatmap];
        case 21: return [AATreemapComposer treemapWithLevelsData2];


        default: return nil;
    }
}


@end
