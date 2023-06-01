//
//  AAHeatmap.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AATooltip;
NS_ASSUME_NONNULL_BEGIN

@interface AAHeatmap : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAHeatmap, NSNumber  *, borderWidth)
AAPropStatementAndPropSetFuncStatement(copy,   AAHeatmap, NSString  *, nullColor)
AAPropStatementAndPropSetFuncStatement(strong, AAHeatmap, NSNumber  *, colsize)
AAPropStatementAndPropSetFuncStatement(strong, AAHeatmap, AATooltip *, tooltip)
AAPropStatementAndPropSetFuncStatement(strong, AAHeatmap, NSArray   *, data)
AAPropStatementAndPropSetFuncStatement(strong, AAHeatmap, NSNumber  *, turboThreshold)

@end

NS_ASSUME_NONNULL_END
