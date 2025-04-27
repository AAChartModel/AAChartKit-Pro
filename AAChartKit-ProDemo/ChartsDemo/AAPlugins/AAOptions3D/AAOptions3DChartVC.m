//
//  AAOptions3DChartVC.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2024/11/15.
//  Copyright © 2024 An An. All rights reserved.
//

#import "AAOptions3DChartVC.h"
#import "AAOptions3DChartComposer.h"


@interface AAOptions3DChartVC ()

@end

@implementation AAOptions3DChartVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //AAHighcharts-3D
    NSString *_3DJSPath = [[NSBundle mainBundle] pathForResource:@"AAHighcharts-3D" ofType:@"js"];
    //AAExporting
//    NSString *exportingJSPath = [[NSBundle mainBundle] pathForResource:@"AAExporting" ofType:@"js"];
//    //AAOffline-Exporting
//    NSString *offlineExportingJSPath = [[NSBundle mainBundle] pathForResource:@"AAOffline-Exporting" ofType:@"js"];
    //AANavigator
//    NSString *navigatorJSPath = [[NSBundle mainBundle] pathForResource:@"AANavigator" ofType:@"js"];
    
    self.aaChartView.pluginsArray = @[
        _3DJSPath,
//        exportingJSPath,
//        offlineExportingJSPath,
//        navigatorJSPath,
    ];
    
//    AAOptions *aaOptions = [self configureChartOptions];
//    NSDictionary *jsonDic = [AABoostChartComposer lineChartOptions];
    AAOptions *aaOptions = [self chartConfigurationWithSelectedIndex:self.selectedIndex];
    //⚠️ 这里打断点虽然看不到 boost 属性, 但是转换成 json 之后就能看到了
    //PS: 为什么看不到? 因为 boost 是一个动态属性, 通过 runtime 关联对象添加的
    //如果在控制台打印 aaOptions  JSON 看不到 boost 属性, 在控制台搜索 boost 关键字也搜索不到, 其实只是因为数据太长, 控制台没有完全展示而已
//    AABoost *boost = aaOptions.boost;
//    NSLog(@"🚀🚀🚀 查看 boost 属性是否正常: %@",boost.toDic);
//    [self.aaChartView aa_drawChartWithOptions:aaOptions];
    
    //https://code.highcharts.com/{version}/modules/boost.js
    //https://code.highcharts.com/9.3.2/modules/boost.js
    //<script src="https://code.highcharts.com/modules/drilldown.js"></script>
    //https://code.highcharts.com/11.0.1/modules/drilldown.js
    //<script src="https://code.highcharts.com/highcharts-3d.js"></script>
    //https://code.highcharts.com/11.0.1/highcharts-3d.js
    //<script src="https://code.highcharts.com/modules/exporting.js"></script>
    //https://code.highcharts.com/11.0.1/modules/exporting.js
    //<script src="https://code.highcharts.com/modules/offline-exporting.js"></script>
    //https://code.highcharts.com/11.0.1/modules/offline-exporting.js
    //<script src="https://code.highcharts.com/modules/navigator.js"></script>
    //https://code.highcharts.com/11.0.1/modules/navigator.js

}

- (id)chartConfigurationWithSelectedIndex:(NSUInteger)selectedIndex {
    switch (self.selectedIndex) {
//+ (AAOptions *)_3DColumnWithStackingRandomData;
//+ (AAOptions *)_3DColumnWithStackingAndGrouping;
//            + (AAOptions *)_3DBarWithStackingRandomData;
//            + (AAOptions *)_3DBarWithStackingAndGrouping;
//+ (AAOptions *)_3DAreaChart;
//+ (AAOptions *)_3DScatterChart;
        case 0: return [AAOptions3DChartComposer _3DColumnWithStackingRandomData];
        case 1: return [AAOptions3DChartComposer _3DColumnWithStackingAndGrouping];
        case 2: return [AAOptions3DChartComposer _3DBarWithStackingRandomData];
        case 3: return [AAOptions3DChartComposer _3DBarWithStackingAndGrouping];
        case 4: return [AAOptions3DChartComposer _3DAreaChart];
        case 5: return [AAOptions3DChartComposer _3DScatterChart];
        case 6: return [AAOptions3DChartComposer _3DPieChart];
        


    }
    return nil;
}

    



@end
