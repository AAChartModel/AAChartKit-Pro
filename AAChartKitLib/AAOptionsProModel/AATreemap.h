//
//  AATreemap.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2020/6/11.
//  Copyright © 2020 Danny boy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AATreemap : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AATreemap, NSString *, layoutAlgorithm)
AAPropStatementAndPropSetFuncStatement(assign, AATreemap, BOOL , allowTraversingTree)

@end

NS_ASSUME_NONNULL_END
