//
//  AAColumnVariantChartComposer.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AAOptions;
NS_ASSUME_NONNULL_BEGIN

@interface AAColumnVariantChartComposer : NSObject

+ (AAOptions *)variwideChart;
+ (AAOptions *)columnpyramidChart;
+ (AAOptions *)dumbbellChart;
+ (AAOptions *)lollipopChart;
+ (AAOptions *)xrangeChart;
+ (AAOptions *)histogramChart;
+ (AAOptions *)bellcurveChart;
+ (AAOptions *)bulletChart;
+ (AAOptions *)pictorial1Chart;
+ (AAOptions *)pictorial2Chart;

@end

NS_ASSUME_NONNULL_END
