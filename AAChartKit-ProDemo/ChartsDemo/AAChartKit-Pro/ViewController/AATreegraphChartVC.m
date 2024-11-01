//
//  AATreegraphChartVC.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/1.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AATreegraphChartVC.h"
#import "AATreegraphChartComposer.h"

@implementation AATreegraphChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (id)chartConfigurationWithSelectedIndex:(NSUInteger)selectedIndex {
    switch (selectedIndex) {
        case 0: return [AATreegraphChartComposer treegraph];
        case 1: return [AATreegraphChartComposer invertedTreegraph];
        case 2: return [AATreegraphChartComposer treegraphWithBoxLayout];

        default: return nil;
    }
}


@end
