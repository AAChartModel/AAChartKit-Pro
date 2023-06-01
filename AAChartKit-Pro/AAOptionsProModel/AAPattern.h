//
//  AAPattern.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2023/6/1.
//  Copyright © 2023 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AAPatternOptions;

NS_ASSUME_NONNULL_BEGIN

//https://api.highcharts.com/class-reference/Highcharts.PatternObject#toc0
@interface AAPattern : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAPattern, id, animation)
AAPropStatementAndPropSetFuncStatement(strong, AAPattern, AAPatternOptions *, pattern)
AAPropStatementAndPropSetFuncStatement(strong, AAPattern, NSNumber *, patternIndex)

@end


//https://api.highcharts.com/class-reference/Highcharts.PatternOptionsObject#toc0
@interface AAPatternOptions : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAPatternOptions, NSNumber *, aspectRatio)
AAPropStatementAndPropSetFuncStatement(strong, AAPatternOptions, NSString *, backgroundColor)
AAPropStatementAndPropSetFuncStatement(strong, AAPatternOptions, NSString *, color)
AAPropStatementAndPropSetFuncStatement(strong, AAPatternOptions, NSNumber *, height)
AAPropStatementAndPropSetFuncStatement(copy,   AAPatternOptions, NSString *, id)
AAPropStatementAndPropSetFuncStatement(copy,   AAPatternOptions, NSString *, image)
AAPropStatementAndPropSetFuncStatement(strong, AAPatternOptions, NSNumber *, opacity)
AAPropStatementAndPropSetFuncStatement(strong, AAPatternOptions, NSString *, path)
AAPropStatementAndPropSetFuncStatement(copy,   AAPatternOptions, NSString *, patternTransform)
AAPropStatementAndPropSetFuncStatement(strong, AAPatternOptions, NSNumber *, width)
AAPropStatementAndPropSetFuncStatement(strong, AAPatternOptions, NSNumber *, x)
AAPropStatementAndPropSetFuncStatement(strong, AAPatternOptions, NSNumber *, y)

@end

NS_ASSUME_NONNULL_END
