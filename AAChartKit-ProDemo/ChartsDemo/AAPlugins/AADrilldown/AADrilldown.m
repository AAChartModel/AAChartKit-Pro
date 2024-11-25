//
//  AADrilldown.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/15.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AADrilldown.h"

/**
 @interface AADrilldown : NSObject

 AAPropStatementAndPropSetFuncStatement(strong, AADrilldown, AABreadcrumbs *, breadcrumbs)
 AAPropStatementAndPropSetFuncStatement(strong, AADrilldown, NSArray *, series)

 @end


 @interface AABreadcrumbs : NSObject

 AAPropStatementAndPropSetFuncStatement(strong, AABreadcrumbs, NSDictionary *, position)

 @end
 */

@implementation AADrilldown

AAPropSetFuncImplementation(AADrilldown, AABreadcrumbs *, breadcrumbs)
AAPropSetFuncImplementation(AADrilldown, NSArray *, series)

@end


@implementation AABreadcrumbs

AAPropSetFuncImplementation(AABreadcrumbs, AAPosition *, position)

@end

/**
 @interface AADrilldownDataElement : NSObject

 AAPropStatementAndPropSetFuncStatement(copy,   AADrilldownDataElement, NSString *, name)
 AAPropStatementAndPropSetFuncStatement(strong, AADrilldownDataElement, NSNumber *, y)
 AAPropStatementAndPropSetFuncStatement(copy,   AADrilldownDataElement, NSString *, drilldown)

 @end
 */

@implementation AADrilldownDataElement

AAPropSetFuncImplementation(AADrilldownDataElement, NSString *, name)
AAPropSetFuncImplementation(AADrilldownDataElement, NSNumber *, y)
AAPropSetFuncImplementation(AADrilldownDataElement, NSString *, drilldown)

@end
