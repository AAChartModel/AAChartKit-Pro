#import "ChartListCollectionViewVC.h"
#import "ChartSampleProvider.h"
#import "ChartExampleCollectionViewCell.h" // 导入自定义 CollectionView Cell 的头文件
#import "AAChartKit.h" // 导入 AAChartKit 相关头文件
#import <SpriteKit/SpriteKit.h> // 导入 SpriteKit
#import "BackgroundEffectsScene.h" // 导入自定义场景

static NSString * const kChartSampleCollectionViewCellIdentifier = @"ChartSampleCollectionViewCell";

@interface ChartListCollectionViewVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> // 确保协议已声明
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<AAOptions *> *chartExamples;

// 添加 SKView 属性
@property (nonatomic, strong) SKView *skView;
@property (nonatomic, strong) BackgroundEffectsScene *backgroundScene;

@end

@implementation ChartListCollectionViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chartExamples = [ChartSampleProvider allProTypeSamples];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // 可以根据需要暂停/恢复 SKView
    self.skView.paused = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // 暂停 SKView 以节省资源
    self.skView.paused = YES;
}

- (void)setupView {
    self.title = @"AAChartView 示例 (CollectionView)";
    self.view.backgroundColor = [UIColor blackColor]; // 设置一个基础背景色

    // --- 设置 SpriteKit 背景 ---
    self.skView = [[SKView alloc] initWithFrame:self.view.bounds];
    self.skView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view insertSubview:self.skView atIndex:0]; // 插入到底层

    // 创建并配置场景
    self.backgroundScene = [BackgroundEffectsScene sceneWithSize:self.skView.bounds.size];
    self.backgroundScene.scaleMode = SKSceneScaleModeResizeFill; // 场景缩放以填充视图

    //呈现场景
    [self.skView presentScene:self.backgroundScene];
    // --- SpriteKit 背景结束 ---

    // 初始化布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 3; // 行间距
    layout.minimumInteritemSpacing = 3; // 项间距
    layout.sectionInset = UIEdgeInsetsMake(3, 0, 3, 0); // section 内边距 (上下调整为 3)

    // 初始化并配置 collectionView
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor clearColor]; // 确保 CollectionView 背景透明

    // 注册自定义单元格类
    [self.collectionView registerClass:[ChartExampleCollectionViewCell class] forCellWithReuseIdentifier:kChartSampleCollectionViewCellIdentifier];

    [self.view addSubview:self.collectionView]; // CollectionView 在 SKView 之上

    // 设置 collectionView 和 SKView 约束
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        // SKView 填充整个视图
        [self.skView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [self.skView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.skView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.skView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor],

        // CollectionView 填充安全区域
        [self.collectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
    ]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // 更新 SKView 的大小时，场景会自动调整（因为 scaleMode 设置为 ResizeFill）
    // 如果需要手动调整场景内的元素，可以在 BackgroundEffectsScene 的 didChangeSize: 中处理
}

- (AAOptions *)optionsItemsWithoutAnimation:(AAOptions *)chartOptions {
    // 禁用图表动画
    if (chartOptions.chart) {
        chartOptions.chart.animation = (id)kCFBooleanFalse; // 使用 (id)kCFBooleanFalse 禁用动画
    } else {
        chartOptions.chart = AAChart.new;
        chartOptions.chart.animation = (id)kCFBooleanFalse;
    }

    // --- 设置文本颜色为白色 ---
    // 标题颜色
    if (!chartOptions.title) {
        chartOptions.title = AATitle.new;
    }
    if (!chartOptions.title.style) {
        chartOptions.title.style = AAStyle.new;
    }
    chartOptions.title.style.color = @"#FFFFFF"; // 白色

    // 副标题颜色
    if (!chartOptions.subtitle) {
        chartOptions.subtitle = AASubtitle.new;
    }
    if (!chartOptions.subtitle.style) {
        chartOptions.subtitle.style = AAStyle.new;
    }
    chartOptions.subtitle.style.color = @"#FFFFFF"; // 白色

    // Y 轴标签颜色
    if (!chartOptions.yAxis) {
        chartOptions.yAxis = AAYAxis.new; // 如果 yAxis 不存在，创建一个新的
    }
   
    // 如果有多个 Y 轴，需要遍历设置
    if ([chartOptions.yAxis isKindOfClass:[NSArray class]]) {
        NSArray *yAxes = (NSArray *)chartOptions.yAxis;
        for (AAYAxis *axis in yAxes) {
            if ([axis isKindOfClass:[AAYAxis class]]) {
                if (!axis.labels) axis.labels = AALabels.new;
                if (!axis.labels.style) axis.labels.style = AAStyle.new;
                axis.labels.style.color = @"#FFFFFF";
            }
        }
    } else {
        if (!chartOptions.yAxis.labels) {
            chartOptions.yAxis.labels = AALabels.new;
        }
        if (!chartOptions.yAxis.labels.style) {
            chartOptions.yAxis.labels.style = AAStyle.new;
        }
        chartOptions.yAxis.labels.style.color = @"#FFFFFF"; // 白色
    }

    // X 轴标签颜色
    if (!chartOptions.xAxis) {
        chartOptions.xAxis = AAXAxis.new; // 如果 xAxis 不存在，创建一个新的
    }
  
    // 如果有多个 X 轴，需要遍历设置 (虽然不常见)
    if ([chartOptions.xAxis isKindOfClass:[NSArray class]]) {
         NSArray *xAxes = (NSArray *)chartOptions.xAxis;
         for (AAXAxis *axis in xAxes) {
                if ([axis isKindOfClass:[AAXAxis class]]) {
                    if (!axis.labels) axis.labels = AALabels.new;
                    if (!axis.labels.style) axis.labels.style = AAStyle.new;
                    axis.labels.style.color = @"#FFFFFF";
                }
         }
    } else {
        if (!chartOptions.xAxis.labels) {
            chartOptions.xAxis.labels = AALabels.new;
        }
        if (!chartOptions.xAxis.labels.style) {
            chartOptions.xAxis.labels.style = AAStyle.new;
        }
        chartOptions.xAxis.labels.style.color = @"#FFFFFF"; // 白色
    }

    // 图例标签颜色
    if (!chartOptions.legend) {
        chartOptions.legend = AALegend.new;
    }
    if (!chartOptions.legend.itemStyle) {
        chartOptions.legend.itemStyle = AAItemStyle.new;
    }
    chartOptions.legend.itemStyle.color = @"#FFFFFF"; // 白色
    // --- 文本颜色设置结束 ---

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

#pragma mark - Layout Invalidation on Size Change

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];

    // 在过渡动画期间或之后使布局失效，以确保使用新的尺寸重新计算
    [coordinator animateAlongsideTransition:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        // 可选：在动画期间执行的操作
    } completion:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        // 确保在过渡完成后布局是最新的
        [self.collectionView.collectionViewLayout invalidateLayout];
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.chartExamples.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    // 使用自定义单元格标识符出列
    ChartExampleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kChartSampleCollectionViewCellIdentifier forIndexPath:indexPath];

    // --- 确保 Cell 背景透明 ---
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor]; // 同时确保 contentView 也透明
    // --- Cell 背景透明设置结束 ---

    // 配置自定义单元格
    AAOptions *chartOptions = self.chartExamples[indexPath.row];
    // 禁用动画
    AAOptions *chartOptionsWithoutAnimation = [self optionsItemsWithoutAnimation:chartOptions];

    [cell setChartOptions:chartOptionsWithoutAnimation completion:^(AAChartView *aaChartView) {
        // 这里可以处理图表加载完成后的回调
        NSLog(@"Chart loaded successfully in cell: %ld", (long)indexPath.item);
        // --- 确保 AAChartView 背景也透明 ---
        // 如果 AAChartView 默认背景不透明，也需要设置
        aaChartView.backgroundColor = [UIColor clearColor];
        // --- AAChartView 背景设置结束 ---
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
    CGFloat sectionInsetHorizontal = flowLayout.sectionInset.left + flowLayout.sectionInset.right;
    CGFloat interitemSpacing = flowLayout.minimumInteritemSpacing;

    CGFloat availableWidth = collectionView.bounds.size.width - sectionInsetHorizontal;

    int numberOfColumns = floor((availableWidth + interitemSpacing) / (minimumItemWidth + interitemSpacing));
    numberOfColumns = MAX(1, numberOfColumns);

    CGFloat totalSpacing = (numberOfColumns - 1) * interitemSpacing;
    CGFloat widthAvailableForItems = availableWidth - totalSpacing;
    CGFloat itemWidth = floor(widthAvailableForItems / numberOfColumns);

    if (availableWidth < minimumItemWidth) {
         itemWidth = availableWidth;
    } else {
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
