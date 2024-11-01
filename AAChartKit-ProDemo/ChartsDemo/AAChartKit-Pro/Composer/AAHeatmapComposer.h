//
//  AAHeatmapComposer.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/1.
//  Copyright © 2024 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AAOptions;

NS_ASSUME_NONNULL_BEGIN

@interface AAHeatmapComposer : NSObject

+ (AAOptions *)heatmapChart;
+ (AAOptions *)largeDataHeatmapChart;
+ (AAOptions *)calendarHeatmap;

@end

NS_ASSUME_NONNULL_END
