//
//  AAPictorial.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2023/5/31.
//  Copyright © 2023 An An. All rights reserved.
//

#import "AAPictorial.h"

@implementation AAPictorial

AAPropSetFuncImplementation(AAPictorial, NSNumber     *, pointPadding)
AAPropSetFuncImplementation(AAPictorial, NSNumber     *, groupPadding)
AAPropSetFuncImplementation(AAPictorial, AADataLabels *, dataLabels)
AAPropSetFuncImplementation(AAPictorial, NSString     *, stacking)
AAPropSetFuncImplementation(AAPictorial, NSArray *, paths)

@end


@implementation AAPathsElement

AAPropSetFuncImplementation(AAPathsElement, NSString *, definition)
AAPropSetFuncImplementation(AAPathsElement, NSNumber *, max)

@end
