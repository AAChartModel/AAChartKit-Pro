//
//  AAOptions+ZAxis.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/15.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AAOptions+ZAxis.h"
//导入 runtime 库
#import <objc/runtime.h>

@implementation AAOptions (ZAxis)

//使用关联对象, 实现添加 zAxis 属性
- (void)setZAxis:(AAZAxis *)zAxis {
    objc_setAssociatedObject(self, @selector(zAxis), zAxis, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AAZAxis *)zAxis {
    return objc_getAssociatedObject(self, @selector(zAxis));
}

- (AAOptions * (^) (AAZAxis * zAxis))zAxisSet {
    return ^(AAZAxis * zAxis) {
        self.zAxis = zAxis;
        return self;
    };
}

@end
