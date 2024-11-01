//
//  AAHeatOrTreeMapChartVC.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import "AATilemapChartVC.h"
#import "AATilemapChartComposer.h"
#import "AATreemapChartComposer.h"
#import "AAHeatmapChartComposer.h"
#import "AATreegraphChartComposer.h"

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
        case 0: return [AAHeatmapChartComposer heatmapChart];
        case 1: return [AATreemapChartComposer treemapWithColorAxisData];
        case 2: return [AATreemapChartComposer treemapWithLevelsData];
        case 3: return [AATreemapChartComposer drilldownLargeDataTreemapChart];
        case 4: return [AAHeatmapChartComposer largeDataHeatmapChart];
        case 5: return [AATilemapChartComposer simpleTilemapWithHexagonTileShape];
        case 6: return [AATilemapChartComposer simpleTilemapWithCircleTileShape];
        case 7: return [AATilemapChartComposer simpleTilemapWithDiamondTileShape];
        case 8: return [AATilemapChartComposer simpleTilemapWithSquareTileShape];
        case 9: return [AATilemapChartComposer tilemapForAfricaWithHexagonTileShape];
        case 10: return [AATilemapChartComposer tilemapForAfricaWithCircleTileShape];
        case 11: return [AATilemapChartComposer tilemapForAfricaWithDiamondTileShape];
        case 12: return [AATilemapChartComposer tilemapForAfricaWithSquareTileShape];
        case 13: return [AATilemapChartComposer tilemapChartForAmericaWithHexagonTileShape];
        case 14: return [AATilemapChartComposer tilemapChartForAmericaWithCircleTileShape];
        case 15: return [AATilemapChartComposer tilemapChartForAmericaWithDiamondTileShape];
        case 16: return [AATilemapChartComposer tilemapChartForAmericaWithSquareTileShape];
        case 17: return [AATreegraphChartComposer treegraph];
        case 18: return [AATreegraphChartComposer invertedTreegraph];
        case 19: return [AATreegraphChartComposer treegraphWithBoxLayout];
        case 20: return [AAHeatmapChartComposer calendarHeatmap];
        case 21: return [AATreemapChartComposer treemapWithLevelsData2];


        default: return nil;
    }
}


@end
