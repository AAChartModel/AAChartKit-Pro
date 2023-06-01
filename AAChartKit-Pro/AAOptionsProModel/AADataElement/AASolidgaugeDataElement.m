//
//  AASolidgaugeDataElement.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import "AASolidgaugeDataElement.h"

@implementation AASolidgaugeDataElement

AAPropSetFuncImplementation(AASolidgaugeDataElement, NSString     *, radius)
AAPropSetFuncImplementation(AASolidgaugeDataElement, NSString     *, innerRadius)

AAPropSetFuncImplementation(AASolidgaugeDataElement, NSString *, color)
AAPropSetFuncImplementation(AASolidgaugeDataElement, AADataLabels *, dataLabels)
AAPropSetFuncImplementation(AASolidgaugeDataElement, AAMarker *, marker)
AAPropSetFuncImplementation(AASolidgaugeDataElement, NSNumber *, y)

@end
