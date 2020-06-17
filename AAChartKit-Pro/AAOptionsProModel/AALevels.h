//
//  AALevels.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2020/6/10.
//  Copyright © 2020 Danny boy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class AADataLabels, AAColorVariation;

@interface AALevels : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AALevels, NSString *, borderColor)
AAPropStatementAndPropSetFuncStatement(copy,   AALevels, NSString *, borderDashStyle)
AAPropStatementAndPropSetFuncStatement(strong, AALevels, NSNumber *, borderWidth)
AAPropStatementAndPropSetFuncStatement(copy,   AALevels, NSString *, color)
AAPropStatementAndPropSetFuncStatement(assign, AALevels, id        , colorByPoint) 
AAPropStatementAndPropSetFuncStatement(strong, AALevels, AADataLabels *, dataLabels)
AAPropStatementAndPropSetFuncStatement(copy,   AALevels, NSString *, layoutAlgorithm)
AAPropStatementAndPropSetFuncStatement(copy,   AALevels, NSString *, layoutStartingDirection)
AAPropStatementAndPropSetFuncStatement(strong, AALevels, NSNumber *, level)
AAPropStatementAndPropSetFuncStatement(strong, AALevels, AAColorVariation *, colorVariation)

@end

@interface AAColorVariation : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AAColorVariation, NSString *, key)
AAPropStatementAndPropSetFuncStatement(strong, AAColorVariation, NSNumber *, to)

@end

NS_ASSUME_NONNULL_END
