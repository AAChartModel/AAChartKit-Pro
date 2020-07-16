//
//  AAOptionsSeries.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2020/6/7.
//  Copyright © 2020 Danny boy. All rights reserved.
//

#import "AAOptionsSeries.h"

@implementation AAOptionsSeries

+ (NSArray *)packedbubbleSeries {
    return [self getJsonDataWithJsonFileName:@"packedbubbleSeries"];
}

+ (NSArray *)streamgraphSeries {
 return [self getJsonDataWithJsonFileName:@"streamgraphSeries"];
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
