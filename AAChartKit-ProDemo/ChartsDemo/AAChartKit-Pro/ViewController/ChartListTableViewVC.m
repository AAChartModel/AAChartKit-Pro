#import "ChartListTableViewVC.h"
#import "ChartSampleProvider.h"
#import "ChartExampleCell.h" // 导入自定义 Cell 的头文件
#import "AAChartKit.h" // 导入 AAChartKit 相关头文件

static NSString * const kChartSampleTableViewCellIdentifier = @"ChartSampleTableViewCell";

@interface ChartListTableViewVC ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<AAOptions *> *chartExamples;
@end

@implementation ChartListTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chartExamples = [ChartSampleProvider allProTypeSamples];
    [self setupView];
}

- (void)setupView {
    self.title = @"AAChartView 示例";
    self.view.backgroundColor = [UIColor whiteColor];

    // 初始化并配置tableView
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    // 注册自定义单元格类
    [self.tableView registerClass:[ChartExampleCell class] forCellReuseIdentifier:kChartSampleTableViewCellIdentifier];

    self.tableView.tableFooterView = [[UIView alloc] init]; // 去除空行的分割线

    [self.view addSubview:self.tableView];

    // 设置tableView约束
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
    ]];
}

- (AAOptions *)optionsItemsWithoutAnimation:(AAOptions *)chartOptions {
    // 禁用图表动画
    if (chartOptions.chart) {
        chartOptions.chart.animation = (id)kCFBooleanFalse; // 使用 (id)kCFBooleanFalse 禁用动画
    } else {
        chartOptions.chart = AAChart.new;
        chartOptions.chart.animation = (id)kCFBooleanFalse;
    }
    
    AAOptions *options = [self configurePlotOptionsSeriesAnimation:chartOptions];
    return options;
}


- (AAOptions *)configurePlotOptionsSeriesAnimation:(AAOptions *)aaOptions {
    if (!aaOptions.plotOptions) {
        aaOptions.plotOptions = AAPlotOptions.new;
    }
    if (!aaOptions.plotOptions.series) {
        aaOptions.plotOptions.series = AASeries.new;
    }
    
    // 禁用 Series 动画
    aaOptions.plotOptions.series.animation = (id)kCFBooleanFalse; // 使用 (id)kCFBooleanFalse 禁用动画
    return aaOptions;
}


#pragma mark - UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 300; // 设置单元格高度
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.chartExamples.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // 使用自定义单元格标识符出列
    ChartExampleCell *cell = [tableView dequeueReusableCellWithIdentifier:kChartSampleTableViewCellIdentifier forIndexPath:indexPath];

    // 配置自定义单元格
    AAOptions *chartOptions = self.chartExamples[indexPath.row];
    // 禁用动画
    AAOptions *chartOptionsWithoutAnimation = [self optionsItemsWithoutAnimation:chartOptions];

    [cell setChartOptions:chartOptionsWithoutAnimation completion:^(AAChartView *aaChartView) {
        // 这里可以处理图表加载完成后的回调
        NSLog(@"Chart loaded successfully");
    }];

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    // 可以添加导航到详情页的逻辑
}

@end
