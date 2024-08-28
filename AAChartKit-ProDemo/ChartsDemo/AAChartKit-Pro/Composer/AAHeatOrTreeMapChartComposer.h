//
//  AATreeOrHeatMapChartComposer.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AAOptions;
NS_ASSUME_NONNULL_BEGIN

@interface AAHeatOrTreeMapChartComposer : NSObject

+ (AAOptions *)heatmapChart;
+ (AAOptions *)treemapWithColorAxisData;
+ (AAOptions *)treemapWithLevelsData;
+ (AAOptions *)drilldownLargeDataTreemapChart;
+ (AAOptions *)largeDataHeatmapChart;

+ (AAOptions *)simpleTilemapWithHexagonTileShape;
+ (AAOptions *)simpleTilemapWithCircleTileShape;
+ (AAOptions *)simpleTilemapWithDiamondTileShape;
+ (AAOptions *)simpleTilemapWithSquareTileShape;

+ (AAOptions *)tilemapForAfricaWithHexagonTileShape;
+ (AAOptions *)tilemapForAfricaWithCircleTileShape;
+ (AAOptions *)tilemapForAfricaWithDiamondTileShape;
+ (AAOptions *)tilemapForAfricaWithSquareTileShape;

+ (AAOptions *)tilemapChartForAmericaWithHexagonTileShape;
+ (AAOptions *)tilemapChartForAmericaWithCircleTileShape;
+ (AAOptions *)tilemapChartForAmericaWithDiamondTileShape;
+ (AAOptions *)tilemapChartForAmericaWithSquareTileShape;
+ (AAOptions *)treegraph;
+ (AAOptions *)invertedTreegraph;
+ (AAOptions *)treegraphWithBoxLayout;
+ (AAOptions *)calendarHeatmap;


@end

NS_ASSUME_NONNULL_END
