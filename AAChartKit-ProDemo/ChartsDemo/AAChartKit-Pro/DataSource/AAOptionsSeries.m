//
//  AAOptionsSeries.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2020/6/7.
//  Copyright © 2020 An An. All rights reserved.
//

#import "AAOptionsSeries.h"

@implementation AAOptionsSeries

+ (NSArray *)pictorial1Series {
    return [self getJsonDataWithJsonFileName:@"pictorial1Series"];
}

+ (NSArray *)pictorial2Series {
    return [self getJsonDataWithJsonFileName:@"pictorial2Series"];
}

+ (NSArray *)packedbubbleSeries {
    return [self getJsonDataWithJsonFileName:@"packedbubbleSeries"];
}

+ (NSArray *)streamgraphSeries {
    return [self getJsonDataWithJsonFileName:@"streamgraphSeries"];
}

+ (NSArray *)sankeyDiagramSeries {
    return [self getJsonDataWithJsonFileName:@"sankeyDiagramSeries"];
}

+ (id)getJsonDataWithJsonFileName:(NSString *)jsonFileName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:jsonFileName ofType:@"json"];
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    id jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    if (!jsonData || error) {
        NSLog(@"失败❌❌❌ 📃JSON文件%@解码失败",jsonFileName);
        return nil;
    } else {
        NSLog(@"成功🔥🔥🔥 📃JSON文件%@解码成功",jsonFileName);
        return jsonObj;
    }
}


@end
