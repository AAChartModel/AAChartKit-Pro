//
//  AASolidgauge.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AADataLabels;
NS_ASSUME_NONNULL_BEGIN

@interface AASolidgauge : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AASolidgauge, AADataLabels *, dataLabels)
AAPropStatementAndPropSetFuncStatement(copy,   AASolidgauge, NSString     *, linecap)
AAPropStatementAndPropSetFuncStatement(assign, AASolidgauge, BOOL          , stickyTracking)
AAPropStatementAndPropSetFuncStatement(assign, AASolidgauge, BOOL          , rounded)

@end

NS_ASSUME_NONNULL_END
