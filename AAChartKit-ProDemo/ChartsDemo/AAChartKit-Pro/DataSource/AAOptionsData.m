//
//  AAOptionsData.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2020/6/6.
//  Copyright © 2020 An An. All rights reserved.
//

#import "AAOptionsData.h"

@implementation AAOptionsData

+ (NSArray *)variablepieData {
    return [self getJsonDataWithJsonFileName:@"variablepieData"];
}

+ (NSArray *)variwideData {
    return [self getJsonDataWithJsonFileName:@"variwideData"];
}

+ (NSArray *)heatmapData {
    return [self getJsonDataWithJsonFileName:@"heatmapData"];
}

+ (NSArray *)columnpyramidData {
    return [self getJsonDataWithJsonFileName:@"columnpyramidData"];
}

+ (NSArray *)treemapWithColorAxisData {
    return [self getJsonDataWithJsonFileName:@"treemapWithColorAxisData"];
}

+ (NSArray *)drilldownTreemapData {
    return [self getJsonDataWithJsonFileName:@"drilldownTreemapData"];
}




+ (NSArray *)sankeyData {
    return [self getJsonDataWithJsonFileName:@"sankeyData"];
}

+ (NSArray *)dependencywheelData {
    return [self getJsonDataWithJsonFileName:@"dependencywheelData"];
}

+ (NSArray *)sunburstData {
    return [self getJsonDataWithJsonFileName:@"sunburstData"];
}

+ (NSArray *)dumbbellData {
    return [self getJsonDataWithJsonFileName:@"dumbbellData"];
}

+ (NSArray *)vennData {
    return [self getJsonDataWithJsonFileName:@"vennData"];
}

+ (NSArray *)lollipopData {
    return [self getJsonDataWithJsonFileName:@"lollipopData"];
}

+ (NSArray *)tilemapData {
    return [self getJsonDataWithJsonFileName:@"tilemapData"];
}

+ (NSArray *)treemapWithLevelsData {
    return [self getJsonDataWithJsonFileName:@"treemapWithLevelsData"];
}

+ (NSArray *)bellcurveData {
    return [self getJsonDataWithJsonFileName:@"bellcurveData"];
}

+ (NSArray *)timelineData {
    return [self getJsonDataWithJsonFileName:@"timelineData"];
}

+ (NSArray *)itemData {
    return [self getJsonDataWithJsonFileName:@"itemData"];
}

+ (NSArray *)windbarbData {
    return [self getJsonDataWithJsonFileName:@"windbarbData"];
}

+ (NSArray *)networkgraphData {
    return [self getJsonDataWithJsonFileName:@"networkgraphData"];
}

+ (NSArray *)wordcloudData {
    return [self getJsonDataWithJsonFileName:@"wordcloudData"];
}

+ (NSArray *)eulerData {
    return [self getJsonDataWithJsonFileName:@"eulerData"];
}



+ (NSArray *)organizationData {
    return [self getJsonDataWithJsonFileName:@"organizationData"];
}

+ (NSArray *)organizationNodesData {
    return [self getJsonDataWithJsonFileName:@"organizationNodesData"];
}



+ (NSArray *)arcdiagram1Data {
    return [self getJsonDataWithJsonFileName:@"arcdiagram1Data"];
}

+ (NSArray *)arcdiagram2Data {
    return [self getJsonDataWithJsonFileName:@"arcdiagram2Data"];
}

+ (NSArray *)arcdiagram3Data {
    return [self getJsonDataWithJsonFileName:@"arcdiagram3Data"];
}



+ (NSArray *)flameData {
    return [self getJsonDataWithJsonFileName:@"flameData"];
}

+ (NSArray *)sunburst2Data {
    return [self getJsonDataWithJsonFileName:@"sunburst2Data"];
}


+ (NSArray *)xrangeData {
    NSMutableArray *dataArr = [NSMutableArray array];
    
    for (int y = 0; y < 20; y++) {
      NSArray *data =  [self getSingleGroupCategoryDataElementArrayWithY:y];
        for (NSDictionary *dataElement in data) {
            [dataArr addObject:dataElement];
        }
    }
    
    return dataArr;
}

+ (NSArray *)vectorData {
    return [self getJsonDataWithJsonFileName:@"vectorData"];
}







+ (NSArray *)getSingleGroupCategoryDataElementArrayWithY:(int )y {
    NSMutableArray *dataArr = [NSMutableArray array];
    
    int x = 0;
    int x2 = x + arc4random() % 10;
    for (int i = 0; i < 50; i++) {
        NSMutableDictionary *dataElementDic = [NSMutableDictionary dictionary];
        dataElementDic[@"x"] = @(x);
        dataElementDic[@"x2"] = @(x2);
        dataElementDic[@"y"] = @(y);
        [dataArr addObject:dataElementDic];
        
        x = x2 + arc4random() % 1000;
        x2 = x + arc4random() % 2000;
    }
    return dataArr;
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
