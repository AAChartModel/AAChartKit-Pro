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
+ (AAOptions *)tilemapChart;
+ (AAOptions *)treemapWithColorAxisData;
+ (AAOptions *)treemapWithLevelsData;
+ (AAOptions *)drilldownLargeDataTreemapChart;
+ (AAOptions *)largeDataHeatmapChart;

+ (AAOptions *)simpleTilemapWithHexagonTileShape;
+ (AAOptions *)simpleTilemapWithCircleTileShape;
+ (AAOptions *)simpleTilemapWithDiamondTileShape;
+ (AAOptions *)simpleTilemapWithSquareTileShape;

@end

NS_ASSUME_NONNULL_END
