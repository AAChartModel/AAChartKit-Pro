//
//  AASeriesDataElement.h
//  AAChartKitDemo
//
//  Created by AnAn on 2018/9/2.
//  Copyright © 2018年 Danny boy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AASeriesDataElement : NSObject

AAPropStatementAndPropSetFuncStatement(copy, AASeriesDataElement, NSString *, id);
AAPropStatementAndPropSetFuncStatement(copy, AASeriesDataElement, NSString *, name);
AAPropStatementAndPropSetFuncStatement(copy, AASeriesDataElement, NSString *, color);
AAPropStatementAndPropSetFuncStatement(copy, AASeriesDataElement, NSString *, parent);
AAPropStatementAndPropSetFuncStatement(strong, AASeriesDataElement, NSNumber *, value);
AAPropStatementAndPropSetFuncStatement(strong, AASeriesDataElement, NSNumber *, y);
AAPropStatementAndPropSetFuncStatement(strong, AASeriesDataElement, NSNumber *, z);

@end
