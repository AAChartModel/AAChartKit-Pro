#import "ChartListCollectionViewVC.h"
#import "ChartSampleProvider.h"
#import "ChartExampleCollectionViewCell.h" // 导入自定义 CollectionView Cell 的头文件
#import "AAChartKit.h" // 导入 AAChartKit 相关头文件

static NSString * const kChartSampleCollectionViewCellIdentifier = @"ChartSampleCollectionViewCell";

@interface ChartListCollectionViewVC ()
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<AAOptions *> *chartExamples;
@end

@implementation ChartListCollectionViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chartExamples = [ChartSampleProvider allProTypeSamples];
    [self setupView];
}

- (void)setupView {
    self.title = @"AAChartView 示例 (CollectionView)";
    self.view.backgroundColor = [UIColor whiteColor];

    // 初始化布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    // 可以在这里设置滚动方向、item 大小、间距等，或者通过 delegate 方法设置
    layout.minimumLineSpacing = 10; // 行间距
    layout.minimumInteritemSpacing = 10; // 项间距 (单列时无效)
    layout.sectionInset = UIEdgeInsetsMake(10, 0, 10, 0); // section 内边距

    // 初始化并配置 collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0]; // 设置背景色以匹配 Cell 背景

    // 注册自定义单元格类
    [self.collectionView registerClass:[ChartExampleCollectionViewCell class] forCellWithReuseIdentifier:kChartSampleCollectionViewCellIdentifier];

    [self.view addSubview:self.collectionView];

    // 设置 collectionView 约束
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.collectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
    ]];
}

// --- 动画禁用方法 (与 TableView 版本相同) ---
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
// --- 动画禁用方法结束 ---


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.chartExamples.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 使用自定义单元格标识符出列
    ChartExampleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kChartSampleCollectionViewCellIdentifier forIndexPath:indexPath];

    // 配置自定义单元格
    AAOptions *chartOptions = self.chartExamples[indexPath.row];
    // 禁用动画
    AAOptions *chartOptionsWithoutAnimation = [self optionsItemsWithoutAnimation:chartOptions];

    [cell setChartOptions:chartOptionsWithoutAnimation completion:^(AAChartView *aaChartView) {
        // 这里可以处理图表加载完成后的回调
        NSLog(@"Chart loaded successfully in cell: %ld", (long)indexPath.item);
    }];

    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

// 设置每个 item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat padding = 16 * 2; // 左右边距总和 (与 Cell 内部 shadowView 的边距一致)
    CGFloat width = collectionView.bounds.size.width - padding;
    CGFloat height = 420; // 设置单元格高度 (与原 TableViewCell 一致或按需调整)
    return CGSizeMake(width, height);
}

// 可以根据需要实现其他 UICollectionViewDelegateFlowLayout 方法，例如 minimumLineSpacing, minimumInteritemSpacing, sectionInset 等，
// 如果在初始化 layout 时未设置，或者需要动态调整。

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected item at index: %ld", (long)indexPath.item);
    // 可以添加导航到详情页的逻辑
}

@end
