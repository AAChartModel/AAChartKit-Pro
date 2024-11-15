//
//  AASeries+Depth.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/15.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AASeries.h"

NS_ASSUME_NONNULL_BEGIN

/**  .seriesSet(AASeries.new
 //                               .groupZPaddingSet(@10)
 //                               .depthSet(@100)
                                .groupPaddingSet(@0)
 //                               .groupingSet(false)
                                )*/
@interface AASeries (Depth)

//为 AASeries 对象设置 groupZPadding 属性
AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber *, groupZPadding)
//为 AASeries 对象设置 depth 属性
AAPropStatementAndPropSetFuncStatement(strong, AASeries, NSNumber *, depth)
//为 AASeries 对象设置 grouping 属性
AAPropStatementAndPropSetFuncStatement(assign, AASeries, BOOL, grouping)

@end

NS_ASSUME_NONNULL_END
