//
//  AADataLabels.m
//  AAChartKit
//
//  Created by An An on 17/1/6.
//  Copyright © 2017年 An An. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

/*
 
 * -------------------------------------------------------------------------------
 *
 * 🌕 🌖 🌗 🌘  ❀❀❀   WARM TIPS!!!   ❀❀❀ 🌑 🌒 🌓 🌔
 *
 * Please contact me on GitHub,if there are any problems encountered in use.
 * GitHub Issues : https://github.com/AAChartModel/AAChartKit/issues
 * -------------------------------------------------------------------------------
 * And if you want to contribute for this project, please contact me as well
 * GitHub        : https://github.com/AAChartModel
 * StackOverflow : https://stackoverflow.com/users/12302132/codeforu
 * JianShu       : https://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 * -------------------------------------------------------------------------------
 
 */

#import "AADataLabels.h"
#import "NSString+toPureJSString.h"

@implementation AADataLabels

- (instancetype)init {
    self = [super init];
    if (self) {
        _enabled = true;
        _softConnector = true;
    }
    return self;
}

AAPropSetFuncImplementation(AADataLabels, BOOL      , enabled)
AAPropSetFuncImplementation(AADataLabels, NSString *, align)
AAPropSetFuncImplementation(AADataLabels, AAStyle  *, style) 
AAPropSetFuncImplementation(AADataLabels, NSString *, format)
//AAPropSetFuncImplementation(AADataLabels, NSString *, formatter)
AAPropSetFuncImplementation(AADataLabels, NSNumber *, rotation) 
AAPropSetFuncImplementation(AADataLabels, BOOL      , allowOverlap) 
AAPropSetFuncImplementation(AADataLabels, BOOL      , useHTML) 
AAPropSetFuncImplementation(AADataLabels, NSNumber *, distance)
AAPropSetFuncImplementation(AADataLabels, NSString *, verticalAlign)
AAPropSetFuncImplementation(AADataLabels, NSNumber *, x) 
AAPropSetFuncImplementation(AADataLabels, NSNumber *, y)
AAPropSetFuncImplementation(AADataLabels, NSString *, color)
AAPropSetFuncImplementation(AADataLabels, NSString *, backgroundColor)
AAPropSetFuncImplementation(AADataLabels, NSString *, borderColor)
AAPropSetFuncImplementation(AADataLabels, NSNumber *, borderRadius)
AAPropSetFuncImplementation(AADataLabels, NSNumber *, borderWidth)
AAPropSetFuncImplementation(AADataLabels, NSString *, shape)
AAPropSetFuncImplementation(AADataLabels, BOOL      , crop)
AAPropSetFuncImplementation(AADataLabels, BOOL      , inside)
AAPropSetFuncImplementation(AADataLabels, NSString *, overflow)
AAPropSetFuncImplementation(AADataLabels, BOOL      , softConnector) //Whether to render the connector as a soft arc or a line with sharp break. Only useful for pie, pyramid and funnel chart
AAPropSetFuncImplementation(AADataLabels, AAFilter   *, filter)
AAPropSetFuncImplementation(AADataLabels, AATextPath *, textPath)
AAPropSetFuncImplementation(AADataLabels, AATextPath *, linkTextPath)
AAPropSetFuncImplementation(AADataLabels, NSNumber   *, padding) //When either the borderWidth or the backgroundColor is set, this is the padding within the box. Defaults to 5.
AAPropSetFuncImplementation(AADataLabels, NSString   *, nodeFormat) //The format string specifying what to show for nodes in the sankey diagram. By default the nodeFormatter returns {point.name}. Defaults to undefined.


AAJSFuncTypePropSetFuncImplementation(AADataLabels, NSString *, formatter)

- (void)setFormatter:(NSString *)formatter {
    _formatter = [formatter aa_toPureJSString];
}


@end


@implementation AAFilter

AAPropSetFuncImplementation(AAFilter, NSString *, property)
AAPropSetFuncImplementation(AAFilter, NSString *, operator)
AAPropSetFuncImplementation(AAFilter, NSNumber *, value)

@end


@implementation AATextPath

AAPropSetFuncImplementation(AATextPath, BOOL          , enabled)
AAPropSetFuncImplementation(AATextPath, NSDictionary *, attributes)

@end
