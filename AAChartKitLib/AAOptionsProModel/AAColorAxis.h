//
//  AAColorAxis.h
//  AAChartKitDemo
//
//  Created by AnAn on 2020/6/6.
//  Copyright © 2020 Danny boy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAColorAxis : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AAColorAxis, NSNumber *, min)
AAPropStatementAndPropSetFuncStatement(copy, AAColorAxis, NSString *, minColor)
AAPropStatementAndPropSetFuncStatement(copy, AAColorAxis, NSString *, maxColor)


@end

NS_ASSUME_NONNULL_END
