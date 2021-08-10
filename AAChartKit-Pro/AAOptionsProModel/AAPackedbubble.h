//
//  AAPackedbubble.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2020/6/10.
//  Copyright © 2020 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AADataLabels,AALayoutAlgorithm;

@interface AAPackedbubble : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AAPackedbubble, NSString *, minSize)
AAPropStatementAndPropSetFuncStatement(copy,   AAPackedbubble, NSString *, maxSize)
AAPropStatementAndPropSetFuncStatement(strong, AAPackedbubble, NSNumber *, zMin)
AAPropStatementAndPropSetFuncStatement(strong, AAPackedbubble, NSNumber *, zMax)
AAPropStatementAndPropSetFuncStatement(strong, AAPackedbubble, AALayoutAlgorithm *, layoutAlgorithm)
AAPropStatementAndPropSetFuncStatement(strong, AAPackedbubble, AADataLabels *, dataLabels)

@end

NS_ASSUME_NONNULL_END
