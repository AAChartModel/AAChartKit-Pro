//
//  AAData.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAData : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AAData, NSString     *, csv)
AAPropStatementAndPropSetFuncStatement(copy,   AAData, NSString     *, parsed)

@end

NS_ASSUME_NONNULL_END
