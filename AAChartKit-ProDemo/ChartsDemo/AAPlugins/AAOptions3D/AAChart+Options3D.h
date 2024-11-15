//
//  AAChart+Options3D.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/15.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AAChart.h"
#import "AAOptions3D.h"

NS_ASSUME_NONNULL_BEGIN

@interface AAChart (Options3D)

//为 AAChart 对象添加 AAOpton3D 属性
AAPropStatementAndPropSetFuncStatement(strong, AAChart, AAOptions3D *,       options3d)

@end

NS_ASSUME_NONNULL_END
