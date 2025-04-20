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
    CGFloat minimumItemWidth = 400.0;
    CGFloat height = 420; // 保持之前设置的高度

    // 获取布局对象以访问间距设置
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    CGFloat sectionInsetHorizontal = flowLayout.sectionInset.left + flowLayout.sectionInset.right;
    CGFloat interitemSpacing = flowLayout.minimumInteritemSpacing;

    // 计算 collectionView 的可用宽度
    CGFloat availableWidth = collectionView.bounds.size.width - sectionInsetHorizontal;

    // 计算理论上可以放下的最大列数
    // (availableWidth + interitemSpacing) / (minimumItemWidth + interitemSpacing)
    // 加上一个 interitemSpacing 是因为 N 列之间有 N-1 个间距，可以看作每个 item 宽度加上一个间距
    int maxColumns = floor((availableWidth + interitemSpacing) / (minimumItemWidth + interitemSpacing));

    // 确保至少有一列
    int numberOfColumns = MAX(1, maxColumns);

    // 计算实际的总间距
    CGFloat totalSpacing = (numberOfColumns - 1) * interitemSpacing;

    // 计算最终的 item 宽度，均分可用宽度
    CGFloat itemWidth = floor((availableWidth - totalSpacing) / numberOfColumns);

    // 确保宽度不小于最小值 (虽然理论上按此计算不会小于，但可以加个保险)
    itemWidth = MAX(minimumItemWidth, itemWidth);

    return CGSizeMake(itemWidth, height);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected item at index: %ld", (long)indexPath.item);
    // 可以添加导航到详情页的逻辑
}

@end
