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
    // 设置最小行间距（垂直）和最小项间距（水平）为 3
    layout.minimumLineSpacing = 3; // 行间距
    layout.minimumInteritemSpacing = 3; // 项间距
    // 调整 section 内边距以匹配间距
    layout.sectionInset = UIEdgeInsetsMake(3, 0, 3, 0); // section 内边距 (上下调整为 3)

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

#pragma mark - Layout Invalidation on Size Change

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    // 在过渡动画期间或之后使布局失效，以确保使用新的尺寸重新计算
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        // 可选：在动画期间执行的操作
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        // 确保在过渡完成后布局是最新的
        [self.collectionView.collectionViewLayout invalidateLayout];
        // 可选：如果数据也可能因尺寸变化而变化，则调用 [self.collectionView reloadData];
    }];

    // 如果不关心平滑过渡，或者需要在过渡开始时立即触发（可能导致跳跃），可以取消注释下面这行：
    // [self.collectionView.collectionViewLayout invalidateLayout];
}

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

    // 获取布局对象以访问间距和内边距设置
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)collectionViewLayout;
    // 注意：这里 sectionInsetHorizontal 的计算现在使用更新后的 sectionInset
    CGFloat sectionInsetHorizontal = flowLayout.sectionInset.left + flowLayout.sectionInset.right;
    // 使用布局中定义的最小间距进行计算
    CGFloat interitemSpacing = flowLayout.minimumInteritemSpacing;

    // 计算 collectionView 的可用宽度
    CGFloat availableWidth = collectionView.bounds.size.width - sectionInsetHorizontal;

    // --- 计算合适的列数 ---
    // 我们希望找到最大列数 N，使得 N 个项目加上 (N-1) 个间距后，每个项目的宽度至少为 minimumItemWidth。
    // N * itemWidth + (N-1) * spacing = availableWidth
    // N * itemWidth >= N * minimumItemWidth
    // availableWidth - (N-1) * spacing >= N * minimumItemWidth
    // availableWidth + spacing >= N * (minimumItemWidth + spacing)
    // N <= (availableWidth + spacing) / (minimumItemWidth + spacing)
    // 取 floor 得到最大整数列数 N

    int numberOfColumns = floor((availableWidth + interitemSpacing) / (minimumItemWidth + interitemSpacing));

    // 确保至少有一列
    numberOfColumns = MAX(1, numberOfColumns);

    // --- 计算最终的项宽度 ---
    // 基于确定的列数和最小间距，均分可用宽度
    CGFloat totalSpacing = (numberOfColumns - 1) * interitemSpacing;
    CGFloat widthAvailableForItems = availableWidth - totalSpacing;
    CGFloat itemWidth = floor(widthAvailableForItems / numberOfColumns);

    // 在可用宽度不足以放下单个 minimumItemWidth 的极端情况下，itemWidth 会小于 minimumItemWidth。
    // 在这种情况下，项目宽度就是全部可用宽度。
    if (availableWidth < minimumItemWidth) {
         itemWidth = availableWidth;
    } else {
        // 确保计算出的宽度不小于最小值（在有足够空间的情况下）
        itemWidth = MAX(minimumItemWidth, itemWidth);
    }

    return CGSizeMake(itemWidth, height);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Selected item at index: %ld", (long)indexPath.item);
    // 可以添加导航到详情页的逻辑
}

@end
