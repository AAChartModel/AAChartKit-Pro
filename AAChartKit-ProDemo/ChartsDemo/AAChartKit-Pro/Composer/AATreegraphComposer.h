//
//  AATreegraphComposer.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/1.
//  Copyright © 2024 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AAOptions;

NS_ASSUME_NONNULL_BEGIN

@interface AATreegraphComposer : NSObject

+ (AAOptions *)treegraph;
+ (AAOptions *)invertedTreegraph;
+ (AAOptions *)treegraphWithBoxLayout;

@end

NS_ASSUME_NONNULL_END
