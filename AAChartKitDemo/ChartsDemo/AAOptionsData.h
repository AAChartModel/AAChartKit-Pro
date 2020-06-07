//
//  AAOptionsData.h
//  AAChartKitDemo
//
//  Created by AnAn on 2020/6/6.
//  Copyright © 2020 Danny boy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAOptionsData : NSObject

+ (NSArray *)sankeyChartData;
+ (NSArray *)sunburstChartData;
+ (NSArray *)dumbbellChartData;
+ (NSArray *)vennChartData;
+ (NSArray *)lollipopChartData;

@end

NS_ASSUME_NONNULL_END
