//
//  AABubble.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/11.
//  Copyright © 2024 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AABubble : NSObject

////        .minSizeSet(@1)
//        .maxSizeSet(@10)

AAPropStatementAndPropSetFuncStatement(strong, AABubble, NSNumber *, minSize)
AAPropStatementAndPropSetFuncStatement(strong, AABubble, NSNumber *, maxSize)

@end

NS_ASSUME_NONNULL_END
