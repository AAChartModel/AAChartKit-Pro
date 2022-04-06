//
//  AALevelsElement.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2020/6/10.
//  Copyright © 2020 An An. All rights reserved.
//

#import "AALevelsElement.h"

@implementation AALevelsElement

AAPropSetFuncImplementation(AALevelsElement, NSString *, borderColor)
AAPropSetFuncImplementation(AALevelsElement, NSString *, borderDashStyle)
AAPropSetFuncImplementation(AALevelsElement, NSNumber *, borderWidth)
AAPropSetFuncImplementation(AALevelsElement, NSString *, color)
AAPropSetFuncImplementation(AALevelsElement, id        , colorByPoint)
AAPropSetFuncImplementation(AALevelsElement, AADataLabels *, dataLabels)
AAPropSetFuncImplementation(AALevelsElement, NSString *, layoutAlgorithm)
AAPropSetFuncImplementation(AALevelsElement, NSString *, layoutStartingDirection)
AAPropSetFuncImplementation(AALevelsElement, NSNumber *, level)
AAPropSetFuncImplementation(AALevelsElement, AAColorVariation *, colorVariation)

@end

@implementation AAColorVariation

AAPropSetFuncImplementation(AAColorVariation, NSString *, key)
AAPropSetFuncImplementation(AAColorVariation, NSNumber *, to)

@end
