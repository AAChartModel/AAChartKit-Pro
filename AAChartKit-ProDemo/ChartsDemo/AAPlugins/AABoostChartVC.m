//
//  AABoostChartVC.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/11.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AABoostChartVC.h"
#import "AABoostOptions.h"

static NSString * const kBoostPath = @"https://code.highcharts.com/modules/boost.js";

@interface AABoostChartVC ()

@end

@implementation AABoostChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"AABoost" ofType:@"js"];
    self.aaChartView.pluginsArray = @[jsPath];
    
    AAOptions *aaOptions = [self configureChartOptions];
    NSDictionary *jsonDic = [AAJsonConverter dictionaryWithObjectInstance:aaOptions];
    NSMutableDictionary *mutableDic = [jsonDic mutableCopy];
//    mutableDic[@"boost"] = @{@"useGPUTranslations": @YES};
    [self.aaChartView aa_drawChartWithOptions:mutableDic];
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

- (NSArray *)getData:(NSNumber *)n {
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
- (AAOptions *)configureChartOptions {
    NSNumber *n = @500000;
    NSArray *data = [self getData:n];
    
    return AAOptions.new
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
        ]);
}
    



@end
