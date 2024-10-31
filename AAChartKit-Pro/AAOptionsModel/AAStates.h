//
//  AAStates.h
//  AAChartKitDemo
//
//  Created by AnAn on 2020/1/6.
//  Copyright © 2020 An An. All rights reserved.
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

#import <Foundation/Foundation.h>

@class AAHover, AASelect, AAHalo, AAInactive;

@interface AAStates : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAStates, AAHover    *, hover)
AAPropStatementAndPropSetFuncStatement(strong, AAStates, AASelect   *, select)
AAPropStatementAndPropSetFuncStatement(strong, AAStates, AAInactive *, inactive)


@end


@interface AAHover : NSObject

AAPropStatementAndPropSetFuncStatement(assign, AAHover, BOOL,       enabled)
AAPropStatementAndPropSetFuncStatement(copy,   AAHover, NSString *, borderColor)
AAPropStatementAndPropSetFuncStatement(strong, AAHover, NSNumber *, brightness)
AAPropStatementAndPropSetFuncStatement(copy,   AAHover, NSString *, color)
AAPropStatementAndPropSetFuncStatement(strong, AAHover, AAHalo   *, halo)
AAPropStatementAndPropSetFuncStatement(strong, AAHover, NSNumber *, lineWidth)
AAPropStatementAndPropSetFuncStatement(strong, AAHover, NSNumber *, lineWidthPlus)
AAPropStatementAndPropSetFuncStatement(copy,   AAHover, NSString *, lineColor)

@end


@interface AASelect : NSObject

AAPropStatementAndPropSetFuncStatement(assign, AASelect, BOOL,       enabled)
AAPropStatementAndPropSetFuncStatement(copy,   AASelect, NSString *, borderColor)
AAPropStatementAndPropSetFuncStatement(copy,   AASelect, NSString *, color)
AAPropStatementAndPropSetFuncStatement(strong, AASelect, AAHalo   *, halo)

@end


@interface AAHalo : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAHalo, NSDictionary *, attributes)//A collection of SVG attributes to override the appearance of the halo, for example fill, stroke and stroke-width.
AAPropStatementAndPropSetFuncStatement(strong, AAHalo, NSNumber *, opacity)//Opacity for the halo unless a specific fill is overridden using the attributes setting. Note that Highcharts is only able to apply opacity to colors of hex or rgb(a) formats. Default Value：0.25.
AAPropStatementAndPropSetFuncStatement(strong, AAHalo, NSNumber *, size)

@end


@interface AAInactive : NSObject

AAPropStatementAndPropSetFuncStatement(assign, AAInactive, BOOL,       enabled)
AAPropStatementAndPropSetFuncStatement(strong, AAInactive, NSNumber *, opacity)

@end



