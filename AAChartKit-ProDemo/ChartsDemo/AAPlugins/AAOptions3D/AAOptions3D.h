//
//  AAOptions3D.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/15.
//  Copyright © 2024 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AAFrame, AALabels;

NS_ASSUME_NONNULL_BEGIN

/**
 options3d: {
            enabled: true,
            alpha: 10,
            beta: 30,
            depth: 250,
            viewDistance: 5,
            fitToPlot: false,
            frame: {
                bottom: { size: 1, color: 'rgba(0,0,0,0.02)' },
                back: { size: 1, color: 'rgba(0,0,0,0.04)' },
                side: { size: 1, color: 'rgba(0,0,0,0.06)' }
            }
        }
 */
@interface AAOptions3D : NSObject

AAPropStatementAndPropSetFuncStatement(assign, AAOptions3D, BOOL      , enabled)
AAPropStatementAndPropSetFuncStatement(strong, AAOptions3D, NSNumber *, alpha)
AAPropStatementAndPropSetFuncStatement(strong, AAOptions3D, NSNumber *, beta)
AAPropStatementAndPropSetFuncStatement(strong, AAOptions3D, NSNumber *, depth)
AAPropStatementAndPropSetFuncStatement(strong, AAOptions3D, NSNumber *, viewDistance)
AAPropStatementAndPropSetFuncStatement(assign, AAOptions3D, BOOL      , fitToPlot)
AAPropStatementAndPropSetFuncStatement(strong, AAOptions3D, AAFrame  *, frame)

@end


@interface AAFrame : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAFrame, NSDictionary *, bottom)
AAPropStatementAndPropSetFuncStatement(strong, AAFrame, NSDictionary *, back)
AAPropStatementAndPropSetFuncStatement(strong, AAFrame, NSDictionary *, side)

@end


/**
 zAxis: {
     min: 0,
     max: 3,
     categories: ['A01', 'A02', 'A03', 'A04', 'A05', 'A06', 'A07', 'A08', 'A09', 'A10', 'A11', 'A12'],
     labels: {
         y: 5,
         rotation: 18
     }
 },
 */
@interface AAZAxis : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAZAxis, NSNumber *, min)
AAPropStatementAndPropSetFuncStatement(strong, AAZAxis, NSNumber *, max)
AAPropStatementAndPropSetFuncStatement(strong, AAZAxis, NSArray  *, categories)
AAPropStatementAndPropSetFuncStatement(strong, AAZAxis, AALabels *, labels)
//showFirstLabel
AAPropStatementAndPropSetFuncStatement(assign, AAZAxis, BOOL, showFirstLabel)

@end

NS_ASSUME_NONNULL_END
