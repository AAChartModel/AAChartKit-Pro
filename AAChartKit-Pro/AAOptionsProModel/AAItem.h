//
//  AAItem.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/1.
//  Copyright © 2022 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class AADataLabels;

@interface AAItem : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AAItem, NSString     *, name)
AAPropStatementAndPropSetFuncStatement(strong, AAItem, NSArray      *, data)
AAPropStatementAndPropSetFuncStatement(strong, AAItem, NSArray      *, keys)
AAPropStatementAndPropSetFuncStatement(strong, AAItem, NSNumber     *, size)
AAPropStatementAndPropSetFuncStatement(assign, AAItem, BOOL,           allowPointSelect)
AAPropStatementAndPropSetFuncStatement(copy,   AAItem, NSString     *, cursor)
AAPropStatementAndPropSetFuncStatement(strong, AAItem, AADataLabels *, dataLabels)
AAPropStatementAndPropSetFuncStatement(assign, AAItem, BOOL,           showInLegend)
AAPropStatementAndPropSetFuncStatement(strong, AAItem, NSNumber     *, startAngle)
AAPropStatementAndPropSetFuncStatement(strong, AAItem, NSNumber     *, endAngle)
AAPropStatementAndPropSetFuncStatement(strong, AAItem, NSArray      *, center)

@end

NS_ASSUME_NONNULL_END
