//
//  AAColumnVariantChartVC.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import "AAColumnVariantChartVC.h"
#import "AAColumnVariantChartComposer.h"

@implementation AAColumnVariantChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (id)chartConfigurationWithSelectedIndex:(NSUInteger)selectedIndex {
    switch (self.selectedIndex) {
        case  0: return [AAColumnVariantChartComposer variwideChart];
        case  1: return [AAColumnVariantChartComposer columnpyramidChart];
        case  2: return [AAColumnVariantChartComposer dumbbellChart];
        case  3: return [AAColumnVariantChartComposer lollipopChart];
        case  4: return [AAColumnVariantChartComposer xrangeChart];
        case  5: return [AAColumnVariantChartComposer histogramChart];
        case  6: return [AAColumnVariantChartComposer bellcurveChart];
        case  7: return [AAColumnVariantChartComposer bulletChart];

            
    }
    return nil;
}

@end
