//
//  AASeries+Depth.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/15.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AASeries+Depth.h"
//导入 runtime 库
#import <objc/runtime.h>

/**
 //为 AASeries 对象设置 groupZPadding 属性
 AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber *, groupZPadding)
 //为 AASeries 对象设置 depth 属性
 AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber *, depth)
 //为 AASeries 对象设置 grouping 属性
 AAPropStatementAndPropSetFuncStatement(assign, AASeries, BOOL, grouping)

 */
@implementation AASeries (Depth)


//使用关联对象, 实现添加 groupZPadding 属性
- (void)setGroupZPadding:(NSNumber *)groupZPadding {
    objc_setAssociatedObject(self, @selector(groupZPadding), groupZPadding, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)groupZPadding {
    return objc_getAssociatedObject(self, @selector(groupZPadding));
}

- (AASeries * (^) (NSNumber * groupZPadding))groupZPaddingSet {
    return ^(NSNumber * groupZPadding) {
        self.groupZPadding = groupZPadding;
        return self;
    };
}


//使用关联对象, 实现添加 depth 属性
- (void)setDepth:(NSNumber *)depth {
    objc_setAssociatedObject(self, @selector(depth), depth, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSNumber *)depth {
    return objc_getAssociatedObject(self, @selector(depth));
}

- (AASeries * (^) (NSNumber * depth))depthSet {
    return ^(NSNumber * depth) {
        self.depth = depth;
        return self;
    };
}


//使用关联对象, 实现添加 grouping 属性
- (void)setGrouping:(BOOL)grouping {
    objc_setAssociatedObject(self, @selector(grouping), @(grouping), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)grouping {
    return [objc_getAssociatedObject(self, @selector(grouping)) boolValue];
}

- (AASeries * (^) (BOOL grouping))groupingSet {
    return ^(BOOL grouping) {
        self.grouping = grouping;
        return self;
    };
}

@end
