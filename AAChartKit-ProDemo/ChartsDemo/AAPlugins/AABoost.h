//
//  AABoost.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/11.
//  Copyright © 2024 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AADebug;

NS_ASSUME_NONNULL_BEGIN

@interface AABoost : NSObject

/**
 boost:{
 allowForce:true
 debug:{
 showSkipSummary:false
 timeBufferCopy:false
 timeKDTree:false
 timeRendering:false
 timeSeriesProcessing:false
 timeSetup:false
 }
 enabled:true
 pixelRatio:1
 seriesThreshold:50
 useGPUTranslations:false
 usePreallocated:false
 }
 */

AAPropStatementAndPropSetFuncStatement(assign, AABoost, BOOL, allowForce)
AAPropStatementAndPropSetFuncStatement(assign, AABoost, BOOL, enabled)
AAPropStatementAndPropSetFuncStatement(assign, AABoost, BOOL, useGPUTranslations)
AAPropStatementAndPropSetFuncStatement(assign, AABoost, BOOL, usePreallocated)
AAPropStatementAndPropSetFuncStatement(strong, AABoost, NSNumber *, pixelRatio)
AAPropStatementAndPropSetFuncStatement(strong, AABoost, NSNumber *, seriesThreshold)
AAPropStatementAndPropSetFuncStatement(strong, AABoost, AADebug  *, debug)

@end


@interface AADebug : NSObject

AAPropStatementAndPropSetFuncStatement(assign, AADebug, BOOL, showSkipSummary)
AAPropStatementAndPropSetFuncStatement(assign, AADebug, BOOL, timeBufferCopy)
AAPropStatementAndPropSetFuncStatement(assign, AADebug, BOOL, timeKDTree)
AAPropStatementAndPropSetFuncStatement(assign, AADebug, BOOL, timeRendering)
AAPropStatementAndPropSetFuncStatement(assign, AADebug, BOOL, timeSeriesProcessing)
AAPropStatementAndPropSetFuncStatement(assign, AADebug, BOOL, timeSetup)

@end

NS_ASSUME_NONNULL_END
