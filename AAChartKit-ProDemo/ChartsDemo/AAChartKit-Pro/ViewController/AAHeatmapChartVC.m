//
//  AAHeatmapChartVC.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/1.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AAHeatmapChartVC.h"
#import "AAHeatmapChartComposer.h"

@implementation AAHeatmapChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (id)chartConfigurationWithSelectedIndex:(NSUInteger)selectedIndex {
    switch (selectedIndex) {
        case 0: return [AAHeatmapChartComposer heatmapChart];
        case 1: return [AAHeatmapChartComposer largeDataHeatmapChart];
        case 2: return [AAHeatmapChartComposer calendarHeatmap];

        default: return nil;
    }
}


@end
