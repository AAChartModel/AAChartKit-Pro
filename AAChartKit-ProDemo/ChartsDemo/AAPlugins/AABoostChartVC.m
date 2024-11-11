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
    NSDictionary *jsonDic = [self chartConfigurationWithSelectedIndex:self.selectedIndex];
    [self.aaChartView aa_drawChartWithOptions:jsonDic];
}

- (id)chartConfigurationWithSelectedIndex:(NSUInteger)selectedIndex {
    switch (self.selectedIndex) {
//            + (NSDictionary *)lineChart;
//            + (NSDictionary *)areaChart;
//            + (NSDictionary *)columnChart;
//            + (NSDictionary *)lineChartWithHundredsOfSeries;
//            + (NSDictionary *)scatterChartOptions;
        case 0: return [AABoostChartComposer lineChart];
        case 1: return [AABoostChartComposer areaChart];
        case 2: return [AABoostChartComposer columnChart];
        case 3: return [AABoostChartComposer lineChartWithHundredsOfSeries];
        case 4: return [AABoostChartComposer scatterChartOptions];


    }
    return nil;
}

    



@end
