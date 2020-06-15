//
//  ViewController.m
//  AAChartKit
//
//  Created by An An on 17/3/13.
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
 * ❤❤❤❤❤❤   WARM TIPS!!!   ❤❤❤❤❤❤
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

#import "SecondViewController.h"
#import "AAChartKit.h"

@interface SecondViewController ()<AAChartViewDidFinishLoadDelegate>

@property (nonatomic, strong) AAChartModel *aaChartModel;
@property (nonatomic, strong) AAChartView  *aaChartView;

@end

@implementation SecondViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.barTintColor = [self colorWithHexString:@"#4b2b7f"];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]}];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[self colorWithHexString:@"#4b2b7f"]}];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [self colorWithHexString:@"#4b2b7f"];
    
//    var xAxisData = [];
//    var data1 = [];
//    var data2 = [];
//    for (var i = 0; i < 100; i++) {
//        xAxisData.push('类目' + i);
//        data1.push((Math.sin(i / 5) * (i / 5 -10) + i / 6) * 5);
//        data2.push((Math.cos(i / 5) * (i / 5 -10) + i / 6) * 5);
//    }
    


    
    [self setUpTheSegmentedControls];
    [self setUpTheSwitchs];
    
    AAChartType chartType;
    switch (self.chartType) {
        case 0:
            chartType = AAChartTypeColumn;
            break;
        case 1:
            chartType = AAChartTypeBar;
            break;
        case 2:
            chartType = AAChartTypeArea;
            break;
        case 3:
            chartType = AAChartTypeAreaspline;
            break;
        case 4:
            chartType = AAChartTypeLine;
            break;
        case 5:
            chartType = AAChartTypeSpline;
            break;
        case 6:
            chartType = AAChartTypeLine;
            break;
        case 7:
            chartType = AAChartTypeArea;
            break;
        case 8:
            chartType = AAChartTypeScatter;
            break;
        default:
            break;
    }
    
    self.title = [NSString stringWithFormat:@"%@ chart",chartType];
    
    [self setUpTheAAChartViewWithChartType:chartType];
    
}

- (void)setUpTheAAChartViewWithChartType:(AAChartType)chartType {
    
    CGFloat chartViewWidth  = self.view.frame.size.width;
    CGFloat chartViewHeight = self.view.frame.size.height-220;
    self.aaChartView = [[AAChartView alloc]init];
    self.aaChartView.frame = CGRectMake(0, 60, chartViewWidth, chartViewHeight);
    self.aaChartView.delegate = self;
    self.aaChartView.scrollEnabled = NO;//禁用 AAChartView 滚动效果
//    设置aaChartVie 的内容高度(content height)
//    self.aaChartView.contentHeight = chartViewHeight*2;
//    设置aaChartVie 的内容宽度(content  width)
//    self.aaChartView.contentWidth = chartViewWidth*2;
    [self.view addSubview:self.aaChartView];
    
    
    NSMutableArray *xAxisData = [[NSMutableArray alloc]init];
    NSMutableArray *data1 = [[NSMutableArray alloc]init];
    NSMutableArray *data2 = [[NSMutableArray alloc]init];
    
//    var xAxisData = [];
//    var data1 = [];
//    var data2 = [];
//    for (var i = 0; i < 100; i++) {
//        xAxisData.push('类目' + i);
//        data1.push((Math.sin(i / 5) * (i / 5 -10) + i / 6) * 5);
//        data2.push((Math.cos(i / 5) * (i / 5 -10) + i / 6) * 5);
//    }
    
    for (int i = 0; i < 100; i++) {
        [xAxisData addObject:[NSString stringWithFormat:@"类目%d",i]];
        [data1 addObject:@((sin(i / 5) * (i / 5 -10) + i / 6) * 5)];
        [data2 addObject:@((cos(i / 5) * (i / 5 -10) + i / 6) * 5)];
    }
    
    //设置 AAChartView 的背景色是否为透明
    self.aaChartView.isClearBackgroundColor = YES;
    
    self.aaChartModel= AAObject(AAChartModel)
    .chartTypeSet(chartType)//图表类型
    .titleSet(@"")//图表主标题
    .subtitleSet(@"")//图表副标题
    .yAxisLineWidthSet(@0)//Y轴轴线线宽为0即是隐藏Y轴轴线
    .colorsThemeSet(@[@"#fe117c",@"#ffc069",@"#06caf4",@"#7dffc0"])//设置主体颜色数组
    .yAxisTitleSet(@"")//设置 Y 轴标题
    .tooltipValueSuffixSet(@"℃")//设置浮动提示框单位后缀
    .backgroundColorSet(@"#4b2b7f")
    .yAxisGridLineWidthSet(@0)//y轴横向分割线宽度为0(即是隐藏分割线)
    .seriesSet(@[
                 AAObject(AASeriesElement)
                 .nameSet(@"2017")
                 .dataSet(@[@7.0, @6.9, @9.5, @14.5, @18.2, @21.5, @25.2, @26.5, @23.3, @18.3, @13.9, @9.6]),
                 AAObject(AASeriesElement)
                 .nameSet(@"2018")
                 .dataSet(@[@0.2, @0.8, @5.7, @11.3, @17.0, @22.0, @24.8, @24.1, @20.1, @14.1, @8.6, @2.5]),
                 AAObject(AASeriesElement)
                 .nameSet(@"2019")
                 .dataSet(@[@0.9, @0.6, @3.5, @8.4, @13.5, @17.0, @18.6, @17.9, @14.3, @9.0, @3.9, @1.0])
                 .visibleSet(false),//当前序列数据初始化时是否显示
                 AAObject(AASeriesElement)
                 .nameSet(@"2020")
                 .dataSet(@[@3.9, @4.2, @5.7, @8.5, @11.9, @15.2, @17.0, @16.6, @14.2, @10.3, @6.6, @4.8])
                 .visibleSet(false),//当前序列数据初始化时是否显示
                 ]
               );
    [self configureTheStyleForDifferentTypeChart];//为不同类型图表设置样式
    
    /*配置 Y 轴标注线,解开注释,即可查看添加标注线之后的图表效果(NOTE:必须设置 Y 轴可见)*/
    //    [self configureTheYAxisPlotLineForAAChartView];
    
    [self.aaChartView aa_drawChartWithChartModel:_aaChartModel];
}

/**
 *   图表 Y 轴标示线的设置
 *   标示线设置作为图表一项基础功能,用于对图表的基本数据水平均线进行标注
 *   虽然不太常被使用,但我们仍然提供了此功能的完整接口,以便于有特殊需求的用户使用
 *   解除👆上面的设置 Y 轴标注线的已被注释代码,,运行程序,即可查看实际工程效果以酌情选择
 *
 **/
- (void)configureTheYAxisPlotLineForAAChartView {
    _aaChartModel
    .yAxisMaxSet(@(21))//Y轴最大值
    .yAxisMinSet(@(1))//Y轴最小值
    .yAxisAllowDecimalsSet(NO)//是否允许Y轴坐标值小数
    .yAxisTickPositionsSet(@[@(0),@(25),@(50),@(75),@(100)])//指定y轴坐标
    .yAxisPlotLinesSet(@[
                         AAObject(AAPlotLinesElement)
                         .colorSet(@"#F05353")//颜色值(16进制)
                         .dashStyleSet(AALineDashSyleTypeLongDashDot)//样式：Dash,Dot,Solid等,默认Solid
                         .widthSet(@(1)) //标示线粗细
                         .valueSet(@(20)) //所在位置
                         .zIndexSet(@(1)) //层叠,标示线在图表中显示的层叠级别，值越大，显示越向前
                         .labelSet(@{@"text":@"标示线1",@"x":@(0),@"style":@{@"color":@"#33bdfd"}})/*这里其实也可以像AAPlotLinesElement这样定义个对象来赋值（偷点懒直接用了字典，最会终转为js代码，可参考https://www.hcharts.cn/docs/basic-plotLines来写字典）*/
                         ,AAObject(AAPlotLinesElement)
                         .colorSet(@"#33BDFD")
                         .dashStyleSet(AALineDashSyleTypeLongDashDot)
                         .widthSet(@(1))
                         .valueSet(@(40))
                         .labelSet(@{@"text":@"标示线2",@"x":@(0),@"style":@{@"color":@"#33bdfd"}})
                         ,AAObject(AAPlotLinesElement)
                         .colorSet(@"#ADFF2F")
                         .dashStyleSet(AALineDashSyleTypeLongDashDot)
                         .widthSet(@(1))
                         .valueSet(@(60))
                         .labelSet(@{@"text":@"标示线3",@"x":@(0),@"style":@{@"color":@"#33bdfd"}})
                         ]
                   );
}

- (void)configureTheStyleForDifferentTypeChart {
    if (self.chartType == SecondeViewControllerChartTypeColumn
        || self.chartType == SecondeViewControllerChartTypeBar) {
        _aaChartModel.categories = @[@"Java", @"Swift", @"Python", @"Ruby", @"PHP", @"Go", @"C", @"C#", @"C++", @"Perl", @"R", @"MATLAB", @"SQL"];//设置 X 轴坐标文字内容
        _aaChartModel.animationType = AAChartAnimationBounce;//图形的渲染动画为弹性动画
        _aaChartModel.yAxisTitle = @"";
        _aaChartModel.animationDuration = @1200;//图形渲染动画时长为1200毫秒
     
       // _aaChartModel.xAxisTickInterval = @3;//设置 X轴坐标点的间隔数,默认是1(手机端的屏幕较为狭窄, 如果X轴坐标点过多,文字过于密集的时候可以设置此属性值,用户的密集恐惧症将得到有效治疗😝)
    } else if (self.chartType == SecondeViewControllerChartTypeArea
               || self.chartType == SecondeViewControllerChartTypeAreaspline) {

        _aaChartModel.symbolStyle = AAChartSymbolStyleTypeInnerBlank;//设置折线连接点样式为:内部白色
        _aaChartModel.gradientColorEnabled = true;//启用渐变色
        _aaChartModel.animationType = AAChartAnimationEaseOutQuart;//图形的渲染动画为 EaseOutQuart 动画
        _aaChartModel.xAxisCrosshairWidth = @0.9;//Zero width to disable crosshair by default
        _aaChartModel.xAxisCrosshairColor = @"#FFE4C4";//(浓汤)乳脂,番茄色准星线
        _aaChartModel.xAxisCrosshairDashStyleType = AALineDashSyleTypeLongDashDot;
        if (self.chartType == SecondeViewControllerChartTypeArea) {
            _aaChartModel.categories = @[@"Java", @"Swift", @"Python", @"Ruby", @"PHP", @"Go", @"C", @"C#", @"C++", @"Perl", @"R", @"MATLAB", @"SQL"];//设置 X 轴坐标文字内容
        } else if (self.chartType == SecondeViewControllerChartTypeAreaspline) {
            _aaChartModel.series =@[
                                    AAObject(AASeriesElement)
                                    .nameSet(@"2017")
                                    .fillOpacitySet(@0.3)
                                    .dataSet(@[@2.73, @21.3, @41.6, @17.2, @19.9, @1.60, @2.10, @2.54, @2.78, @3.62, @4.41, @4.09, @3.83, @4.47, @4.20, @3.94, @3.80, @3.58, @3.19, @4.30, @3.69, @3.52, @3.02, @3.30]),
                                    AAObject(AASeriesElement)
                                    .nameSet(@"2018")
                                    .dataSet(@[@1.51, @28.7, @0.94, @1.44, @18.6, @1.63, @1.56, @1.91, @2.45, @3.87, @3.24, @4.90, @4.61, @4.10, @4.17, @3.85, @4.17, @3.46, @3.46, @3.55, @3.50, @4.13, @2.58, @2.28]),
                                    AAObject(AASeriesElement)
                                    .nameSet(@"2019")
                                    .dataSet(@[@1.33, @4.68, @1.31, @1.10, @13.9, @1.10, @1.16, @1.67, @2.64, @2.86, @3.00, @3.21, @4.14, @4.07, @3.68, @3.11, @3.41, @3.25, @3.32, @3.07, @3.92, @3.05, @2.18, @3.24]),
                                    AAObject(AASeriesElement)
                                    .nameSet(@"2020")
                                    .dataSet(@[@3.23, @3.15, @2.90, @1.81, @2.11, @2.43, @5.59, @3.09, @4.09, @6.14, @5.33, @6.05, @5.71, @6.22, @6.56, @4.75, @5.27, @6.02, @5.22, @5.77, @6.19, @5.68, @4.33, @5.48]),
                                    ];
        }
    } else if (self.chartType == SecondeViewControllerChartTypeLine
               || self.chartType == SecondeViewControllerChartTypeSpline) {
        _aaChartModel.symbolStyle = AAChartSymbolStyleTypeBorderBlank;//设置折线连接点样式为:边缘白色
        _aaChartModel.xAxisCrosshairWidth = @1;//Zero width to disable crosshair by default
        _aaChartModel.xAxisCrosshairColor = @"#778899";//浅石板灰准星线
        _aaChartModel.xAxisCrosshairDashStyleType = AALineDashSyleTypeLongDashDotDot;
        if (self.chartType == SecondeViewControllerChartTypeLine) {
            _aaChartModel.categories = @[@"Java", @"Swift", @"Python", @"Ruby", @"PHP", @"Go", @"C", @"C#", @"C++", @"Perl", @"R", @"MATLAB", @"SQL"];//设置 X 轴坐标文字内容
        } else if (self.chartType == SecondeViewControllerChartTypeSpline) {
            _aaChartModel.markerRadius = @8;
            _aaChartModel.series = @[
                                     AAObject(AASeriesElement)
                                     .nameSet(@"2017")
                                     .lineWidthSet(@5)
                                     .dataSet(@[@50, @320, @230, @370, @230, @400,]),
                                     AAObject(AASeriesElement)
                                     .nameSet(@"2018")
                                     .lineWidthSet(@5)
                                     .dataSet(@[@80, @390, @210, @340, @240, @350,]),
                                     AAObject(AASeriesElement)
                                     .nameSet(@"2019")
                                     .lineWidthSet(@5)
                                     .dataSet(@[@100, @370, @180, @280, @260, @300,]),
                                     AAObject(AASeriesElement)
                                     .nameSet(@"2020")
                                     .lineWidthSet(@5)
                                     .dataSet(@[@130, @350, @160, @310, @250, @268,]),
                                     ];        }
        
    } else if (self.chartType == SecondeViewControllerChartTypeStepLine
               || self.chartType == SecondeViewControllerChartTypeStepArea) {
        _aaChartModel.yAxisVisible = false;
        _aaChartModel.symbolStyle = (self.chartType == SecondeViewControllerChartTypeStepLine) ? AAChartSymbolStyleTypeBorderBlank : nil ;
        _aaChartModel.gradientColorEnabled = (self.chartType == SecondeViewControllerChartTypeStepArea) ? true : false ;
        _aaChartModel.series = @[
                                 AAObject(AASeriesElement)
                                 .nameSet(@"Berlin")
                                 .dataSet(@[@149.9, @171.5, @106.4, @129.2, @144.0, @176.0, @135.6, @188.5, @276.4, @214.1, @95.6, @54.4])
                                 .stepSet(@(true))//设置折线样式为直方折线,连接点位置默认靠左👈
                                 ,
                                 AAObject(AASeriesElement)
                                 .nameSet(@"New York")
                                 .dataSet(@[@83.6, @78.8, @188.5, @93.4, @106.0, @84.5, @105.0, @104.3, @131.2, @153.5, @226.6, @192.3])
                                 .stepSet(@(true))//设置折线样式为直方折线,连接点位置默认靠左👈
                                 ,
                                 AAObject(AASeriesElement)
                                 .nameSet(@"Tokyo")
                                 .dataSet(@[@48.9, @38.8, @19.3, @41.4, @47.0, @28.3, @59.0, @69.6, @52.4, @65.2, @53.3, @72.2])
                                 .stepSet(@(true))//设置折线样式为直方折线,连接点位置默认靠左👈
                                 ,
                                 ];
    }
}

- (NSArray *)configureTheRandomColorArray {
    NSMutableArray *colorStringArr = [[NSMutableArray alloc]init];
    for (int i=0; i<5; i++) {
        int R = (arc4random() % 256) ;
        int G = (arc4random() % 256) ;
        int B = (arc4random() % 256) ;
        NSString *colorStr = [NSString stringWithFormat:@"rgba(%d,%d,%d,0.9)",R,G,B];
        [colorStringArr addObject:colorStr];
    }
    return colorStringArr;
}

#pragma mark -- AAChartView delegate
- (void)AAChartViewDidFinishLoad {
    NSLog(@"🔥🔥🔥🔥🔥 AAChartView content did finish load!!!");
}

- (void)setUpTheSegmentedControls{
    
    NSArray *segmentedArray;
    NSArray *typeLabelNameArr;
    
    if (self.chartType == SecondeViewControllerChartTypeColumn
        ||self.chartType == SecondeViewControllerChartTypeBar) {
        segmentedArray = @[@[@"No stacking",
                             @"Normal stacking",
                             @"Percent stacking"],
                           @[@"Square corners",
                             @"Rounded corners",
                             @"Wedge"],
                           ];
        typeLabelNameArr = @[@"Stacking type selection",
                             @"Corners Style type selection"];
    } else {
        segmentedArray = @[@[@"No stacking",
                             @"Normal stacking",
                             @"Percent stacking"],
                           @[@"Circle",
                             @"Square",
                             @"Diamond",
                             @"Triangle",
                             @"Triangle-down"]
                           ];
        typeLabelNameArr = @[@"Stacking type selection",
                             @"Chart symbol type selection"];
    }
    
    for (int i=0; i<segmentedArray.count; i++) {
        
        UISegmentedControl * segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray[i]];
        segmentedControl.frame = CGRectMake(20, 40*i+(self.view.frame.size.height-145), self.view.frame.size.width-40, 20);
        segmentedControl.tintColor = [UIColor redColor];
//        segmentedControl.tintColor = [UIColor lightGrayColor];
        segmentedControl.selectedSegmentIndex = 0;
        segmentedControl.tag = i;
        [segmentedControl addTarget:self action:@selector(customsegmentedControlCellValueBeChanged:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:segmentedControl];
        
        UILabel *typeLabel = [[UILabel alloc]init];
        typeLabel.textColor = [UIColor lightGrayColor];
        typeLabel.frame =CGRectMake(20, 40*i+(self.view.frame.size.height-165), self.view.frame.size.width-40, 20);
        typeLabel.text = typeLabelNameArr[i];
        typeLabel.font = [UIFont systemFontOfSize:11.0f];
        [self.view addSubview:typeLabel];
        
    }
}

- (void)customsegmentedControlCellValueBeChanged:(UISegmentedControl *)segmentedControl {
    switch (segmentedControl.tag) {
        case 0: {
            NSArray *stackingArr = @[AAChartStackingTypeFalse,
                                     AAChartStackingTypeNormal,
                                     AAChartStackingTypePercent];
            self.aaChartModel.stacking = stackingArr[segmentedControl.selectedSegmentIndex];
        }
            break;
            
        case 1: {
            
            if (self.chartType == 0 || self.chartType == 1 ) {
                NSArray *borderRadiusArr = @[ @0, @10, @100 ];
                self.aaChartModel.borderRadius = borderRadiusArr[segmentedControl.selectedSegmentIndex];
            } else {
                
                NSArray *symbolArr = @[AAChartSymbolTypeCircle,
                                       AAChartSymbolTypeSquare,
                                       AAChartSymbolTypeDiamond,
                                       AAChartSymbolTypeTriangle,
                                       AAChartSymbolTypeTriangle_down];
                self.aaChartModel.symbol = symbolArr[segmentedControl.selectedSegmentIndex];
            }
        }
            break;
            
        default:
            break;
    }
    
    [self refreshTheChartView];
}

- (void)refreshTheChartView {
    //    self.aaChartModel.colorsTheme = [self configureTheRandomColorArray];//random colors theme, Just for fun!!!
    [self.aaChartView aa_refreshChartWithChartModel:self.aaChartModel];
}

- (void)setUpTheSwitchs {
    NSArray *nameArr;
    if (self.chartType == SecondeViewControllerChartTypeColumn
        ||self.chartType == SecondeViewControllerChartTypeBar) {
        nameArr = @[@"xAxisReversed",
                    @"yAxisReversed",
                    @"xAxisInverted",
                    @"Polarization",
                    @"DataLabelShow",];
    } else {
        nameArr = @[@"xReversed",
                    @"yReversed",
                    @"xAxisInverted",
                    @"Polarization",
                    @"DataShow",
                    @"HideMarker"];
    }
    
    CGFloat switchWidth = (self.view.frame.size.width-40)/nameArr.count;
    
    for (int i=0; i<nameArr.count; i++) {
        
        UISwitch * switchView = [[UISwitch alloc]init];
        switchView.frame = CGRectMake(switchWidth*i+20, self.view.frame.size.height-70, switchWidth, 20);
        //        switchView.backgroundColor = [UIColor blueColor];
//        switchView.onTintColor = [UIColor colorWithRed:0/255 green:191/255 blue:255/255 alpha:0.6];
        switchView.onTintColor = [self colorWithHexString:@"#FFDEAD"];
        switchView.thumbTintColor = [UIColor whiteColor];
        switchView.on = NO;
        switchView.tag = i;
        [switchView addTarget:self action:@selector(switchViewClicked:) forControlEvents:UIControlEventValueChanged];
        [self.view addSubview:switchView];
        
        UILabel *label = [[UILabel alloc]init];
        label.textColor = [UIColor lightGrayColor];
        label.numberOfLines = 0;
        label.frame = CGRectMake(switchWidth*i+20,  self.view.frame.size.height-40, switchWidth, 40);
        label.text = nameArr[i];
        label.font = [UIFont systemFontOfSize:8.0f];
        [self.view addSubview:label];
    }
}

- (void)switchViewClicked:(UISwitch *)switchView {
    switch (switchView.tag) {
        case 0:
            self.aaChartModel.xAxisReversed = switchView.on;
            break;
        case 1:
            self.aaChartModel.yAxisReversed = switchView.on;
            break;
        case 2:
            self.aaChartModel.inverted = switchView.on;
            break;
        case 3:
            self.aaChartModel.polar = switchView.on;
            break;
        case 4:
            self.aaChartModel.dataLabelEnabled = switchView.on;
            break;
        case 5:
            self.aaChartModel.markerRadius = switchView.on ? @0 : @5;
            break;
        default:
            break;
    }

    [self refreshTheChartView];
    
}

- (UIColor *) colorWithHexString: (NSString *)color {
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

@end
