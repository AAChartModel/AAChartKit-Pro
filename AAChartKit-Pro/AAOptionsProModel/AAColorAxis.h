//
//  AAColorAxis.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2020/6/6.
//  Copyright © 2020 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AADataClassesElement;

@interface AAColorAxis : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAColorAxis, NSNumber *, min)
AAPropStatementAndPropSetFuncStatement(copy,   AAColorAxis, NSString *, minColor)
AAPropStatementAndPropSetFuncStatement(copy,   AAColorAxis, NSString *, maxColor)
AAPropStatementAndPropSetFuncStatement(strong, AAColorAxis, NSArray<AADataClassesElement *> *, dataClasses)

@end

@interface AADataClassesElement : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AADataClassesElement, NSNumber *, from)
AAPropStatementAndPropSetFuncStatement(strong, AADataClassesElement, NSNumber *, to)
AAPropStatementAndPropSetFuncStatement(copy,   AADataClassesElement, NSString *, color)
AAPropStatementAndPropSetFuncStatement(copy,   AADataClassesElement, NSString *, name)

@end

NS_ASSUME_NONNULL_END
