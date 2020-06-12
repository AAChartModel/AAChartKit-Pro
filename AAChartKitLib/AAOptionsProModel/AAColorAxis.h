//
//  AAColorAxis.h
//  AAChartKitDemo
//
//  Created by AnAn on 2020/6/6.
//  Copyright © 2020 Danny boy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AADataClasses;

@interface AAColorAxis : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAColorAxis, NSNumber *, min)
AAPropStatementAndPropSetFuncStatement(copy,   AAColorAxis, NSString *, minColor)
AAPropStatementAndPropSetFuncStatement(copy,   AAColorAxis, NSString *, maxColor)
AAPropStatementAndPropSetFuncStatement(strong, AAColorAxis, NSArray<AADataClasses *> *, dataClasses)

@end

@interface AADataClasses : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AADataClasses, NSNumber *, from)
AAPropStatementAndPropSetFuncStatement(strong, AADataClasses, NSNumber *, to)
AAPropStatementAndPropSetFuncStatement(copy,   AADataClasses, NSString *, color)
AAPropStatementAndPropSetFuncStatement(copy,   AADataClasses, NSString *, name)

@end

NS_ASSUME_NONNULL_END
