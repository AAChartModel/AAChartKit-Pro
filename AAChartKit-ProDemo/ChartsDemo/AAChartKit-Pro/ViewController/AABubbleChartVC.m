//
//  AABubbleChartVC.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import "AABubbleChartVC.h"
#import "AABubbleChartComposer.h"
#import "AABubbleStellarChartComposer.h"

@implementation AABubbleChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (id)chartConfigurationWithSelectedIndex:(NSUInteger)selectedIndex {
    switch (self.selectedIndex) {
        case  0: return [AABubbleChartComposer packedbubbleChart];
        case  1: return [AABubbleChartComposer packedbubbleSplitChart];
        case  2: return [AABubbleChartComposer packedbubbleSpiralChart];
        case  3: return [AABubbleChartComposer eulerChart];
        case  4: return [AABubbleChartComposer vennChart];
        case  5: return [AABubbleChartComposer vennChart2];
        case  6: return [AABubbleChartComposer eulerChart2];
        case  7: return [AABubbleStellarChartComposer bubbleStellarChart];
    }
    return nil;
}

@end
