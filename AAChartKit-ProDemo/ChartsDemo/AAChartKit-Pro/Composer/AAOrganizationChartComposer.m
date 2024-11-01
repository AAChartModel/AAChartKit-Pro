//
//  AAOrganizationChartComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/1.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AAOrganizationChartComposer.h"
#import "AAChartKit-Pro.h"
#import "AAOptionsData.h"

@implementation AAOrganizationChartComposer

/**
 const colors = Highcharts.getOptions().colors;

 const leafs = [
     'Bastarnisch', 'Brabantian', 'Burgundian', 'Crimean Gothic', 'Danish',
     'Dutch', 'English', 'Faroese', 'Flemish', 'Frisian', 'Gepidisch', 'Gothic',
     'Herulisch', '(High) German', 'Hollandic', 'Icelandic', 'Limburgish',
     'Low German', 'Norwegian', 'Rhinelandic', 'Rugisch', 'Skirisch', 'Swedish',
     'Vandalic', 'Yiddish'
 ].map(function (leaf) {
     return {
         id: leaf,
         color: colors[0]
     };
 });

 // Choose hanging nodes:
 const hangingNodes = [
     {
         id: 'North Germanic',
         layout: 'hanging',
         // Push node a bit to the left.
         offsetHorizontal: -15
     },
     {
         id: 'West Germanic',
         layout: 'hanging'
     },
     {
         id: 'East Germanic',
         layout: 'hanging'
     }
 ];

 const nodes = hangingNodes.concat(leafs);

 Highcharts.chart('container', {

     chart: {
         height: 1200,
         inverted: true
     },

     title: {
         text: 'The Germanic Language Tree'
     },

     accessibility: {
         point: {
             descriptionFormat: '{add index 1}. {toNode.id}' +
                 'comes from {fromNode.id}'
         }
     },

     tooltip: {
         outside: true
     },

     series: [{
         name: 'Germanic language tree',
         type: 'organization',
         keys: ['from', 'to'],
         nodeWidth: 40,
         nodePadding: 20,
         colorByPoint: false,
         hangingIndentTranslation: 'cumulative',
         // Crimp a bit to avoid nodes overlapping lines
         hangingIndent: 10,

         levels: [{
             level: 0,
             color: '#dedede'
         }, {
             level: 1,
             color: '#dedede'
         }, {
             level: 2,
             color: colors[3]
         }, {
             level: 3,
             color: colors[2]
         }, {
             level: 4,
             color: colors[8]
         }],
         nodes,
     }]
 });
 */

+ (AAOptions *)germanicLanguageTreeChart {
    NSArray *colors = @[@"#1e90ff", @"#ef476f", @"#ffd066", @"#04d69f", @"#25547c"];
    
    return AAOptions.new
        .chartSet(AAChart.new
                  //                  .heightSet(@1200)
                  .invertedSet(true))
        .titleSet(AATitle.new
                  .textSet(@"The Germanic Language Tree"))
    //    .accessibilitySet(Accessibility.new
    //                        .pointSet(AccessibilityPoint.new
    //                                    .descriptionFormatSet(@"{add index 1}. {toNode.id} comes from {fromNode.id}")))
        .tooltipSet(AATooltip.new
                    .outsideSet(@true))
    
        .plotOptionsSet(AAPlotOptions.new
                        .organizationSet(AAOrganization.new
                                         .hangingIndentTranslationSet(@"cumulative")
                                         //Crimp a bit to avoid nodes overlapping lines
                                         .hangingIndentSet(@10)))
    
        .seriesSet(@[
            AASeriesElement.new
                .nameSet(@"Germanic language tree")
                .typeSet(AAChartTypeOrganization)
                .keysSet(@[@"from", @"to"])
                .nodeWidthSet(@40)
                .nodePaddingSet(@20)
                .colorByPointSet(@false)
            //                .hangingIndentTranslationSet(@"cumulative")
            // Crimp a bit to avoid nodes overlapping lines
            //                .hangingIndentSet(@10)
                .levelsSet(@[
                    AALevelsElement.new
                        .levelSet(@0)
                        .colorSet(@"#dedede"),
                    AALevelsElement.new
                        .levelSet(@1)
                        .colorSet(@"#dedede"),
                    AALevelsElement.new
                        .levelSet(@2)
                        .colorSet(colors[3]),
                    AALevelsElement.new
                        .levelSet(@3)
                        .colorSet(colors[2]),
                    AALevelsElement.new
                        .levelSet(@4)
                        .colorSet(colors[4])
                ])
                .nodesSet(({
                    NSArray *originalLeafsArr = @[
                        @"Bastarnisch", @"Brabantian", @"Burgundian", @"Crimean Gothic", @"Danish",
                        @"Dutch", @"English", @"Faroese", @"Flemish", @"Frisian", @"Gepidisch", @"Gothic",
                        @"Herulisch", @"(High) German", @"Hollandic", @"Icelandic", @"Limburgish",
                        @"Low German", @"Norwegian", @"Rhinelandic", @"Rugisch", @"Skirisch", @"Swedish",
                        @"Vandalic", @"Yiddish"
                    ];
                    
                    NSMutableArray *leafs = [NSMutableArray array];
                    for (NSString *leaf in originalLeafsArr) {
                        NSDictionary *leafDict = @{@"id":leaf, @"color":colors[0]};
                        [leafs addObject:leafDict];
                    }
                    
                    NSArray *hangingNodes = @[
                        @{
                            @"id":@"North Germanic",
                            @"layout":@"hanging",
                            @"offsetHorizontal":@(-15)},
                        @{
                            @"id":@"West Germanic",
                            @"layout":@"hanging"},
                        @{
                            @"id":@"East Germanic",
                            @"layout":@"hanging"}
                    ];
                    
                    NSArray *nodes = [hangingNodes arrayByAddingObjectsFromArray:leafs];
                    nodes;
                }))
                .dataSet(AAOptionsData.germanicLanguageTreeData)
        ]);
}

@end
