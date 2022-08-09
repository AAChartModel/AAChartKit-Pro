//
//  AAColorAxis.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2020/6/6.
//  Copyright © 2020 An An. All rights reserved.
//

#import "AAColorAxis.h"

@implementation AAColorAxis

AAPropSetFuncImplementation(AAColorAxis, NSNumber *, min)
AAPropSetFuncImplementation(AAColorAxis, NSString *, minColor)
AAPropSetFuncImplementation(AAColorAxis, NSString *, maxColor)
AAPropSetFuncImplementation(AAColorAxis, NSArray<AADataClassesElement *> *, dataClasses)
AAPropSetFuncImplementation(AAColorAxis, NSArray *, stops)
AAPropSetFuncImplementation(AAColorAxis, NSNumber *, max)
AAPropSetFuncImplementation(AAColorAxis, BOOL      , startOnTick)
AAPropSetFuncImplementation(AAColorAxis, BOOL      , endOnTick)
AAPropSetFuncImplementation(AAColorAxis, AALabels *, labels)

@end

@implementation AADataClassesElement

AAPropSetFuncImplementation(AADataClassesElement, NSNumber *, from)
AAPropSetFuncImplementation(AADataClassesElement, NSNumber *, to)
AAPropSetFuncImplementation(AADataClassesElement, NSString *, color)
AAPropSetFuncImplementation(AADataClassesElement, NSString *, name)

@end
