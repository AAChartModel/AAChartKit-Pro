//
//  AAItem.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/1.
//  Copyright © 2022 An An. All rights reserved.
//

#import "AAItem.h"

@implementation AAItem

AAPropSetFuncImplementation(AAItem, NSString     *, name)
AAPropSetFuncImplementation(AAItem, NSArray      *, data)
AAPropSetFuncImplementation(AAItem, NSArray      *, keys)
AAPropSetFuncImplementation(AAItem, NSNumber     *, size)
AAPropSetFuncImplementation(AAItem, BOOL,           allowPointSelect)
AAPropSetFuncImplementation(AAItem, NSString     *, cursor)
AAPropSetFuncImplementation(AAItem, AADataLabels *, dataLabels)
AAPropSetFuncImplementation(AAItem, BOOL,           showInLegend)
AAPropSetFuncImplementation(AAItem, NSNumber     *, startAngle)
AAPropSetFuncImplementation(AAItem, NSNumber     *, endAngle)
AAPropSetFuncImplementation(AAItem, NSArray      *, center)

@end
