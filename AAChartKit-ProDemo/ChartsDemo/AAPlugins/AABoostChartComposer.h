//
//  AABoostChartComposer.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/11.
//  Copyright © 2024 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AABoostChartComposer : NSObject

+ (NSDictionary *)lineChart;
+ (NSDictionary *)areaChart;
+ (NSDictionary *)columnChart;
+ (NSDictionary *)lineChartWithHundredsOfSeries;
+ (NSDictionary *)scatterChartOptions;
+ (NSDictionary *)areaRangeChart;
+ (NSDictionary *)columnRangeChart;
+ (NSDictionary *)bubbleChart;

@end

NS_ASSUME_NONNULL_END
