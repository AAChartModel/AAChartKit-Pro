//
//  AASolidgaugeDataElement.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AADataLabels, AAMarker;
NS_ASSUME_NONNULL_BEGIN

@interface AASolidgaugeDataElement : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AASolidgaugeDataElement, NSString     *, radius)
AAPropStatementAndPropSetFuncStatement(copy,   AASolidgaugeDataElement, NSString     *, innerRadius)

AAPropStatementAndPropSetFuncStatement(copy  , AASolidgaugeDataElement, NSString *, color)
AAPropStatementAndPropSetFuncStatement(strong, AASolidgaugeDataElement, AADataLabels *, dataLabels)
AAPropStatementAndPropSetFuncStatement(strong, AASolidgaugeDataElement, AAMarker *, marker)
AAPropStatementAndPropSetFuncStatement(strong, AASolidgaugeDataElement, NSNumber *, y)

@end

NS_ASSUME_NONNULL_END
