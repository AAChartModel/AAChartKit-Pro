//
//  AARelationshipChartVC.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import "AARelationshipChartVC.h"
#import "AARelationshipChartComposer.h"
#import "AAOrganizationComposer.h"
#import "AASankeyComposer.h"

@implementation AARelationshipChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (id)chartConfigurationWithSelectedIndex:(NSUInteger)selectedIndex {
    switch (self.selectedIndex) {
        case  0: return [AARelationshipChartComposer sankeyChart];
        case  1: return [AARelationshipChartComposer dependencywheelChart];
        case  2: return [AARelationshipChartComposer arcdiagramChart1];
        case  3: return [AARelationshipChartComposer arcdiagramChart2];
        case  4: return [AARelationshipChartComposer arcdiagramChart3];
        case  5: return [AARelationshipChartComposer organizationChart];
        case  6: return [AARelationshipChartComposer networkgraphChart];
        case  7: return [AARelationshipChartComposer simpleDependencyWheelChart];
        case  8: return [AARelationshipChartComposer neuralNetworkChart];
        case  9: return [AARelationshipChartComposer carnivoraPhylogenyOrganizationChart];
        case 10: return [AAOrganizationComposer germanicLanguageTreeChart];
        case 11: return [AASankeyComposer sankeyDiagramChart];
        case 12: return [AASankeyComposer verticalSankeyChart];


    }
    return nil;
}

@end
