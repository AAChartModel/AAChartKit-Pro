//
//  AAColorAxis.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2020/6/6.
//  Copyright © 2020 Danny boy. All rights reserved.
//

#import "AAColorAxis.h"

@implementation AAColorAxis

AAPropSetFuncImplementation(AAColorAxis, NSNumber *, min)
AAPropSetFuncImplementation(AAColorAxis, NSString *, minColor)
AAPropSetFuncImplementation(AAColorAxis, NSString *, maxColor)
AAPropSetFuncImplementation(AAColorAxis, NSArray<AADataClasses *> *, dataClasses)

@end

@implementation AADataClasses

AAPropSetFuncImplementation(AADataClasses, NSNumber *, from)
AAPropSetFuncImplementation(AADataClasses, NSNumber *, to)
AAPropSetFuncImplementation(AADataClasses, NSString *, color)
AAPropSetFuncImplementation(AADataClasses, NSString *, name)

@end
