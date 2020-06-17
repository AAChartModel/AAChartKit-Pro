//
//  AALayoutAlgorithm.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2020/6/10.
//  Copyright © 2020 Danny boy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AALayoutAlgorithm : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AALayoutAlgorithm, NSNumber *, gravitationalConstant)
AAPropStatementAndPropSetFuncStatement(strong, AALayoutAlgorithm, id      , splitSeries)
AAPropStatementAndPropSetFuncStatement(strong, AALayoutAlgorithm, id      , seriesInteraction)
AAPropStatementAndPropSetFuncStatement(strong, AALayoutAlgorithm, id      , dragBetweenSeries)
AAPropStatementAndPropSetFuncStatement(strong, AALayoutAlgorithm, id      , parentNodeLimit)

@end

NS_ASSUME_NONNULL_END
