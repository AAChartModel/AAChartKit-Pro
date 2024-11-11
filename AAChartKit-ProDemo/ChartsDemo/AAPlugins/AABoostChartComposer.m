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
