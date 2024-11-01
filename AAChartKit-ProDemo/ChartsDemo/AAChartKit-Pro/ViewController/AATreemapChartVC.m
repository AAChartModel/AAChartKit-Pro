//
//  AATreemapChartVC.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/1.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AATreemapChartVC.h"
#import "AATreemapChartComposer.h"

@implementation AATreemapChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (id)chartConfigurationWithSelectedIndex:(NSUInteger)selectedIndex {
    switch (selectedIndex) {
        case 0: return [AATreemapChartComposer treemapWithColorAxisData];
        case 1: return [AATreemapChartComposer treemapWithLevelsData];
        case 2: return [AATreemapChartComposer treemapWithLevelsData2];
        case 3: return [AATreemapChartComposer drilldownLargeDataTreemapChart];

        default: return nil;
    }
}


@end
