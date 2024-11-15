//
//  AADrilldown.h
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/15.
//  Copyright © 2024 An An. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AABreadcrumbs;

NS_ASSUME_NONNULL_BEGIN

/**
 drilldown: {
       breadcrumbs: {
           position: {
               align: 'right'
           }
       },
       series: [
           {
               name: 'Chrome',
               id: 'Chrome',
               data: [
 */
@interface AADrilldown : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AADrilldown, AABreadcrumbs *, breadcrumbs)
AAPropStatementAndPropSetFuncStatement(strong, AADrilldown, NSArray *, series)

@end


@interface AABreadcrumbs : NSObject

AAPropStatementAndPropSetFuncStatement(strong, AABreadcrumbs, NSDictionary *, position)

@end


/**
 data: [
                {
                    name: 'Chrome',
                    y: 63.06,
                    drilldown: 'Chrome'
                },
                {
                    name: 'Safari',
                    y: 19.84,
                    drilldown: 'Safari'
                },
 */
@interface AADrilldownDataElement : NSObject

AAPropStatementAndPropSetFuncStatement(copy,   AADrilldownDataElement, NSString *, name)
AAPropStatementAndPropSetFuncStatement(strong, AADrilldownDataElement, NSNumber *, y)
AAPropStatementAndPropSetFuncStatement(copy,   AADrilldownDataElement, NSString *, drilldown)

@end



NS_ASSUME_NONNULL_END
