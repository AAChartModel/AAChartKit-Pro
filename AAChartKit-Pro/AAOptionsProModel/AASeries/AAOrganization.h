//
//  AAOrganization.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/1.
//  Copyright © 2024 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAOrganization : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AAOrganization, NSString *, hangingIndentTranslation)
AAPropStatementAndPropSetFuncStatement(strong, AAOrganization, NSNumber *, hangingIndent)

@end

NS_ASSUME_NONNULL_END
