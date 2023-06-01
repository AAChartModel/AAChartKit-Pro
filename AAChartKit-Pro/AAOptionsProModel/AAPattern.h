//
//  AAPattern.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2023/6/1.
//  Copyright © 2023 An An. All rights reserved.
//  https://api.highcharts.com/class-reference/Highcharts.PatternOptionsObject#toc0

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAPattern : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAPattern, NSNumber *, aspectRatio)
AAPropStatementAndPropSetFuncStatement(strong, AAPattern, NSString *, backgroundColor)
AAPropStatementAndPropSetFuncStatement(strong, AAPattern, NSString *, color)
AAPropStatementAndPropSetFuncStatement(strong, AAPattern, NSNumber *, height)
AAPropStatementAndPropSetFuncStatement(copy,   AAPattern, NSString *, id)
AAPropStatementAndPropSetFuncStatement(copy,   AAPattern, NSString *, image)
AAPropStatementAndPropSetFuncStatement(strong, AAPattern, NSNumber *, opacity)
AAPropStatementAndPropSetFuncStatement(strong, AAPattern, NSString *, path)
AAPropStatementAndPropSetFuncStatement(copy,   AAPattern, NSString *, patternTransform)
AAPropStatementAndPropSetFuncStatement(strong, AAPattern, NSNumber *, width)
AAPropStatementAndPropSetFuncStatement(strong, AAPattern, NSNumber *, x)
AAPropStatementAndPropSetFuncStatement(strong, AAPattern, NSNumber *, y)

@end

NS_ASSUME_NONNULL_END
