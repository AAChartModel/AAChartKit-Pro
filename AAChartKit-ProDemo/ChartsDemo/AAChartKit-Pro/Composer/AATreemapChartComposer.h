//
//  AATreemapChartComposer.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/1.
//  Copyright © 2024 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AAOptions;

NS_ASSUME_NONNULL_BEGIN

@interface AATreemapChartComposer : NSObject

+ (AAOptions *)treemapWithColorAxisData;
+ (AAOptions *)treemapWithLevelsData;
+ (AAOptions *)treemapWithLevelsData2;
+ (AAOptions *)drilldownLargeDataTreemapChart;

@end

NS_ASSUME_NONNULL_END
