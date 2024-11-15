//
//  AAOptions+ZAxis.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/15.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AAOptions.h"
#import "AAOptions3D.h"

NS_ASSUME_NONNULL_BEGIN

@interface AAOptions (ZAxis)

//为 AAChart 对象添加 zAxis 属性
AAPropStatementAndPropSetFuncStatement(strong, AAOptions, AAZAxis *,       zAxis)

@end

NS_ASSUME_NONNULL_END
