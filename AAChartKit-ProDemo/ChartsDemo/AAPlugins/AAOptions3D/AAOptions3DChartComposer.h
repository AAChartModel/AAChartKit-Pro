//
//  AAOptions3DChartComposer.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/15.
//  Copyright © 2024 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AAOptions;

NS_ASSUME_NONNULL_BEGIN

@interface AAOptions3DChartComposer : NSObject

+ (AAOptions *)_3DColumnWithStackingRandomData;
+ (AAOptions *)_3DColumnWithStackingAndGrouping;
+ (AAOptions *)_3DAreaChart;
+ (AAOptions *)_3DScatterChart;

@end

NS_ASSUME_NONNULL_END
