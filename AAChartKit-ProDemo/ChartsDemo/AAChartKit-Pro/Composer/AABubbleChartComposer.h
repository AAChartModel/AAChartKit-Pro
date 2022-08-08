//
//  AABubbleChartComposer.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AAOptions;
NS_ASSUME_NONNULL_BEGIN

@interface AABubbleChartComposer : NSObject

+ (AAOptions *)packedbubbleChart;

+ (AAOptions *)packedbubbleSplitChart;

+ (AAOptions *)packedbubbleSpiralChart;

+ (AAOptions *)eulerChart;

+ (AAOptions *)vennChart;

@end

NS_ASSUME_NONNULL_END
