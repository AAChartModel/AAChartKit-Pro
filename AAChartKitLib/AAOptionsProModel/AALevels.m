//
//  AALevels.m
//  AAChartKitDemo
//
//  Created by AnAn on 2020/6/10.
//  Copyright © 2020 Danny boy. All rights reserved.
//

#import "AALevels.h"

@implementation AALevels

AAPropSetFuncImplementation(AALevels, NSString *, borderColor)
AAPropSetFuncImplementation(AALevels, NSString *, borderDashStyle)
AAPropSetFuncImplementation(AALevels, NSNumber *, borderWidth)
AAPropSetFuncImplementation(AALevels, NSString *, color)
AAPropSetFuncImplementation(AALevels, id        , colorByPoint)
AAPropSetFuncImplementation(AALevels, AADataLabels *, dataLabels)
AAPropSetFuncImplementation(AALevels, NSString *, layoutAlgorithm)
AAPropSetFuncImplementation(AALevels, NSString *, layoutStartingDirection)
AAPropSetFuncImplementation(AALevels, NSNumber *, level)
AAPropSetFuncImplementation(AALevels, AAColorVariation *, colorVariation)

@end

@implementation AAColorVariation

AAPropSetFuncImplementation(AAColorVariation, NSString *, key)
AAPropSetFuncImplementation(AAColorVariation, NSNumber *, to)

@end
