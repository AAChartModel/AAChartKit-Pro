//
//  AAOptions+Drilldown.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/15.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AAOptions+Drilldown.h"
//导入 runtime 库
#import <objc/runtime.h>

@implementation AAOptions (Drilldown)

//使用关联对象, 实现添加 drilldown 属性
- (void)setDrilldown:(AADrilldown *)drilldown {
    objc_setAssociatedObject(self, @selector(drilldown), drilldown, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AADrilldown *)drilldown {
    return objc_getAssociatedObject(self, @selector(drilldown));
}

- (AAOptions * (^) (AADrilldown * drilldown))drilldownSet {
    return ^(AADrilldown * drilldown) {
        self.drilldown = drilldown;
        return self;
    };
}

@end
