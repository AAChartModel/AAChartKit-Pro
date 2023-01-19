//
//  AAHeatOrTreeMapChartVC.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import "AAHeatOrTreeMapChartVC.h"
#import "AAHeatOrTreeMapChartComposer.h"

@implementation AAHeatOrTreeMapChartVC

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
        case 0: return [AAHeatOrTreeMapChartComposer heatmapChart];
        case 1: return [AAHeatOrTreeMapChartComposer treemapWithColorAxisData];
        case 2: return [AAHeatOrTreeMapChartComposer treemapWithLevelsData];
        case 3: return [AAHeatOrTreeMapChartComposer drilldownLargeDataTreemapChart];
        case 4: return [AAHeatOrTreeMapChartComposer largeDataHeatmapChart];
        case 5: return [AAHeatOrTreeMapChartComposer simpleTilemapWithHexagonTileShape];
        case 6: return [AAHeatOrTreeMapChartComposer simpleTilemapWithCircleTileShape];
        case 7: return [AAHeatOrTreeMapChartComposer simpleTilemapWithDiamondTileShape];
        case 8: return [AAHeatOrTreeMapChartComposer simpleTilemapWithSquareTileShape];
        case 9: return [AAHeatOrTreeMapChartComposer tilemapForAfricaWithHexagonTileShape];
        case 10: return [AAHeatOrTreeMapChartComposer tilemapForAfricaWithCircleTileShape];
        case 11: return [AAHeatOrTreeMapChartComposer tilemapForAfricaWithDiamondTileShape];
        case 12: return [AAHeatOrTreeMapChartComposer tilemapForAfricaWithSquareTileShape];
//        case 13: return [AAHeatOrTreeMapChartComposer tilemapChartForAmericaWithHexagonTileShape];
//        case 14: return [AAHeatOrTreeMapChartComposer tilemapChartForAmericaWithCircleTileShape];
//        case 15: return [AAHeatOrTreeMapChartComposer tilemapChartForAmericaWithDiamondTileShape];
//        case 16: return [AAHeatOrTreeMapChartComposer tilemapChartForAmericaWithSquareTileShape];

        default: return nil;
    }
}


@end
