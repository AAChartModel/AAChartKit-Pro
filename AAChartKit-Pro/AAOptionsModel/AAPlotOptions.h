//
//  AAPlotOptions.h
//  AAChartKit
//
//  Created by An An on 17/1/5.
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

#import <Foundation/Foundation.h>

//AAChartKit
@class AAColumn, AABar, AALine, AASpline, AAArea, AAAreaspline, AAPie, AAColumnrange, AASeries, AABubble;
//AAChartKit-Pro
@class AAPackedbubble, AATreemap, AASolidgauge, AAPictorial, AAOrganization;

@interface AAPlotOptions : NSObject

//Common
AAPropStatementAndPropSetFuncStatement(strong, AAPlotOptions, AAColumn       *, column)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotOptions, AALine         *, line)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotOptions, AAPie          *, pie)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotOptions, AABar          *, bar)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotOptions, AASpline       *, spline)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotOptions, AASeries       *, series)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotOptions, AAArea         *, area)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotOptions, AAAreaspline   *, areaspline)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotOptions, AAColumnrange  *, columnrange)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotOptions, NSObject       *, arearange)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotOptions, AABubble       *, bubble)

//Pro
AAPropStatementAndPropSetFuncStatement(strong, AAPlotOptions, AAPackedbubble *, packedbubble)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotOptions, AATreemap      *, treemap)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotOptions, AASolidgauge   *, solidgauge)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotOptions, AAPictorial    *, pictorial)
AAPropStatementAndPropSetFuncStatement(strong, AAPlotOptions, AAOrganization *, organization)

@end
