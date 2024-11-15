//
//  AAOptions3D.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/15.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AAOptions3D.h"

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
@implementation AAOptions3D

AAPropSetFuncImplementation(AAOptions3D, BOOL      , enabled)
AAPropSetFuncImplementation(AAOptions3D, NSNumber *, alpha)
AAPropSetFuncImplementation(AAOptions3D, NSNumber *, beta)
AAPropSetFuncImplementation(AAOptions3D, NSNumber *, depth)
AAPropSetFuncImplementation(AAOptions3D, NSNumber *, viewDistance)
AAPropSetFuncImplementation(AAOptions3D, BOOL      , fitToPlot)
AAPropSetFuncImplementation(AAOptions3D, AAFrame   *, frame)

@end


@implementation AAFrame

AAPropSetFuncImplementation(AAFrame, NSDictionary *, bottom)
AAPropSetFuncImplementation(AAFrame, NSDictionary *, back)
AAPropSetFuncImplementation(AAFrame, NSDictionary *, side)

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

@implementation AAZAxis

AAPropSetFuncImplementation(AAZAxis, NSNumber *, min)
AAPropSetFuncImplementation(AAZAxis, NSNumber *, max)
AAPropSetFuncImplementation(AAZAxis, NSArray  *, categories)
AAPropSetFuncImplementation(AAZAxis, AALabels *, labels)
//showFirstLabel
AAPropSetFuncImplementation(AAZAxis, BOOL      , showFirstLabel)

@end
