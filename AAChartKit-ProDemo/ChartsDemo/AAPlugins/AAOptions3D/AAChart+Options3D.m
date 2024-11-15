//
//  AAChart+Options3D.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/15.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AAChart+Options3D.h"
//导入 runtime 头文件
#import <objc/runtime.h>

@implementation AAChart (Options3D)

//使用关联对象, 实现添加 options3d 属性
- (void)setOptions3d:(AAOptions3D *)options3d {
    objc_setAssociatedObject(self, @selector(options3d), options3d, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (AAOptions3D *)options3d {
    return objc_getAssociatedObject(self, @selector(options3d));
}

- (AAChart * (^) (AAOptions3D * options3d))options3dSet {
    return ^(AAOptions3D * options3d) {
        self.options3d = options3d;
        return self;
    };
}

@end
