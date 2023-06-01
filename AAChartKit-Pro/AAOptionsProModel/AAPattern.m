//
//  AAPattern.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2023/6/1.
//  Copyright © 2023 An An. All rights reserved.
//

#import "AAPattern.h"

@implementation AAPattern : NSObject

AAPropSetFuncImplementation(AAPattern, id, animation)
AAPropSetFuncImplementation(AAPattern, AAPatternOptions *, pattern)
AAPropSetFuncImplementation(AAPattern, NSNumber *, patternIndex)

@end


@implementation AAPatternOptions

AAPropSetFuncImplementation(AAPatternOptions, NSNumber *, aspectRatio)
AAPropSetFuncImplementation(AAPatternOptions, NSString *, backgroundColor)
AAPropSetFuncImplementation(AAPatternOptions, NSString *, color)
AAPropSetFuncImplementation(AAPatternOptions, NSNumber *, height)
AAPropSetFuncImplementation(AAPatternOptions, NSString *, id)
AAPropSetFuncImplementation(AAPatternOptions, NSString *, image)
AAPropSetFuncImplementation(AAPatternOptions, NSNumber *, opacity)
AAPropSetFuncImplementation(AAPatternOptions, NSString *, path)
AAPropSetFuncImplementation(AAPatternOptions, NSString *, patternTransform)
AAPropSetFuncImplementation(AAPatternOptions, NSNumber *, width)
AAPropSetFuncImplementation(AAPatternOptions, NSNumber *, x)
AAPropSetFuncImplementation(AAPatternOptions, NSNumber *, y)

@end
