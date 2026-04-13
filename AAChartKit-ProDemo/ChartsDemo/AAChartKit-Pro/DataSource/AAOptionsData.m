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

+ (NSArray *)vennData2 {
    return [self getJsonDataWithJsonFileName:@"vennData2"];
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

+ (NSArray *)treemapWithLevels2Data {
    return [self getJsonDataWithJsonFileName:@"treemapWithLevels2Data"];
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

+ (NSArray *)eulerData2 {
    return [self getJsonDataWithJsonFileName:@"eulerData2"];
}

+ (NSArray *)organizationData {
    return [self getJsonDataWithJsonFileName:@"organizationData"];
}

+ (NSArray *)organizationNodesData {
    return [self getJsonDataWithJsonFileName:@"organizationNodesData"];
}

+ (NSArray *)carnivoraPhylogenyNodesData {
    return [self getJsonDataWithJsonFileName:@"carnivoraPhylogenyNodesData"];
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

+ (NSArray *)marathonData {
    return [self getJsonDataWithJsonFileName:@"marathonData"];
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



+ (NSArray *)volinPlotElement1Data {
    return [self getJsonDataWithJsonFileName:@"volinPlotElement1Data"];
}

+ (NSArray *)volinPlotElement2Data {
    return [self getJsonDataWithJsonFileName:@"volinPlotElement2Data"];
}

+ (NSArray *)simpleDependencyWheelData {
    return [self getJsonDataWithJsonFileName:@"simpleDependencyWheelData"];
}

//    public class var simpleTilemapData : [Any] {
//        getJsonDataWithJsonFileName("simpleTilemapData")
//    }
//
//    public class var tilemapForAfricaData : [Any] {
//        getJsonDataWithJsonFileName("tilemapForAfricaData")
//    }

+ (NSArray *)simpleTilemapData {
    return [self getJsonDataWithJsonFileName:@"simpleTilemapData"];
}

+ (NSArray *)tilemapForAfricaData {
    return [self getJsonDataWithJsonFileName:@"tilemapForAfricaData"];
}

+ (NSArray *)treegraphData {
    return [self getJsonDataWithJsonFileName:@"treegraphData"];
}

+ (NSArray *)evolutionDendrogramData {
    NSArray *rawData = [self getJsonDataWithJsonFileName:@"evolutionDendrogram"];
    NSMutableArray *sanitizedData = [NSMutableArray arrayWithCapacity:rawData.count];
    
    for (NSArray *row in rawData) {
        NSMutableArray *mutableRow = [row mutableCopy];
        if (mutableRow.count > 5 && [mutableRow[5] isKindOfClass:[NSString class]]) {
            NSString *iconSVG = mutableRow[5];
            // AAChartView passes options JSON through a JS string literal in demo builds.
            // Encode quotes in the inline SVG so this sample survives that bridge unchanged.
            iconSVG = [iconSVG stringByReplacingOccurrencesOfString:@"\\"
                                                         withString:@"\\u005C"];
            iconSVG = [iconSVG stringByReplacingOccurrencesOfString:@"\""
                                                         withString:@"\\u0022"];
            mutableRow[5] = iconSVG;
        }
        [sanitizedData addObject:[mutableRow copy]];
    }
    
    return [sanitizedData copy];
}

+ (NSArray *)germanicLanguageTreeData {
    return [self getJsonDataWithJsonFileName:@"germanicLanguageTreeData"];
}

+ (NSArray *)calendarHeatmapData {
    NSArray *originalDataArr = [self getJsonDataWithJsonFileName:@"calendarHeatmapData"];
    NSArray *chartData = generateChartData(originalDataArr);
    return chartData;
}


// 该函数接收一个数据集并计算在绘制数据集前后需要多少个空白格子
NSArray* generateChartData(NSArray *data) {
    NSArray *weekdays = @[@"Sun", @"Mon", @"Tue", @"Wed", @"Thu", @"Fri", @"Sat"];

    // 计算起始工作日索引（给定数组中第一个日期的 0-6）
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    NSDate *firstDate = [dateFormatter dateFromString:data[0][@"date"]];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger firstWeekday = [calendar component:NSCalendarUnitWeekday fromDate:firstDate] - 1;
    
    NSInteger monthLength = [data count];
    NSString *lastElement = data[monthLength - 1][@"date"];
    NSDate *lastDate = [dateFormatter dateFromString:lastElement];
    NSInteger lastWeekday = [calendar component:NSCalendarUnitWeekday fromDate:lastDate] - 1;
    
    NSInteger lengthOfWeek = 6;
    NSInteger emptyTilesFirst = firstWeekday;
    NSMutableArray *chartData = [NSMutableArray array];
    
    // 在月份的第一天之前添加带有空值的空白格子，以在图表中占据空间
    for (NSInteger emptyDay = 0; emptyDay < emptyTilesFirst; emptyDay++) {
        [chartData addObject:@{
            @"x": @(emptyDay),
            @"y": @5,
            @"value": [NSNull null],
            @"date": [NSNull null],
            @"custom": @{@"empty": @YES}
        }];
    }
    
    // 遍历数据集并填充温度和日期
    for (NSInteger day = 1; day <= monthLength; day++) {
        // 从给定的数据数组中获取日期
        NSString *date = data[day - 1][@"date"];
        
        // 偏移空白格子的数量
        NSInteger xCoordinate = (emptyTilesFirst + day - 1) % 7;
        NSInteger yCoordinate = floor((firstWeekday + day - 1) / 7.0);
        NSInteger id = day;
        
        // 从给定数组中获取当前日期对应的温度
        NSNumber *temperature = data[day - 1][@"temperature"];
        
        [chartData addObject:@{
            @"x": @(xCoordinate),
            @"y": @(5 - yCoordinate),
            @"value": temperature,
            @"date": @([[dateFormatter dateFromString:date] timeIntervalSince1970] * 1000),
            @"custom": @{@"monthDay": @(id)}
        }];
    }
    
    // 在数据集遍历完后填充缺失的值
    NSInteger emptyTilesLast = lengthOfWeek - lastWeekday;
    for (NSInteger emptyDay = 1; emptyDay <= emptyTilesLast; emptyDay++) {
        [chartData addObject:@{
            @"x": @((lastWeekday + emptyDay) % 7),
            @"y": @0,
            @"value": [NSNull null],
            @"date": [NSNull null],
            @"custom": @{@"empty": @YES}
        }];
    }
    
    return chartData;
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
