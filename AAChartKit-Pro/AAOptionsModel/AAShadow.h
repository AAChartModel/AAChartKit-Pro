//
//  AAShadow.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2020/7/16.
//  Copyright © 2020 Danny boy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAShadow : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AAShadow, NSString *, color)
AAPropStatementAndPropSetFuncStatement(strong, AAShadow, NSNumber *, offsetX)
AAPropStatementAndPropSetFuncStatement(strong, AAShadow, NSNumber *, offsetY)
AAPropStatementAndPropSetFuncStatement(strong, AAShadow, NSNumber *, opacity)
AAPropStatementAndPropSetFuncStatement(strong, AAShadow, NSNumber *, width)

@end

NS_ASSUME_NONNULL_END
