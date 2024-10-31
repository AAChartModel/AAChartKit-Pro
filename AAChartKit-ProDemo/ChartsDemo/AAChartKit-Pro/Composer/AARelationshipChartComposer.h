//
//  AARelationshipChartComposer.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AAOptions;
NS_ASSUME_NONNULL_BEGIN

@interface AARelationshipChartComposer : NSObject

+ (AAOptions *)sankeyChart;
+ (AAOptions *)dependencywheelChart;
+ (AAOptions *)arcdiagramChart1;
+ (AAOptions *)arcdiagramChart2;
+ (AAOptions *)arcdiagramChart3;
+ (AAOptions *)organizationChart;
+ (AAOptions *)networkgraphChart;
+ (AAOptions *)simpleDependencyWheelChart;
+ (AAOptions *)neuralNetworkChart;

@end

NS_ASSUME_NONNULL_END
