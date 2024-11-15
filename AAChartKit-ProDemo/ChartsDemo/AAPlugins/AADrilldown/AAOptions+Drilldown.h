//
//  AAOptions+Drilldown.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/15.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AAOptions.h"
#import "AADrilldown.h"

NS_ASSUME_NONNULL_BEGIN

@interface AAOptions (Drilldown)

//为 AAOptions 添加 drilldown 属性
AAPropStatementAndPropSetFuncStatement(strong, AAOptions, AADrilldown *, drilldown)

@end

NS_ASSUME_NONNULL_END
