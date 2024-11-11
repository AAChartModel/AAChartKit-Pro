//
//  AABoostChartVC.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/11.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AABoostChartVC.h"
#import "AABoostOptions.h"
#import "AABoostChartComposer.h"

static NSString * const kBoostPath = @"https://code.highcharts.com/modules/boost.js";

@interface AABoostChartVC ()

@end

@implementation AABoostChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"AABoost" ofType:@"js"];
    self.aaChartView.pluginsArray = @[jsPath];
    
//    AAOptions *aaOptions = [self configureChartOptions];
//    NSDictionary *jsonDic = [AABoostChartComposer lineChartOptions];
    AAOptions *aaOptions = [self chartConfigurationWithSelectedIndex:self.selectedIndex];
    //⚠️ 这里打断点虽然看不到 boost 属性, 但是转换成 json 之后就能看到了
    //PS: 为什么看不到? 因为 boost 是一个动态属性, 通过 runtime 关联对象添加的
    //如果在控制台打印 aaOptions  JSON 看不到 boost 属性, 在控制台搜索 boost 关键字也搜索不到, 其实只是因为数据太长, 控制台没有完全展示而已
    [self.aaChartView aa_drawChartWithOptions:aaOptions];
}

- (id)chartConfigurationWithSelectedIndex:(NSUInteger)selectedIndex {
    switch (self.selectedIndex) {
//            + (NSDictionary *)lineChart;
//            + (NSDictionary *)areaChart;
//            + (NSDictionary *)columnChart;
//            + (NSDictionary *)lineChartWithHundredsOfSeries;
//            + (NSDictionary *)scatterChartOptions;
//            + (NSDictionary *)areaRangeChart;
//            + (NSDictionary *)columnRangeChart;
//            + (NSDictionary *)bubbleChart;
//            + (NSDictionary *)heatmapChart
//            + (NSDictionary *)stackingAreaChart;
//            + (NSDictionary *)stackingColumnChart;


        case 0: return [AABoostChartComposer lineChart];
        case 1: return [AABoostChartComposer areaChart];
        case 2: return [AABoostChartComposer columnChart];
        case 3: return [AABoostChartComposer lineChartWithHundredsOfSeries];
        case 4: return [AABoostChartComposer scatterChartOptions];
        case 5: return [AABoostChartComposer areaRangeChart];
        case 6: return [AABoostChartComposer columnRangeChart];
        case 7: return [AABoostChartComposer bubbleChart];
        case 8: return [AABoostChartComposer heatMapChart];
        case 9: return [AABoostChartComposer stackingAreaChart];
        case 10: return [AABoostChartComposer stackingColumnChart];


    }
    return nil;
}

    



@end
