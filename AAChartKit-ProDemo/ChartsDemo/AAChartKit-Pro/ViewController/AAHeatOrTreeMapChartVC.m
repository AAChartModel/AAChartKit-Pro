//
//  AAHeatOrTreeMapChartVC.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import "AAHeatOrTreeMapChartVC.h"
#import "AAHeatOrTreeMapChartComposer.h"

@implementation AAHeatOrTreeMapChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (id)chartConfigurationWithSelectedIndex:(NSUInteger)selectedIndex {
    switch (self.selectedIndex) {
        case  0: return [AAHeatOrTreeMapChartComposer heatmapChart];
        case  1: return [AAHeatOrTreeMapChartComposer tilemapChart];
        case  2: return [AAHeatOrTreeMapChartComposer treemapWithColorAxisData];
        case  3: return [AAHeatOrTreeMapChartComposer treemapWithLevelsData];
        case  4: return [AAHeatOrTreeMapChartComposer drilldownLargeDataTreemapChart];
        case  5: return [AAHeatOrTreeMapChartComposer largeDataHeatmapChart];

    }
    return nil;
}


@end
