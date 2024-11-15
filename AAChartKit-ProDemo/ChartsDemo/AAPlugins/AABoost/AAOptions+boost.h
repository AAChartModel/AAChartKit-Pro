//
//  AAOptions+boost.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/11.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AAOptions.h"
#import "AABoost.h"

NS_ASSUME_NONNULL_BEGIN

@interface AAOptions (boost)

//为 AAOption 添加一个 boost 属性
AAPropStatementAndPropSetFuncStatement(strong, AAOptions, AABoost *, boost)

@end

NS_ASSUME_NONNULL_END
