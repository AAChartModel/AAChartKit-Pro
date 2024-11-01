//
//  AATilemapChartComposer.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AAOptions;
NS_ASSUME_NONNULL_BEGIN

@interface AATilemapChartComposer : NSObject

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

@end

NS_ASSUME_NONNULL_END
