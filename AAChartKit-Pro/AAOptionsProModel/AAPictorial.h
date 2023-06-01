//
//  AAPictorial.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2023/5/31.
//  Copyright © 2023 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AADataLabels;

NS_ASSUME_NONNULL_BEGIN

@interface AAPictorial : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAPictorial, NSNumber *, pointPadding)
AAPropStatementAndPropSetFuncStatement(strong, AAPictorial, NSNumber *, groupPadding)
AAPropStatementAndPropSetFuncStatement(strong, AAPictorial, AADataLabels *, dataLabels)
AAPropStatementAndPropSetFuncStatement(copy  , AAPictorial, NSString *, stacking)
AAPropStatementAndPropSetFuncStatement(strong, AAPictorial, NSArray *, paths)

@end


@interface AAPathsElement : NSObject

AAPropStatementAndPropSetFuncStatement(copy  , AAPathsElement, NSString *, definition)
AAPropStatementAndPropSetFuncStatement(strong, AAPathsElement, NSNumber *, max)

@end

NS_ASSUME_NONNULL_END

