//
//  AARelationshipChartComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2022/8/8.
//  Copyright © 2022 An An. All rights reserved.
//

#import "AARelationshipChartComposer.h"
#import "AAChartKit-Pro.h"
#import "AAOptionsData.h"

@implementation AARelationshipChartComposer

+ (AAOptions *)sankeyChart {
    return AAOptions.new
    .titleSet(AATitle.new
              .textSet(@"AAChartKit-Pro 桑基图"))
    .colorsSet(@[
        AARgbaColor(137, 78, 36, 1.0),
        AARgbaColor(220, 36, 30, 1.0),
        AARgbaColor(255, 206, 0, 1.0),
        AARgbaColor(1, 114, 41, 1.0),
        AARgbaColor(0, 175, 173, 1.0),
        AARgbaColor(215, 153, 175, 1.0),
        AARgbaColor(106, 114, 120, 1.0),
        AARgbaColor(114, 17, 84, 1.0),
        AARgbaColor(0, 0, 0, 1.0),
        AARgbaColor(0, 24, 168, 1.0),
        AARgbaColor(0, 160, 226, 1.0),
        AARgbaColor(106, 187, 170, 1.0),
               ])
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeSankey)
        .keysSet(@[@"from", @"to", @"weight"])
        .dataSet(AAOptionsData.sankeyData),
               ]);
}

+ (AAOptions *)dependencywheelChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .marginLeftSet(@20)
              .marginRightSet(@20))
    .titleSet(AATitle.new
              .textSet(@"AAChartKit-Pro 和弦图"))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeDependencywheel)
        .nameSet(@"Dependency wheel series")
        .keysSet(@[@"from",@"to",@"weight"])
        .dataSet(AAOptionsData.dependencywheelData)
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(true)
                       .colorSet(@"#333")
                       .textPathSet(AATextPath.new
                                    .enabledSet(true)
                                    .attributesSet(@{ @"dy": @5 }))
                       .distanceSet(@10))
               ]);
}

//https://www.highcharts.com/docs/chart-and-series-types/arc-diagram
+ (AAOptions *)arcdiagramChart1 {
    return AAOptions.new
        .colorsSet(@[@"#293462", @"#a64942", @"#fe5f55", @"#fff1c1", @"#5bd1d7", @"#ff502f", @"#004d61", @"#ff8a5c", @"#fff591", @"#f5587b", @"#fad3cf", @"#a696c8", @"#5BE7C4", @"#266A2E", @"#593E1A"])
        .titleSet(AATitle.new
            .textSet(@"Main train connections in Europe"))
        .seriesSet(@[
            AASeriesElement.new
                .keysSet(@[@"from", @"to", @"weight"])
                .typeSet(AAChartTypeArcdiagram)
                .nameSet(@"Train connections")
                .linkWeightSet(@1)
                .centeredLinksSet(@true)
                .dataLabelsSet(AADataLabels.new
                    .rotationSet(@90)
                    .ySet(@30)
                    .alignSet(AAChartAlignTypeLeft)
                    .colorSet(AAColor.blackColor))
                .offsetSet(@"65%")
                .dataSet(AAOptionsData.arcdiagram1Data)
            ]);
}

+ (AAOptions *)arcdiagramChart2 {
    return AAOptions.new
        .titleSet(AATitle.new
            .textSet(@"Highcharts Arc Diagram"))
        .subtitleSet(AASubtitle.new
            .textSet(@"Arc Diagram with marker symbols"))
        .seriesSet(@[
            AASeriesElement.new
                .linkWeightSet(@1)
                .keysSet(@[@"from", @"to", @"weight", ])
                .typeSet(AAChartTypeArcdiagram)
                .markerSet(AAMarker.new
                    .symbolSet(AAChartSymbolTypeTriangle)
                    .lineWidthSet(@2)
                    .lineColorSet(AAColor.whiteColor))
                .centeredLinksSet(@true)
                .dataLabelsSet(AADataLabels.new
                    .formatSet(@"{point.fromNode.name} → {point.toNode.name}")
                    .nodeFormatSet(@"{point.name}")
                    .colorSet(AAColor.blackColor)
                    .linkTextPathSet(AATextPath.new
                        .enabledSet(true))
            )
                .dataSet(AAOptionsData.arcdiagram2Data)
            ]);
}

+ (AAOptions *)arcdiagramChart3 {
    return AAOptions.new
        .chartSet(AAChart.new
            .invertedSet(true))
        .titleSet(AATitle.new
            .textSet(@"Highcharts Inverted Arc Diagram"))
        .seriesSet(@[
            AASeriesElement.new
                .keysSet(@[@"from", @"to", @"weight", ])
//                .centerPosSet(@"50%")
                .typeSet(AAChartTypeArcdiagram)
                .dataLabelsSet(AADataLabels.new
                    .alignSet(AAChartAlignTypeRight)
                    .xSet(@-20)
                    .ySet(@-2)
                    .colorSet(@"#333333")
                    .overflowSet(@"allow")
                    .paddingSet(@0)
            )
                .offsetSet(@"60%")
                .dataSet(AAOptionsData.arcdiagram3Data)
            ]);
}

+ (AAOptions *)organizationChart {
    return AAOptions.new
        .chartSet(AAChart.new
//            .heightSet(@600)
            .invertedSet(true))
        .titleSet(AATitle.new
            .textSet(@"Highsoft 公司组织结构"))
        .seriesSet(@[
            AASeriesElement.new
                .typeSet(AAChartTypeOrganization)
                .nameSet(@"Highsoft")
                .keysSet(@[@"from", @"to"])
                .dataSet(AAOptionsData.organizationData)
                .levelsSet(@[
                    AALevelsElement.new
                        .levelSet(@0)
                        .colorSet(@"silver")
                        .dataLabelsSet(AADataLabels.new
                            .colorSet(AAColor.blackColor))
                        .heightSet(@25)
                    ,
                    AALevelsElement.new
                        .levelSet(@1)
                        .colorSet(@"silver")
                        .dataLabelsSet(AADataLabels.new
                            .colorSet(AAColor.blackColor))
                        .heightSet(@25)
                    ,
                    AALevelsElement.new
                        .levelSet(@2)
                        .colorSet(@"#980104")
                    ,
                    AALevelsElement.new
                        .levelSet(@4)
                        .colorSet(@"#359154")
                ])
                .nodesSet(AAOptionsData.organizationNodesData)
                .colorByPointSet(false)
                .colorSet(@"#007ad0")
                .dataLabelsSet(AADataLabels.new
                    .colorSet(AAColor.whiteColor))
                .borderColorSet(AAColor.whiteColor)
                .nodeWidthSet(@65)
            ])
        .tooltipSet(AATooltip.new
            .outsideSet(@true));
}

+ (AAOptions *)networkgraphChart {
    return AAOptions.new
    .chartSet(AAChart.new
              .typeSet(AAChartTypeNetworkgraph))
    .titleSet(AATitle.new
              .textSet(@"The Indo-European Laungauge Tree"))
    .subtitleSet(AASubtitle.new
                 .textSet(@"A Force-Directed Network Graph in Highcharts"))
    .seriesSet(@[
        AASeriesElement.new
        .dataLabelsSet(AADataLabels.new
                       .enabledSet(false))
        .dataSet(AAOptionsData.networkgraphData),
               ]);
}

+ (AAOptions *)simpleDependencyWheelChart {
    return AAOptions.new
        .titleSet(AATitle.new
            .textSet(@"2016 BRICS export in million USD"))
        .colorsSet(@[@"#058DC7", @"#8dc705", @"#c73f05", @"#ffc080", @"#dd69ba", ])
        .seriesSet(@[
            AASeriesElement.new
                .keysSet(@[@"from", @"to", @"weight", ])
                .dataSet(AAOptionsData.simpleDependencyWheelData)
                .typeSet(AAChartTypeDependencywheel)
                .nameSet(@"Dependency wheel series")
                .dataLabelsSet(AADataLabels.new
                    .colorSet(@"#333")
                    .textPathSet(AATextPath.new
                        .enabledSet(true)
//                        .attributesSet(AAAttributes.new
//                            .dySet(@5))
            )
//                    .distanceSet(@10)
            )
//                .sizeSet(@"95%")
            ]);
}

/**
 // Define an array of layers, where each layer is an object
 // with the number of nodes and the activation function
 const layers = [{
     nodes: 1,
     activation: 'tanh',
     label: 'Input Layer (#0)'
 }, {
     nodes: 6,
     activation: 'tanh',
     label: 'Hidden Layer #1 (tanh)'
 }, {
     nodes: 6,
     activation: 'ReLU',
     label: 'Hidden Layer #2 (ReLU)'
 }, {
     nodes: 6,
     activation: 'ReLU',
     label: 'Hidden Layer #3 (ReLU)'
 }, {
     nodes: 2,
     activation: 'sigmoid',
     label: 'Output Layer (sigmoid)'
 }];

 // Generates series for a neural network based on the defined layers.
 function generateData() {
     // If there are no layers defined, we have no neural network to visualize
     if (layers.length === 0) {
         return [];
     }

     const data = [];

     // Recursive function to generate all possible connections of nodes
     // for each layer in then network
     function generate(currentIndices) {
         // Base case: If the current indices length matches the number of
         // layers, store the combination in the data array.
         if (currentIndices.length === layers.length) {
             data.push({
                 data: [...currentIndices]
             });
             return;
         }

         // Get the current dimension index based on the length of
         // current indices.
         const dimensionIndex = currentIndices.length;

         // Iterate through all nodes in the current layer (dimensionIndex).
         for (let i = 0; i < layers[dimensionIndex].nodes; i++) {
             // Recursively call generate with the new node index added to
             // the current indices.
             generate([...currentIndices, i]);
         }
     }

     generate([]);
     return data;
 }

 Highcharts.chart('container', {
     chart: {
         type: 'line',
         parallelCoordinates: true,
         inverted: true
     },
     title: {
         text: 'Visualizing a neural network with Highcharts',
         align: 'left'
     },
     subtitle: {
         text: 'You can use the parallel-coordinates module ' +
             'to visualize a neural network.',
         align: 'left'
     },
     accessibility: {
         typeDescription: 'Neural network chart',
         point: {
             descriptionFormat:
                 'node on {series.xAxis.options.custom.layers.(x).label}'
         }
     },
     tooltip: {
         stickOnContact: true,
         format: `<span style="font-weight: bold">
             Activation function:
             </span>
             {series.xAxis.options.custom.layers.(point.x).activation}
             <br>
             <span style="font-weight: bold">
             Number of nodes in the layer:
             </span>
             {series.xAxis.options.custom.layers.(point.x).nodes}`
     },
     plotOptions: {
         line: {
             lineWidth: 0.5,
             color: '#a752d115',
             marker: {
                 symbol: 'circle',
                 enabled: true,
                 radius: 10,
                 fillColor: 'white',
                 lineWidth: 1.5,
                 lineColor: '#7f30a6',
                 states: {
                     hover: {
                         lineColor: '#fa56fc'
                     }
                 }
             },
             states: {
                 inactive: {
                     enabled: false
                 },
                 hover: {
                     lineColor: '#7f30a6',
                     lineWidthPlus: 0
                 }
             }
         }
     },
     xAxis: {
         custom: {
             layers
         },
         categories: layers.map(layer => layer.label),
         accessibility: {
             description: 'Layers of a neural network.'
         }
     },
     yAxis: Array.from({ length: layers.length }, (_, i) => ({
         type: 'category',
         visible: false,
         accessibility: {
             description:
                 `Axis for the nodes contained the layer ${layers[i].label}.`
         }
     })),
     series: generateData(),
     responsive: {
         rules: [{
             condition: {
                 maxWidth: 500
             },
             chartOptions: {
                 xAxis: {
                     categories: layers.map(layer => layer.activation)
                 }
             }
         }]
     }
 });
 */

+ (AAOptions *)neuralNetworkChart {
    //Define an array of layers, where each layer is an object
    //with the number of nodes and the activation function
    NSArray *layers = @[
        @{@"nodes": @1, @"activation": @"tanh", @"label": @"Input Layer (#0)"},
        @{@"nodes": @6, @"activation": @"tanh", @"label": @"Hidden Layer #1 (tanh)"},
        @{@"nodes": @6, @"activation": @"ReLU", @"label": @"Hidden Layer #2 (ReLU)"},
        @{@"nodes": @6, @"activation": @"ReLU", @"label": @"Hidden Layer #3 (ReLU)"},
        @{@"nodes": @2, @"activation": @"sigmoid", @"label": @"Output Layer (sigmoid)"},
    ];
    
    //Generates series for a neural network based on the defined layers.
    NSArray * (^__block generateData) (void) = ^ {
        //If there are no layers defined, we have no neural network to visualize
        if (layers.count == 0) {
            return @[];
        }
        
        NSMutableArray *data = [NSMutableArray array];
        
        //Recursive function to generate all possible connections of nodes
        //for each layer in then network
        void (^__block generate)(NSArray *) = ^(NSArray *currentIndices) {
            //Base case: If the current indices length matches the number of
            //layers, store the combination in the data array.
            if (currentIndices.count == layers.count) {
                [data addObject:@{ @"data": [currentIndices copy] }];
                return;
            }
            
            //Get the current dimension index based on the length of
            //current indices.
            NSInteger dimensionIndex = currentIndices.count;
            
            //Iterate through all nodes in the current layer (dimensionIndex).
            for (NSInteger i = 0; i < [layers[dimensionIndex][@"nodes"] integerValue]; i++) {
                //Recursively call generate with the new node index added to
                //the current indices.
                generate([currentIndices arrayByAddingObject:@(i)]);
            }
            
        };
        
        generate(@[]);
        return (NSArray *)data;
    };
    
    
    return AAOptions.new
        .chartSet(AAChart.new
                  .typeSet(AAChartTypeLine)
                  .parallelCoordinatesSet(@true)
                  .invertedSet(true))
        .titleSet(AATitle.new
                  .textSet(@"Visualizing a neural network with Highcharts")
                  .alignSet(AAChartAlignTypeLeft))
        .subtitleSet(AASubtitle.new
                     .textSet(@"You can use the parallel-coordinates module to visualize a neural network.")
                     .alignSet(AAChartAlignTypeLeft))
    //    .accessibilitySet(AAAccessibility.new
    //                        .typeDescriptionSet(@"Neural network chart")
    //                        .pointSet(AAPoint.new
    //                                    .descriptionFormatSet(@"node on {series.xAxis.options.custom.layers.(x).label}")))
//        .tooltipSet(AATooltip.new
////                    .stickOnContactSet(@true)
//                    .formatSet([self aa_toPureJSString2WithString:
//                                @AAJSFunc(<span style="font-weight: bold">
//                                          Activation function:
//                                          </span>
//                                          {series.xAxis.options.custom.layers.(point.x).activation}
//                                          <br>
//                                          <span style="font-weight: bold">
//                                          Number of nodes in the layer:
//                                          </span>
//                                          {series.xAxis.options.custom.layers.(point.x).nodes})]))
        .plotOptionsSet(AAPlotOptions.new
                        .lineSet(AALine.new
                                 .lineWidthSet(@0.5)
                                 .colorSet(@"#a752d115")
                                 .markerSet(AAMarker.new
                                            .symbolSet(AAChartSymbolTypeCircle)
                                            .enabledSet(true)
                                            .radiusSet(@10)
                                            .fillColorSet(@"white")
                                            .lineWidthSet(@1.5)
                                            .lineColorSet(@"#7f30a6")
                                            .statesSet(AAMarkerStates.new
                                                       .hoverSet(AAMarkerHover.new
                                                                 .lineColorSet(@"#fa56fc"))))
                                 .statesSet(AAStates.new
                                            .inactiveSet(AAInactive.new
                                                         .enabledSet(false))
                                            .hoverSet(AAHover.new
                                                      .lineColorSet(@"#7f30a6")
                                                      .lineWidthPlusSet(@0))))
                        )
        .xAxisSet(AAXAxis.new
                  //                .customSet(@{ @"layers": layers })
                  .categoriesSet([layers valueForKey:@"label"])
                  //                .accessibilitySet(AAAccessibility.new
                  //                                    .descriptionSet(@"Layers of a neural network."))
                  )
        .yAxisSet([layers valueForKeyPath:@"@unionOfObjects.nodes"])
        .seriesSet(generateData())
    ;
    //    .responsiveSet(AAResponsive.new
    //                    .rulesSet(@[
    //                        AAResponsiveRulesElement.new
    //                        .conditionSet(AACondition.new
    //                                        .maxWidthSet(@500))
    //                        .chartOptionsSet(AAChart.new
    //                                            .xAxisSet(AAXAxis.new
    //                                                        .categoriesSet([layers valueForKey:@"activation"]))
    
    
}

//Highcharts.chart('container', {
//    chart: {
//        height: 600,
//        inverted: false
//    },
//
//    title: {
//        text: 'Carnivora Phylogeny'
//    },
//
//    subtitle: {
//        text: 'Tracing the Evolutionary Relationship of Carnivores'
//    },
//
//    plotOptions: {
//        series: {
//            nodeWidth: '22%'
//        }
//    },
//
//    accessibility: {
//        point: {
//            descriptionFormat: '{toNode.name} ' +
//            '{#if (eq toNode.level 1 )} is a distinct family within the ' +
//            'order of {fromNode.id}. {toNode.custom.info}{/if}' +
//            '{#if (eq toNode.level 2 )} is a genus within the {fromNode.id}. ' +
//            '{toNode.custom.info} {/if}' +
//            '{#if (eq toNode.level 3 )} is a species within the ' +
//            '{fromNode.id}. {toNode.custom.info} {/if}'
//        }
//    },
//
//    series: [{
//        type: 'organization',
//        name: 'Carnivora Phyologeny',
//        keys: ['from', 'to'],
//        data: [
//            ['Carnivora', 'Felidae'],
//            ['Carnivora', 'Mustelidae'],
//            ['Carnivora', 'Canidae'],
//            ['Felidae', 'Panthera'],
//            ['Mustelidae', 'Taxidea'],
//            ['Mustelidae', 'Lutra'],
//            ['Panthera', 'Panthera pardus'],
//            ['Taxidea', 'Taxidea taxus'],
//            ['Lutra', 'Lutra lutra'],
//            ['Canidae', 'Canis'],
//            ['Canis', 'Canis latrans'],
//            ['Canis', 'Canis lupus']
//        ],
//        levels: [{
//            level: 0,
//            color: '#DEDDCF',
//            dataLabels: {
//                color: 'black'
//            }
//        }, {
//            level: 1,
//            color: '#DEDDCF',
//            dataLabels: {
//                color: 'black'
//            },
//            height: 25
//        }, {
//            level: 2,
//            color: '#DEDDCF',
//            dataLabels: {
//                color: 'black'
//            }
//        }, {
//            level: 3,
//            dataLabels: {
//                color: 'black'
//            }
//        }],
//        colorByPoint: false,
//        borderColor: 'black',
//        borderWidth: 2
//    }],
//
//    tooltip: {
//        outside: true,
//        format: '{point.custom.info}',
//        style: {
//            width: '320px'
//        }
//    },
//
//    exporting: {
//        allowHTML: true,
//        sourceWidth: 800,
//        sourceHeight: 600
//    }
//});
+ (AAOptions *)carnivoraPhylogenyOrganizationChart {
    return AAOptions.new
        .chartSet(AAChart.new
//                    .heightSet(@600)
                    .invertedSet(false))
    .titleSet(AATitle.new
                .textSet(@"Carnivora Phylogeny"))
    .subtitleSet(AASubtitle.new
                    .textSet(@"Tracing the Evolutionary Relationship of Carnivores"))
    
        .plotOptionsSet(AAPlotOptions.new
                        .seriesSet(AASeries.new
//                                   .nodeWidthSet(@"22%")
                                   ))
//        .accessibilitySet(AAAccessibility.new
//                          .pointSet(AAPoint.new
//                                    .descriptionFormatSet(@"{toNode.name} {#if (eq toNode.level 1 )} is a distinct family within the order of {fromNode.id}. {toNode.custom.info}{/if}{#if (eq toNode.level 2 )} is a genus within the {fromNode.id}. {toNode.custom.info} {/if}{#if (eq toNode.level 3 )} is a species within the {fromNode.id}. {toNode.custom.info} {/if}")))
        .seriesSet(@[
            AASeriesElement.new
                .typeSet(AAChartTypeOrganization)
                .nameSet(@"Carnivora Phyologeny")
                .nodeWidthSet((id)@"22%")
                .keysSet(@[@"from", @"to"])
                .dataSet(@[
                    @[@"Carnivora", @"Felidae"],
                    @[@"Carnivora", @"Mustelidae"],
                    @[@"Carnivora", @"Canidae"],
                    @[@"Felidae", @"Panthera"],
                    @[@"Mustelidae", @"Taxidea"],
                    @[@"Mustelidae", @"Lutra"],
                    @[@"Panthera", @"Panthera pardus"],
                    @[@"Taxidea", @"Taxidea taxus"],
                    @[@"Lutra", @"Lutra lutra"],
                    @[@"Canidae", @"Canis"],
                    @[@"Canis", @"Canis latrans"],
                    @[@"Canis", @"Canis lupus"]
                ])
                .levelsSet(@[
                    AALevelsElement.new
                        .levelSet(@0)
                        .colorSet(@"#DEDDCF")
                        .dataLabelsSet(AADataLabels.new
                        .colorSet(@"black")),
                    AALevelsElement.new
                        .levelSet(@1)
                        .colorSet(@"#DEDDCF")
                        .dataLabelsSet(AADataLabels.new
                        .colorSet(@"black"))
                        .heightSet(@25),
                    AALevelsElement.new
                        .levelSet(@2)
                        .colorSet(@"#DEDDCF")
                        .dataLabelsSet(AADataLabels.new
                        .colorSet(@"black")),
                    AALevelsElement.new
                        .levelSet(@3)
                        .dataLabelsSet(AADataLabels.new
                        .colorSet(@"black"))
                ])
                .nodesSet(AAOptionsData.carnivoraPhylogenyNodesData)
                .colorByPointSet(@false)
                .borderColorSet(@"black")
                .borderWidthSet(@2)
        ])
        .tooltipSet(AATooltip.new
                    .outsideSet(@true)
                    .formatSet(@"{point.custom.info}")
                    .styleSet(AAStyle.new
                              .widthSet((id)@"320px")
                              ))
//        .exportingSet(AAExporting.new
//                      .allowHTMLSet(@true)
//                      .sourceWidthSet(@800)
//                      .sourceHeightSet(@600))
    ;
}


+ (NSString *)aa_toPureJSString2WithString:(NSString *)string {
    //https://stackoverflow.com/questions/34334232/why-does-function-not-work-but-function-does-chrome-devtools-node
    NSString *pureJSStr = [NSString stringWithFormat:@"%@",string];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"'" withString:@"\""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\0" withString:@""];
//    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\r" withString:@"\\r"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\f" withString:@"\\f"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\u2028" withString:@"\\u2028"];
    pureJSStr = [pureJSStr stringByReplacingOccurrencesOfString:@"\u2029" withString:@"\\u2029"];
    return pureJSStr;
}

@end
