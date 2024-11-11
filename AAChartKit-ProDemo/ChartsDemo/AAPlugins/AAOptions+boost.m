//
//  AAOptions+boost.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/11.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AAOptions+boost.h"
//导入 runtime
#import <objc/runtime.h>

@implementation AAOptions (boost)

//使用关联对象, 实现添加 boost 属性
- (void)setBoost:(NSDictionary *)boost {
    objc_setAssociatedObject(self, @selector(boost), boost, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSDictionary *)boost {
    return objc_getAssociatedObject(self, @selector(boost));
}

//AAPropSetFuncImplementation(AAOptions, AABoost *, boost)
//- (className * (^) (propertyPointerType propertyName))propertyName##Set {                                               \
//return ^(propertyPointerType propertyName) {                                                                            \
//self->_##propertyName = propertyName;                                                                                   \
//return self;                                                                                                            \
//};                                                                                                                      \
//}

- (AAOptions * (^) (AABoost * boost))boostSet {
    return ^(AABoost * boost) {
        self.boost = boost;
        return self;
    };
}

@end
