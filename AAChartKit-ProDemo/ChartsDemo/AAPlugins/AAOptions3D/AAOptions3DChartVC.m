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
    NSString *jsPath = [[NSBundle mainBundle] pathForResource:@"AAHighcharts-3D" ofType:@"js"];
    self.aaChartView.pluginsArray = @[jsPath];
    
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

}

- (id)chartConfigurationWithSelectedIndex:(NSUInteger)selectedIndex {
    switch (self.selectedIndex) {
//+ (AAOptions *)_3DColumnWithStackingRandomData;
//+ (AAOptions *)_3DColumnWithStackingAndGrouping;
//+ (AAOptions *)_3DAreaChart;
//+ (AAOptions *)_3DScatterChart;
        case 0: return [AAOptions3DChartComposer _3DColumnWithStackingRandomData];
        case 1: return [AAOptions3DChartComposer _3DColumnWithStackingAndGrouping];
        case 2: return [AAOptions3DChartComposer _3DAreaChart];
        case 3: return [AAOptions3DChartComposer _3DScatterChart];
       


    }
    return nil;
}

    



@end
