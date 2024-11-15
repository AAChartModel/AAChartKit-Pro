//
//  AABoost.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/11.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AABoost.h"
#import "AAChartView.h"
/**
 AAPropStatementAndPropSetFuncStatement(assign, AABoost, BOOL, allowForce)
 AAPropStatementAndPropSetFuncStatement(assign, AABoost, BOOL, enabled)
 AAPropStatementAndPropSetFuncStatement(assign, AABoost, BOOL, useGPUTranslations)
 AAPropStatementAndPropSetFuncStatement(assign, AABoost, BOOL, usePreallocated)
 AAPropStatementAndPropSetFuncStatement(strong, AABoost, NSNumber *, pixelRatio)
 AAPropStatementAndPropSetFuncStatement(strong, AABoost, NSNumber *, seriesThreshold)
 AAPropStatementAndPropSetFuncStatement(strong, AABoost, NSDictionary *, debug)

 @end


 @interface AADebug : NSObject

 AAPropStatementAndPropSetFuncStatement(assign, AADebug, BOOL, showSkipSummary)
 AAPropStatementAndPropSetFuncStatement(assign, AADebug, BOOL, timeBufferCopy)
 AAPropStatementAndPropSetFuncStatement(assign, AADebug, BOOL, timeKDTree)
 AAPropStatementAndPropSetFuncStatement(assign, AADebug, BOOL, timeRendering)
 AAPropStatementAndPropSetFuncStatement(assign, AADebug, BOOL, timeSeriesProcessing)
 AAPropStatementAndPropSetFuncStatement(assign, AADebug, BOOL, timeSetup)

 @end
 */

@implementation AABoost

AAPropSetFuncImplementation(AABoost, id, allowForce)
AAPropSetFuncImplementation(AABoost, id, enabled)
AAPropSetFuncImplementation(AABoost, id, useGPUTranslations)
AAPropSetFuncImplementation(AABoost, id, usePreallocated)
AAPropSetFuncImplementation(AABoost, NSNumber *, pixelRatio)
AAPropSetFuncImplementation(AABoost, NSNumber *, seriesThreshold)
AAPropSetFuncImplementation(AABoost, AADebug  *, debug)

- (NSDictionary *)toDic {
    NSDictionary *jsonDic = [AAJsonConverter dictionaryWithObjectInstance:self];
    return jsonDic;
}

@end


@implementation AADebug

AAPropSetFuncImplementation(AADebug, BOOL, showSkipSummary)
AAPropSetFuncImplementation(AADebug, BOOL, timeBufferCopy)
AAPropSetFuncImplementation(AADebug, BOOL, timeKDTree)
AAPropSetFuncImplementation(AADebug, BOOL, timeRendering)
AAPropSetFuncImplementation(AADebug, BOOL, timeSeriesProcessing)
AAPropSetFuncImplementation(AADebug, BOOL, timeSetup)

@end
