//
//  AALevelsElement.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2020/6/10.
//  Copyright © 2020 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class AADataLabels, AAColorVariation;

@interface AALevelsElement : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AALevelsElement, NSString *, borderColor)
AAPropStatementAndPropSetFuncStatement(copy,   AALevelsElement, NSString *, borderDashStyle)
AAPropStatementAndPropSetFuncStatement(strong, AALevelsElement, NSNumber *, borderWidth)
AAPropStatementAndPropSetFuncStatement(copy,   AALevelsElement, NSString *, color)
AAPropStatementAndPropSetFuncStatement(assign, AALevelsElement, id        , colorByPoint) 
AAPropStatementAndPropSetFuncStatement(strong, AALevelsElement, AADataLabels *, dataLabels)
AAPropStatementAndPropSetFuncStatement(copy,   AALevelsElement, NSString *, layoutAlgorithm)
AAPropStatementAndPropSetFuncStatement(copy,   AALevelsElement, NSString *, layoutStartingDirection)
AAPropStatementAndPropSetFuncStatement(strong, AALevelsElement, NSNumber *, level)
AAPropStatementAndPropSetFuncStatement(strong, AALevelsElement, AAColorVariation *, colorVariation)
AAPropStatementAndPropSetFuncStatement(strong, AALevelsElement, NSNumber *, height)

@end

@interface AAColorVariation : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AAColorVariation, NSString *, key)
AAPropStatementAndPropSetFuncStatement(strong, AAColorVariation, NSNumber *, to)

@end

NS_ASSUME_NONNULL_END
