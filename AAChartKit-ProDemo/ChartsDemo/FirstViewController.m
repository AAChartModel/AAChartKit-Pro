//
//  FirstViewController.m
//  AAChartKit
//
//  Created by An An on 17/3/14.
//  Copyright © 2017年 An An. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

/*
 
 * -------------------------------------------------------------------------------
 *
 * 🌕 🌖 🌗 🌘  ❀❀❀   WARM TIPS!!!   ❀❀❀ 🌑 🌒 🌓 🌔
 *
 * Please contact me on GitHub,if there are any problems encountered in use.
 * GitHub Issues : https://github.com/AAChartModel/AAChartKit/issues
 * -------------------------------------------------------------------------------
 * And if you want to contribute for this project, please contact me as well
 * GitHub        : https://github.com/AAChartModel
 * StackOverflow : https://stackoverflow.com/users/7842508/codeforu
 * JianShu       : http://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 * -------------------------------------------------------------------------------
 
 */

#import "FirstViewController.h"
#import "BasicChartVC.h"
#import "SpecialChartVC.h"
#import "OnlyRefreshChartDataVC.h"
#import "ChartAnimationTypeVC.h"
#import "ChartProVC.h"
#import "DrilldownChartVC.h"
#import "ShowManyChartViewVC.h"
#import "ChartListVC.h"
#import "MixedChartVC.h"

#define ColorWithRGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define AAGrayColor            [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1.0]
#define AABlueColor            ColorWithRGB(63, 153,231,1)

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *chartTypeNameArr;
@property (nonatomic, strong) NSArray *sectionTypeArr;
@property (nonatomic, strong) NSArray <NSLayoutConstraint *>*constraintArr;

@end

@implementation FirstViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AAChartKit-Pro";
    self.view.backgroundColor = [UIColor whiteColor];

    [self configTheTableView];
}

- (void)configTheTableView {
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate =self;
    tableView.dataSource =self;
    [self.view addSubview:tableView];
    
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addConstraints:[self configureTheConstraintArrayWithItem:tableView toItem:self.view]];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.chartTypeNameArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc]init];
//    view.backgroundColor = AAGrayColor;
    
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont boldSystemFontOfSize:16.0f];
    label.backgroundColor = AAGrayColor;
    label.textColor = [UIColor purpleColor];
    label.text = self.sectionTypeArr[section];
    [view addSubview:label];
    
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [view addConstraints:[self configureTheConstraintArrayWithItem:label toItem:view]];
    return view;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.chartTypeNameArr[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.chartTypeNameArr[indexPath.section][indexPath.row];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.textAlignment = NSTextAlignmentLeft;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0 : {
            /*通过AAOptions实例对象来绘制图形*/
            ChartProVC *vc = [[ChartProVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1: {
            /*基础类型图表*/
            BasicChartVC *vc = [[BasicChartVC alloc]init];
            vc.chartType = indexPath.row;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 2: {
            /*特殊类型图表*/
            SpecialChartVC *vc = [[SpecialChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3: {
            /*图表数据动态刷新*/
            MixedChartVC *vc = [[MixedChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController  pushViewController:vc animated:YES];
        }
            break;
            
            
        case 4: {
            /*图表数据动态刷新*/
            OnlyRefreshChartDataVC *vc = [[OnlyRefreshChartDataVC alloc]init];
            vc.chartType = indexPath.row;
            [self.navigationController  pushViewController:vc animated:YES];
        }
            break;

        case 5: {
            /*JQuery动画样式类型演示*/
            ChartAnimationTypeVC *vc = [[ChartAnimationTypeVC alloc]init];
            vc.chartType = indexPath.row;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 6: {
            /*同时显示多个 AAChartView*/
            if (indexPath.row == 0) {
                ShowManyChartViewVC *vc = [[ShowManyChartViewVC alloc]init];
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                ChartListVC *listVC = [[ChartListVC alloc]init];
                [self.navigationController pushViewController:listVC animated:YES];
            }

        }
            break;
            
        case 7: {
            /*可向下钻取类型图表*/
            DrilldownChartVC *vc = [[DrilldownChartVC alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        
        default:
            break;
    }
    
}

- (NSArray *)configureTheConstraintArrayWithItem:(UIView *)view1 toItem:(UIView *)view2 {
    return  @[[NSLayoutConstraint constraintWithItem:view1
                                           attribute:NSLayoutAttributeLeft
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:view2
                                           attribute:NSLayoutAttributeLeft
                                          multiplier:1.0
                                            constant:0],
              [NSLayoutConstraint constraintWithItem:view1
                                           attribute:NSLayoutAttributeRight
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:view2
                                           attribute:NSLayoutAttributeRight
                                          multiplier:1.0
                                            constant:0],
              [NSLayoutConstraint constraintWithItem:view1
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:view2
                                           attribute:NSLayoutAttributeTop
                                          multiplier:1.0
                                            constant:0],
              [NSLayoutConstraint constraintWithItem:view1
                                           attribute:NSLayoutAttributeBottom
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:view2
                                           attribute:NSLayoutAttributeBottom
                                          multiplier:1.0
                                            constant:0],
              
              ];
}

- (NSArray *)chartTypeNameArr {
    if (!_chartTypeNameArr) {
        _chartTypeNameArr = @[
            /*通过AAOptions实例对象来绘制图形*/
            @[@"sankeyChart---桑基图",
              @"variablepieChart---可变宽度的饼图",
              @"treemapChart---树形图",
              @"variwideChart---可变宽度的柱形图",
              @"sunburstChart---旭日图",
              @"dependencywheelChart---和弦图",
              @"heatmapChart---热力图",
              @"packedbubbleChart---气泡填充图",
              @"packedbubbleSplitChart---圆堆积图",
              @"vennChart---韦恩图",
              @"dumbbellChart---哑铃图",
              @"lollipopChart---棒棒糖🍭图",
              @"streamgraphChart---流图",
              @"columnpyramidChart---角锥柱形图",
              @"tilemapChart---砖块图🧱||蜂巢图🐝",
              @"simpleTreemapChart---简单矩形树🌲图",
              @"drilldownTreemapChart---可下钻的矩形树🌲图",
              @"xrangeChart---X轴范围图||甘特图||条码图",
              @"vectorChart---向量图🏹",
              @"bellcurveChart---贝尔曲线图",
              @"timelineChart---时序图⌚️",
              @"itemChart---议会项目图",
              @"windbarbChart---风羽图",
              @"networkgraphChart---力导关系图",
              @"wordcloudChart---词云图",
              @"eulerChart---欧拉图",
//              var dataJson = JSON.stringify(points);
//
//              console.log(dataJson);
            ],
            /*基础类型图表*/
            @[@"Column Chart---柱形图",
              @"Bar Chart---条形图",
              @"Area Chart---折线填充图",
              @"Areaspline Chart---曲线填充图",
              @"Line Chart---折线图",
              @"Spline Chart---曲线图",
              @"Step Line Chart--直方折线图",
              @"Step Area Chart--直方折线填充图",
              @"Scatter Chart---散点图"
            ],
            /*特殊类型图表*/
            @[@"Pie Chart---扇形图",
              @"Bubble Chart---气泡图",
              @"Scatter Chart--散点图",
              @"Area Range Chart--折线区域面积图",
              @"Area Spline range Chart--曲线区域面积图",
              @"Column Range Chart--柱形范围图",
              @"Box Plot Chart---箱线图",
              @"Water Fall---瀑布图",
              @"Pyramid Chart---金字塔图",
              @"Funnel Chart---漏斗图",
              @"Error Bar Chart---误差图",
            ],
            /*混合类型图表*/
            @[@"Arearange Mixed Line---面积范围均线图",
              @"Columnrange Mixed Line---柱形范围图混合折线图",
              @"Stacking Column Mixed Line---堆积柱形图混合折线图",
              @"Dash Style Types Mixed---多种类型曲线混合图",
              @"All Line Dash Style Types Mixed Chart---所有类型曲线混合图",
              @"Negative Color Mixed Column Chart---基准线以下异色混合柱状图📊",
              @"scatterMixedLine---散点图混合折线图",
              @"Negative Color Mixed Bubble Chart---基准线以下异色混合气泡图",
              @"Polygon Mixed Scatter---多边形混合散点图",
              @"Polar Chart Mixed---极地混合图",
              @"configure Column Mixed Scatter Chart---柱形图混合散点图",
              @"Negative Color Mixed Areaspline chart---基准线以下异色混合曲线填充图",
              @"Area Chart Mixed Step Area Chart---折线填充和直方折线填充混合图"
              
            ],
            /*图表数据动态刷新*/
            @[@"Column Chart---柱形图",
              @"Bar Chart---条形图",
              @"Area Chart---折线填充图",
              @"Areaspline Chart---曲线填充图",
              @"Line Chart---折线图",
              @"Spline Chart---曲线图",
              @"Step Line Chart--直方折线图",
              @"Step Area Chart--直方折线填充图",
              @"Scatter Chart---散点图"
            ],
            /*JQuery动画样式类型演示*/
            @[@"Column Chart---柱形图",
              @"Bar Chart---条形图",
              @"Area Chart---折线填充图",
              @"Areaspline Chart---曲线填充图",
              @"Line Chart---折线图",
              @"Spline Chart---曲线图",
              @"Step Line Chart--直方折线图",
              @"Step Area Chart--直方折线填充图",
              @"Scatter Chart --散点图",
              @"Pie Chart --扇形图"
            ],
            
            /*同时显示多个 AAChartView*/
            @[@"同时显示多个 AAChartView",
              @"UITableView上显示多个 AAChartView"
            ],
            /*可向下钻取类型图表*/
            @[@"Drilldown column chart--向下钻取的柱状图"
            ],
        ];
    }
    return _chartTypeNameArr;
}

- (NSArray *)sectionTypeArr {
    if (!_sectionTypeArr) {
        _sectionTypeArr = @[
            @"Pro Type---高级类型",
            @"Basic Type---基础类型",
            @"Special Type---特别类型",
            @"Mixed Type Chart---混合图表",
            @"Real-time Refresh---即时刷新",
            @"Animation Type---渲染动画",
            @"同时显示多个 AAChartView",
            @"Drilldown chart---钻取图表(暂时废弃)",];
    }
    return _sectionTypeArr;
}

@end

