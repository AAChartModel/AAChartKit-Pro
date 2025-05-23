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
 * StackOverflow : https://stackoverflow.com/users/12302132/codeforu
 * JianShu       : http://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 * -------------------------------------------------------------------------------
 
 */

#import "FirstViewController.h"
#import "ChartProVC.h"
#import "AATilemapChartVC.h"
#import "AARelationshipChartVC.h"
#import "AABubbleChartVC.h"
#import "AAColumnVariantChartVC.h"
#import "AAHeatmapChartVC.h"
#import "AATreemapChartVC.h"
#import "AATreegraphChartVC.h"
#import "AABoostChartVC.h"
#import "AADrilldownChartVC.h"
#import "AAOptions3DChartVC.h"
#import "ChartListTableViewVC.h"
#import "ChartListCollectionViewVC.h"

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

- (NSArray *)sectionIndexTitlesForTableView: (UITableView *)tableView {
    NSMutableArray *listTitles = [[NSMutableArray alloc] init];
    for (NSString *item in self.sectionTypeArr) {
          NSString *title = [item substringToIndex: 1];
          [listTitles addObject: title];
    }
    return listTitles;
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
            AARelationshipChartVC *vc = [[AARelationshipChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 1 : {
            AATilemapChartVC *vc = [[AATilemapChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 2 : {
            AABubbleChartVC *vc = [[AABubbleChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 3 : {
            AAColumnVariantChartVC *vc = [[AAColumnVariantChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 4 : {
            ChartProVC *vc = [[ChartProVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
         
        case 5 : {
            AAHeatmapChartVC *vc = [[AAHeatmapChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
         
        case 6 : {
            AATreemapChartVC *vc = [[AATreemapChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 7 : {
            AATreegraphChartVC *vc = [[AATreegraphChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 8 : {
            AABoostChartVC *vc = [[AABoostChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 9 : {
            AADrilldownChartVC *vc = [[AADrilldownChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 10 : {
            AAOptions3DChartVC *vc = [[AAOptions3DChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 11 : {
            if (indexPath.row == 0) {
                ChartListTableViewVC *vc = [[ChartListTableViewVC alloc]init];
//                vc.selectedIndex = indexPath.row;
//                vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                ChartListCollectionViewVC *vc = [[ChartListCollectionViewVC alloc]init];
//                vc.selectedIndex = indexPath.row;
//                vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
                [self.navigationController pushViewController:vc animated:YES];
            }

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

            
            @[
                @"sankeyChart---桑基图",
                @"dependencywheelChart---和弦图🎸",
                @"arcdiagramChart1---弧形图1🌈",
                @"arcdiagramChart2---弧形图2🌈",
                @"arcdiagramChart3---弧形图3🌈",
                @"organizationChart---组织结构图",
                @"networkgraphChart---力导关系图",
                @"simpleDependencyWheelChart---简单的和弦图🎵",
                @"neuralNetworkChart---神经网络图",
                @"carnivoraPhylogenyOrganizationChart---食肉目动物系统发育组织图",
                @"germanicLanguageTreeChart---日耳曼语系树图",
                //     case 11: return [AASankeyComposer sankeyDiagramChart];
//                case 12: return [AASankeyComposer verticalSankeyChart];
                @"sankeyDiagramChart---桑基图",
                @"verticalSankeyChart---垂直桑基图",
            ],
//            "HeatOrTreeMapChart | 热力或树形类型图表",
            @[
                @"heatmapChart---热力图🌡",
//                @"tilemapOrHoneycombChart---砖块图🧱||蜂巢图🐝🌡",
                @"treemapWithColorAxisData---包好色彩轴的矩形树图🌲",
                @"treemapWithLevelsData---包含等级的矩形树图🌲",
                @"drilldownLargeDataTreemapChart---可下钻的大数据量矩形树图🌲",
                @"largeDataHeatmapChart---大数据量热力图🌡",
                @"simpleTilemapWithHexagonTileShape---简单的砖块图🧱(六边形蜂巢图🐝)",
                @"simpleTilemapWithCircleTileShape---简单的砖块图🧱(圆形)",
                @"simpleTilemapWithDiamondTileShape---简单的砖块图🧱(菱形)",
                @"simpleTilemapWithSquareTileShape---简单的砖块图🧱(正方形)",
                
                @"tilemapForAfricaWithHexagonTileShape---非洲砖块图🧱(六边形蜂巢图🐝)",
                @"tilemapForAfricaWithCircleTileShape---非洲砖块图🧱(圆形)",
                @"tilemapForAfricaWithDiamondTileShape---非洲砖块图🧱(菱形)",
                @"tilemapForAfricaWithSquareTileShape---非洲砖块图🧱(正方形)",
                
                @"tilemapForAmericaWithHexagonTileShape---美洲砖块图🧱(六边形蜂巢图🐝)",
                @"tilemapForAmericaWithCircleTileShape---美洲砖块图🧱(圆形)",
                @"tilemapForAmericaWithDiamondTileShape---美洲砖块图🧱(菱形)",
                @"tilemapForAmericaWithSquareTileShape---美洲砖块图🧱(正方形)",
                
                @"treegraphChart---树图",
                @"invertedTreegraphChart---倒置树图",
                @"treegraphWithBoxLayoutChart---树图(盒子布局)",
                @"calendarHeatmap---日历热力图",
                @"treemapWithLevelsData2---包含等级的矩形树图2🌲",

            ],
//            "BubbleChart | 气泡类型图表",
            @[
                @"packedbubbleChart---气泡🎈填充图",
                @"packedbubbleSplitChart---圆🎈堆积图",
                @"packedbubbleSpiralChart---渐进变化的气泡🎈图",
                @"eulerChart---欧拉图",
                @"vennChart---韦恩图",
            ],
//            "ColumnVariantChart | 柱形图(变体)类型图表",
            @[
                @"variwideChart---可变宽度的柱形图",
                @"columnpyramidChart---角锥柱形图",
                @"dumbbellChart---哑铃图",
                @"lollipopChart---棒棒糖🍭图",
                @"xrangeChart---X轴范围图||甘特图||条码图",
                @"histogramChart---直方混合散点图📊",
                @"bellcurveChart---钟形曲线混合散点图🔔",
                @"bulletChart---子弹图",
                //     case  8: return [AAColumnVariantChartComposer pictorial1Chart];
                    //        case  9: return [AAColumnVariantChartComposer pictorial2Chart];

                    @"pictorial1Chart---象形柱形图1",
                    @"pictorial2Chart---象形柱形图2",
            ],
//            "MoreProType | 更多高级类型图表",
            @[
                @"sunburstChart---旭日图",
                @"streamgraphChart---流图",
                @"vectorChart---向量图🏹",
                @"bellcurveChart---贝尔曲线图",
                @"timelineChart---时序图⌚️",
                @"itemChart---议会项目图",
                @"windbarbChart---风羽图",
                @"wordcloudChart---词云图",
                @"flameChart---火焰🔥图",
                @"itemChart2---议会项目图2",
                @"itemChart3---议会项目图3",
                @"icicleChart---冰柱图🧊",
                @"sunburstChart2---旭日图☀️",
                @"solidgaugeChart---活动图🏃🏻‍♀️",
                @"parallelCoordinatesSplineChart---平行坐标曲线图",
                @"parallelCoordinatesLineChart---平行坐标折线图📈",
                @"volinPlotChart---小提琴图🎻",
                @"variablepieChart---可变宽度的饼图🍪",
                @"semicircleSolidGaugeChart---半圆形活动图🏃🏻‍♀️",
            ],
            
            //            "RelationshipChart | 关系类型图表",
            //            case 0: return [AAHeatmapChartComposer heatmapChart];
            //            case 1: return [AAHeatmapChartComposer largeDataHeatmapChart];
            //            case 2: return [AAHeatmapChartComposer calendarHeatmap];
            @[
                @"heatmapChart---热力图🌡",
                @"largeDataHeatmapChart---大数据量热力图🌡",
                @"calendarHeatmap---日历热力图",
            ],
//            case 0: return [AATreemapChartComposer treemapWithColorAxisData];
//            case 1: return [AATreemapChartComposer treemapWithLevelsData];
//            case 2: return [AATreemapChartComposer treemapWithLevelsData2];
//            case 3: return [AATreemapChartComposer drilldownLargeDataTreemapChart];
            @[
                @"treemapWithColorAxisData---包含色彩轴的矩形树图🌲",
                @"treemapWithLevelsData---包含等级的矩形树图🌲",
                @"treemapWithLevelsData2---包含等级的矩形树图2🌲",
                @"drilldownLargeDataTreemapChart---可下钻的大数据量矩形树图🌲",
            ],
//            case 0: return [AATreegraphChartComposer treegraph];
//            case 1: return [AATreegraphChartComposer invertedTreegraph];
//            case 2: return [AATreegraphChartComposer treegraphWithBoxLayout];
             @[
                 @"treegraphChart---树图",
                 @"invertedTreegraphChart---倒置树图",
                 @"treegraphWithBoxLayoutChart---树图(盒子布局)",
             ],
            
            //            + (NSDictionary *)lineChart;
//            + (NSDictionary *)areaChart;
      //            + (NSDictionary *)columnChart;
            //            + (NSDictionary *)lineChartWithHundredsOfSeries;
            //            + (NSDictionary *)scatterChartOptions;
            //            + (NSDictionary *)areaRangeChart;
            //            + (NSDictionary *)columnRangeChart;
            //+ (NSDictionary *)bubbleChart
            //+ (NSDictionary *)heatmapChart
            //+ (NSDictionary *)stackingAreaChart;
//            + (NSDictionary *)stackingColumnChart;


            
            @[
                @"lineChart---折线图",
                @"areaChart---区域填充图",
                @"columnChart---柱形图",
                @"lineChartWithHundredsOfSeries---百个数据集的折线图",
                @"scatterChartOptions---散点图",
                @"areaRangeChart---区域范围图",
                @"columnRangeChart---柱形范围图",
                @"bubbleChart---气泡图",
                @"heatMapChart---热力图",
                @"stackingAreaChart---堆积区域填充图",
                @"stackingColumnChart---堆积柱形图",
            ],
            
            @[
                @"columnChart---柱形图",
            ],
            //+ (AAOptions *)_3DColumnWithStackingRandomData;
            //+ (AAOptions *)_3DColumnWithStackingAndGrouping;
            //            + (AAOptions *)_3DBarWithStackingRandomData;
            //            + (AAOptions *)_3DBarWithStackingAndGrouping;
            //+ (AAOptions *)_3DAreaChart;
            //+ (AAOptions *)_3DScatterChart;
            @[
                @"_3DColumnWithStackingRandomData---3D堆积随机柱形图",
                @"_3DColumnWithStackingAndGrouping---3D堆积且分组柱形图",
                @"_3DBarWithStackingRandomData---3D堆积随机条形图",
                @"_3DBarWithStackingAndGrouping---3D堆积且分组条形图",
                @"_3DAreaChart---3D区域填充图",
                @"_3DScatterChart---3D散点图",
                @"_3DPieChart---3D饼图🍪",
            ],
            @[
                @"UITableView 画廊",
                @"UICollectionView 画廊",
             
            ],
            
        ];
    }
    return _chartTypeNameArr;
}

- (NSArray *)sectionTypeArr {
    if (!_sectionTypeArr) {
        _sectionTypeArr = @[
            @"RelationshipChart | 关系类型图表",
            @"HeatOrTreeMapChart | 热力或树形类型图表",
            @"BubbleChart | 气泡类型图表",
            @"ColumnVariantChart | 柱形图(变体)类型图表",
            @"MoreProType | 更多高级类型图表",
            @"HeatmapChart | 热力图",
            @"TreemapChart | 矩形树图",
            @"TreegraphChart | 树图",
            @"BoostChart | 加速图表",
            @"DrilldownChart | 下钻图表",
            @"Options3DChart | 3D图表",
            @"Gallery | 画廊",

        ];
    }
    return _sectionTypeArr;
}

@end

