//
//  AAOptions3D.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/15.
//  Copyright © 2024 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AAFrame;

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

NS_ASSUME_NONNULL_END
