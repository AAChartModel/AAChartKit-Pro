//
//  AABoostChartComposer.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/11.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AABoostChartComposer.h"
#import "AAChartKit-Pro.h"

@implementation AABoostChartComposer

/**
 function getData(n) {
     const arr = [];
     let a,
         b,
         c,
         spike;
     for (let i = 0; i < n; i = i + 1) {
         if (i % 100 === 0) {
             a = 2 * Math.random();
         }
         if (i % 1000 === 0) {
             b = 2 * Math.random();
         }
         if (i % 10000 === 0) {
             c = 2 * Math.random();
         }
         if (i % 50000 === 0) {
             spike = 10;
         } else {
             spike = 0;
         }
         arr.push([
             i,
             2 * Math.sin(i / 100) + a + b + c + spike + Math.random()
         ]);
     }
     return arr;
 }
 const n = 500000,
     data = getData(n);


 console.time('line');
 Highcharts.chart('container', {

     chart: {
         zooming: {
             type: 'x'
         },
         panning: true,
         panKey: 'shift'
     },

     boost: {
         useGPUTranslations: true
     },

     title: {
         text: 'Highcharts drawing ' + n + ' points'
     },

     subtitle: {
         text: 'Using the Boost module'
     },

     tooltip: {
         valueDecimals: 2
     },

     series: [{
         data: data,
         lineWidth: 0.5
     }]

 });
 console.timeEnd('line');

 */

+ (NSArray *)getLineChartData:(NSNumber *)n {
    NSMutableArray *arr = [NSMutableArray array];
    NSNumber *a;
    NSNumber *b;
    NSNumber *c;
    NSNumber *spike;
    for (NSInteger i = 0; i < n.integerValue; i = i + 1) {
        if (i % 100 == 0) {
            a = @(2 * arc4random_uniform(100) / 100);
        }
        if (i % 1000 == 0) {
            b = @(2 * arc4random_uniform(100) / 100);
        }
        if (i % 10000 == 0) {
            c = @(2 * arc4random_uniform(100) / 100);
        }
        if (i % 50000 == 0) {
            spike = @10;
        } else {
            spike = @0;
        }
        [arr addObject:@[@(i), @(2 * sin(i / 100) + a.doubleValue + b.doubleValue + c.doubleValue + spike.doubleValue + arc4random_uniform(100) / 100)]];
    }
    return arr;
}

//配置 AAOptions 实例对象
+ (NSDictionary *)lineChart {
    NSNumber *n = @500000;
    NSArray *data = [self getLineChartData:n];
    
    AAOptions *aaOptions = AAOptions.new
//        .boostSet(AABoost.new
//                  .useGPUTranslationsSet(true))
        .chartSet(AAChart.new
                  //              .zoomTypeSet(AAChartZoomTypeX)
                  .pinchTypeSet(AAChartZoomTypeX)
                  .panningSet(true)
                  .panKeySet(@"shift"))
        .titleSet(AATitle.new
                  .textSet([NSString stringWithFormat:@"Highcharts drawing %@ points", n]))
        .subtitleSet(AASubtitle.new
                     .textSet(@"Using the Boost module"))
        .tooltipSet(AATooltip.new
                    .valueDecimalsSet(@2))
        .seriesSet(@[
            AASeriesElement.new
                .dataSet(data)
                .lineWidthSet(@0.5)
                .colorSet(AAColor.redColor)
        ]);
    
    NSDictionary *jsonDic = [AAJsonConverter dictionaryWithObjectInstance:aaOptions];
    NSMutableDictionary *mutableDic = [jsonDic mutableCopy];
    mutableDic[@"boost"] = @{@"useGPUTranslations": @YES};
    return mutableDic;
}
    
+ (NSDictionary *)areaChart {
    NSNumber *n = @500000;
    NSArray *data = [self getLineChartData:n];
    
    AAOptions *aaOptions = AAOptions.new
//        .boostSet(AABoost.new
//                  .useGPUTranslationsSet(true))
        .chartSet(AAChart.new
                  .typeSet(AAChartTypeArea)
                  //              .zoomTypeSet(AAChartZoomTypeX)
                  .pinchTypeSet(AAChartZoomTypeX)
                  .panningSet(true)
                  .panKeySet(@"shift"))
        .titleSet(AATitle.new
                  .textSet([NSString stringWithFormat:@"Highcharts drawing %@ points", n]))
        .subtitleSet(AASubtitle.new
                     .textSet(@"Using the Boost module"))
        .tooltipSet(AATooltip.new
                    .valueDecimalsSet(@2))
        .seriesSet(@[
            AASeriesElement.new
                .dataSet(data)
                .lineWidthSet(@0.5)
                .colorSet(AAColor.greenColor)
        ]);
    
    NSDictionary *jsonDic = [AAJsonConverter dictionaryWithObjectInstance:aaOptions];
    NSMutableDictionary *mutableDic = [jsonDic mutableCopy];
    mutableDic[@"boost"] = @{@"useGPUTranslations": @YES};
    return mutableDic;
}

+ (NSDictionary *)columnChart {
    NSNumber *n = @500000;
    NSArray *data = [self getLineChartData:n];
    
    AAOptions *aaOptions = AAOptions.new
//        .boostSet(AABoost.new
//                  .useGPUTranslationsSet(true))
        .chartSet(AAChart.new
                  .typeSet(AAChartTypeColumn)
                  //              .zoomTypeSet(AAChartZoomTypeX)
                  .pinchTypeSet(AAChartZoomTypeX)
                  .panningSet(true)
                  .panKeySet(@"shift"))
        .titleSet(AATitle.new
                  .textSet([NSString stringWithFormat:@"Highcharts drawing %@ points", n]))
        .subtitleSet(AASubtitle.new
                     .textSet(@"Using the Boost module"))
        .tooltipSet(AATooltip.new
                    .valueDecimalsSet(@2))
        .seriesSet(@[
            AASeriesElement.new
                .dataSet(data)
                .lineWidthSet(@0.5)
                .colorSet(AAColor.yellowColor)
        ]);
    
    NSDictionary *jsonDic = [AAJsonConverter dictionaryWithObjectInstance:aaOptions];
    NSMutableDictionary *mutableDic = [jsonDic mutableCopy];
    mutableDic[@"boost"] = @{@"useGPUTranslations": @YES};
    return mutableDic;
}

/**
 function getData(n) {
     const arr = [];
     let a,
         b,
         c,
         spike;
     for (let i = 0; i < n; i = i + 1) {
         if (i % 100 === 0) {
             a = 2 * Math.random();
         }
         if (i % 1000 === 0) {
             b = 2 * Math.random();
         }
         if (i % 10000 === 0) {
             c = 2 * Math.random();
         }
         if (i % 50000 === 0) {
             spike = 0;
         } else {
             spike = 0;
         }
         arr.push([
             i,
             2 * Math.sin(i / 100) + a + b + c + spike + Math.random()
         ]);
     }
     return arr;
 }

 function getSeries(n, s) {
     let i = 0;
     const r = [];

     for (; i < s; i++) {
         r.push({
             data: getData(n),
             lineWidth: 2,
             boostThreshold: 1
         });
     }

     return r;
 }

 const n = 1000,
     s = 600,
     series = getSeries(n, s);


 console.time('line');
 Highcharts.chart('container', {

     chart: {
         zooming: {
             type: 'x'
         }
     },

     title: {
         text:
             'Highcharts drawing ' + (n * s) + ' points across ' + s + ' series'
     },

     legend: {
         enabled: false
     },

     boost: {
         useGPUTranslations: true
     },

     xAxis: {
         min: 0,
         max: 120,
         ordinal: false
     },

     navigator: {
         xAxis: {
             ordinal: false,
             min: 0,
             max: 10
         }
     },

     // yAxis: {
     //     min: 0,
     //     max: 8
     // },

     subtitle: {
         text: 'Using the Boost module'
     },

     tooltip: {
         valueDecimals: 2
     },

     series: series

 });
 console.timeEnd('line');
 */
//生成 data 数组
+ (NSArray *)getData:(NSInteger)n {
    NSMutableArray *arr = [NSMutableArray array];
    CGFloat a, b, c, spike;
    for (NSInteger i = 0; i < n; i = i + 1) {
        if (i % 100 == 0) {
            a = 2 * (float)arc4random_uniform(100);
        }
        if (i % 1000 == 0) {
            b = 2 * (float)arc4random_uniform(100);
        }
        if (i % 10000 == 0) {
            c = 2 * (float)arc4random_uniform(100);
        }
        if (i % 50000 == 0) {
            spike = 0;
        } else {
            spike = 0;
        }
        [arr addObject:@[
            @(i),
            @(2 * sin(i / 100) + a + b + c + spike + (float)arc4random_uniform(100))
        ]];
    }
    return arr;
}

//生成 series 数组
+ (NSArray *)getSeries:(NSInteger)n s:(NSInteger)s {
    NSMutableArray *r = [NSMutableArray array];
    for (NSInteger i = 0; i < s; i++) {
        [r addObject:@{
            @"data": [self getData:n],
            @"lineWidth": @2,
            @"boostThreshold": @1
        }];
    }
    return r;
}

//配置 AAOptions 实例对象
+ (NSDictionary *)lineChartWithHundredsOfSeries {
    NSInteger n = 1000;
    NSInteger s = 600;
    NSArray *series = [self getSeries:n s:s];
    
    AAOptions *aaOptions = AAOptions.new
    .chartSet(AAChart.new
//              .zoomTypeSet(AAChartZoomTypeX)
              .pinchTypeSet(AAChartZoomTypeX)
              )
    .titleSet(AATitle.new
              .textSet([NSString stringWithFormat:@"Highcharts drawing %ld points across %ld series", n * s, s]))
    .legendSet(AALegend.new
               .enabledSet(false))
//    .boostSet(AABoost.new
//              .useGPUTranslationsSet(true))
    .xAxisSet(AAXAxis.new
              .minSet(@0)
              .maxSet(@120)
//              .ordinalSet(false)
              )
//    .navigatorSet(AANavigator.new
//                  .xAxisSet(AAXAxis.new
//                            .ordinalSet(false)
//                            .minSet(@0)
//                            .maxSet(@10)))
    .subtitleSet(AASubtitle.new
                 .textSet(@"Using the Boost module"))
    .tooltipSet(AATooltip.new
                .valueDecimalsSet(@2))
    .seriesSet(series);
    
    NSDictionary *jsonDic = [AAJsonConverter dictionaryWithObjectInstance:aaOptions];
    NSMutableDictionary *mutableDic = [jsonDic mutableCopy];
    mutableDic[@"boost"] = @{@"useGPUTranslations": @YES};
    return jsonDic;
}


/**
 // Prepare the data
 const data = [],
     n = 1000000;

 for (let i = 0; i < n; i += 1) {
     data.push([
         Math.pow(Math.random(), 2) * 100,
         Math.pow(Math.random(), 2) * 100
     ]);
 }

 if (!Highcharts.Series.prototype.renderCanvas) {
     throw 'Module not loaded';
 }

 console.time('scatter');
 Highcharts.chart('container', {

     chart: {
         zooming: {
             type: 'xy'
         },
         height: '100%'
     },

     boost: {
         useGPUTranslations: true,
         usePreAllocated: true
     },

     xAxis: {
         min: 0,
         max: 100,
         gridLineWidth: 1
     },

     yAxis: {
         // Renders faster when we don't have to compute min and max
         min: 0,
         max: 100,
         minPadding: 0,
         maxPadding: 0,
         title: {
             text: null
         }
     },

     title: {
         text: 'Scatter chart with ' +
             Highcharts.numberFormat(data.length, 0, ' ') + ' points'
     },

     legend: {
         enabled: false
     },

     series: [{
         type: 'scatter',
         color: 'rgb(152, 0, 67)',
         fillOpacity: 0.1,
         data: data,
         marker: {
             radius: 1
         },
         tooltip: {
             followPointer: false,
             pointFormat: '[{point.x:.1f}, {point.y:.1f}]'
         }
     }]

 });
 console.timeEnd('scatter');
 */

//配置 AAOptions 实例对象
+ (NSDictionary *)scatterChartOptions {
    NSMutableArray *data = [NSMutableArray array];
    NSInteger n = 1000000;
    for (NSInteger i = 0; i < n; i += 1) {
        [data addObject:@[
            @(powf((float)arc4random_uniform(100), 2) * 100),
            @(powf((float)arc4random_uniform(100), 2) * 100)
        ]];
    }
    
    AAOptions *aaOptions = AAOptions.new
    .chartSet(AAChart.new
//              .zoomTypeSet(AAChartZoomTypeXY)
              .pinchTypeSet(AAChartZoomTypeXY)
//              .heightSet(@"100%")
              )
//    .boostSet(AABoost.new
//              .useGPUTranslationsSet(true)
//              .usePreAllocatedSet(true))
//    .xAxisSet(AAXAxis.new
//              .minSet(@0)
//              .maxSet(@100)
//              .gridLineWidthSet(@1))
//    .yAxisSet(AAYAxis.new
//              .minSet(@0)
//              .maxSet(@100)
//              .minPaddingSet(@0)
//              .maxPaddingSet(@0)
//              .titleSet(AAAxisTitle.new
//                        .textSet(@"")))
    .titleSet(AATitle.new
              .textSet([NSString stringWithFormat:@"Scatter chart with %ld points", (long)data.count]))
    .legendSet(AALegend.new
               .enabledSet(false))
    .seriesSet(@[
        AASeriesElement.new
        .typeSet(AAChartTypeScatter)
        .colorSet(@"rgb(152, 0, 67)")
        .fillOpacitySet(@0.1)
        .dataSet(data)
        .markerSet(AAMarker.new
                   .radiusSet(@1))
        .tooltipSet(AATooltip.new
                    .followPointerSet(false)
                    .pointFormatSet(@"[{point.x:.1f}, {point.y:.1f}]"))
    ]);
    
    NSDictionary *jsonDic = [AAJsonConverter dictionaryWithObjectInstance:aaOptions];
    NSMutableDictionary *mutableDic = [jsonDic mutableCopy];
//    mutableDic[@"boost"] = @{@"useGPUTranslations": @YES};
    mutableDic[@"boost"] = @{
        @"useGPUTranslations": @YES,
        @"usePreAllocated": @YES
    };
    /**
     xAxis: {
             min: 0,
             max: 100,
             gridLineWidth: 1
         },

         yAxis: {
             // Renders faster when we don't have to compute min and max
             min: 0,
             max: 100,
             minPadding: 0,
             maxPadding: 0,
             title: {
                 text: null
             }
         },
     */
//    mutableDic[@"xAxis"] = @{
//        @"min": @0,
//        @"max": @100,
//        @"gridLineWidth": @1
//    };
//    mutableDic[@"yAxis"] = @{
//        @"min": @0,
//        @"max": @100,
//        @"minPadding": @0,
//        @"maxPadding": @0,
//        @"title": @{
//            @"text": @""
//        }
//    };
    return mutableDic;
}



@end
