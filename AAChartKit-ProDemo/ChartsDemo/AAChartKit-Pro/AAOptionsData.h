//
//  AAOptionsData.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2020/6/6.
//  Copyright © 2020 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAOptionsData : NSObject

+ (NSArray *)variablepieData;
+ (NSArray *)variwideData;
+ (NSArray *)heatmapData;
+ (NSArray *)columnpyramidData;
+ (NSArray *)treemapWithColorAxisData;
+ (NSArray *)drilldownTreemapData;

+ (NSArray *)sankeyData;
+ (NSArray *)dependencywheelData;
+ (NSArray *)sunburstData;
+ (NSArray *)dumbbellData;
+ (NSArray *)vennData;
+ (NSArray *)lollipopData;
+ (NSArray *)tilemapData;
+ (NSArray *)treemapWithLevelsData;
+ (NSArray *)xrangeData;
+ (NSArray *)vectorData;
+ (NSArray *)bellcurveData;
+ (NSArray *)timelineData;
+ (NSArray *)itemData;
+ (NSArray *)windbarbData;
+ (NSArray *)networkgraphData;
+ (NSArray *)wordcloudData;
+ (NSArray *)eulerData;

+ (NSArray *)organizationData;
+ (NSArray *)organizationLevelsData;
+ (NSArray *)organizationNodesData;

+ (NSArray *)arcdiagram1Data;
+ (NSArray *)arcdiagram2Data;
+ (NSArray *)arcdiagram3Data;
+ (NSArray *)flameData;
+ (NSArray *)sunburst2Data;


@end

NS_ASSUME_NONNULL_END
