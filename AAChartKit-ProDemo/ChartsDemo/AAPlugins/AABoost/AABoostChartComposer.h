//
//  AABoostChartComposer.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/11.
//  Copyright © 2024 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AAOptions;

NS_ASSUME_NONNULL_BEGIN

@interface AABoostChartComposer : NSObject

+ (AAOptions *)lineChart;
+ (AAOptions *)areaChart;
+ (AAOptions *)columnChart;
+ (AAOptions *)lineChartWithHundredsOfSeries;
+ (AAOptions *)scatterChartOptions;
+ (AAOptions *)areaRangeChart;
+ (AAOptions *)columnRangeChart;
+ (AAOptions *)bubbleChart;
+ (AAOptions *)heatMapChart;
+ (AAOptions *)stackingAreaChart;
+ (AAOptions *)stackingColumnChart;

@end

NS_ASSUME_NONNULL_END
