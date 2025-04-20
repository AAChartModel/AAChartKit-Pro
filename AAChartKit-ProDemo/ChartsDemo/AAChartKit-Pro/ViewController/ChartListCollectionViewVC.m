#import "ChartListCollectionViewVC.h"
#import "ChartSampleProvider.h"
#import "ChartExampleCollectionViewCell.h" // 导入自定义 CollectionView Cell 的头文件
#import "AAChartKit.h" // 导入 AAChartKit 相关头文件

static NSString * const kChartSampleCollectionViewCellIdentifier = @"ChartSampleCollectionViewCell";
static NSString * const kGradientAnimationKey = @"gradientAnimation"; // 动画 Key

@interface ChartListCollectionViewVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CAAnimationDelegate> // 确保协议已声明
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<AAOptions *> *chartExamples;
@property (nonatomic, strong) CAGradientLayer *backgroundGradientLayer; // 添加渐变层属性
@property (nonatomic, strong) NSArray *gradientColorSets; // 存储多组渐变颜色
@property (nonatomic, assign) NSInteger currentGradientIndex; // 当前颜色组索引
@end

@implementation ChartListCollectionViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chartExamples = [ChartSampleProvider allProTypeSamples];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startGradientAnimation]; // 视图出现时启动动画
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.backgroundGradientLayer removeAnimationForKey:kGradientAnimationKey]; // 视图消失时移除动画
}

- (void)setupView {
    self.title = @"AAChartView 示例 (CollectionView)";

    // --- 初始化渐变颜色组 (更新为暗色调、商业风格) ---
    self.gradientColorSets = @[
        @[ // Set 1: Deep Blue -> Dark Slate Gray
            (id)[UIColor colorWithRed:0.1 green:0.2 blue:0.4 alpha:1.0].CGColor, // 深蓝
            (id)[UIColor colorWithRed:0.15 green:0.25 blue:0.35 alpha:1.0].CGColor,
            (id)[UIColor colorWithRed:0.2 green:0.3 blue:0.3 alpha:1.0].CGColor  // 暗灰蓝
        ],
        @[ // Set 2: Dark Slate Gray -> Dark Purple
            (id)[UIColor colorWithRed:0.2 green:0.3 blue:0.3 alpha:1.0].CGColor, // 暗灰蓝
            (id)[UIColor colorWithRed:0.25 green:0.2 blue:0.35 alpha:1.0].CGColor,
            (id)[UIColor colorWithRed:0.3 green:0.15 blue:0.4 alpha:1.0].CGColor // 暗紫
        ],
        @[ // Set 3: Dark Purple -> Deep Teal
            (id)[UIColor colorWithRed:0.3 green:0.15 blue:0.4 alpha:1.0].CGColor, // 暗紫
            (id)[UIColor colorWithRed:0.2 green:0.25 blue:0.4 alpha:1.0].CGColor,
            (id)[UIColor colorWithRed:0.1 green:0.3 blue:0.35 alpha:1.0].CGColor // 深青色
         ],
        @[ // Set 4: Deep Teal -> Back to Deep Blue
            (id)[UIColor colorWithRed:0.1 green:0.3 blue:0.35 alpha:1.0].CGColor, // 深青色
            (id)[UIColor colorWithRed:0.1 green:0.25 blue:0.4 alpha:1.0].CGColor,
            (id)[UIColor colorWithRed:0.1 green:0.2 blue:0.4 alpha:1.0].CGColor  // 深蓝
        ]
    ];
    self.currentGradientIndex = 0;
    // --- 渐变颜色组结束 ---

    // --- 添加渐变背景层 ---
    self.backgroundGradientLayer = [CAGradientLayer layer];
    self.backgroundGradientLayer.colors = self.gradientColorSets[self.currentGradientIndex]; // 设置初始颜色
    // 设置渐变方向 (从左上到右下)
    self.backgroundGradientLayer.startPoint = CGPointMake(0, 0);
    self.backgroundGradientLayer.endPoint = CGPointMake(1, 1);
    // 将渐变层添加到视图层级的最底层
    [self.view.layer insertSublayer:self.backgroundGradientLayer atIndex:0];
    // --- 渐变背景层结束 ---

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
    self.collectionView.backgroundColor = [UIColor clearColor]; // 设置 CollectionView 背景透明以显示渐变

    // 注册自定义单元格类
    [self.collectionView registerClass:[ChartExampleCollectionViewCell class] forCellWithReuseIdentifier:kChartSampleCollectionViewCellIdentifier];

    [self.view addSubview:self.collectionView]; // 确保 CollectionView 在渐变层之上

    // 设置 collectionView 约束
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    [NSLayoutConstraint activateConstraints:@[
        [self.collectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.collectionView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [self.collectionView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor]
    ]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    // 更新渐变层的 frame 以匹配视图边界
    self.backgroundGradientLayer.frame = self.view.bounds;
}

- (void)startGradientAnimation {
    // 如果动画已在运行，则先移除
    [self.backgroundGradientLayer removeAnimationForKey:kGradientAnimationKey];

    // 计算下一个颜色组的索引
    NSInteger nextIndex = (self.currentGradientIndex + 1) % self.gradientColorSets.count;

    // 创建颜色变化的 CABasicAnimation
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.duration = 5.0; // 每次渐变持续时间
    animation.fromValue = self.gradientColorSets[self.currentGradientIndex];
    animation.toValue = self.gradientColorSets[nextIndex];
    animation.fillMode = kCAFillModeForwards; // 动画结束后保持最终状态
    animation.removedOnCompletion = NO; // 动画结束后不自动移除
    animation.delegate = self; // 设置代理以在动画结束后触发下一次动画

    // 将动画添加到图层
    [self.backgroundGradientLayer addAnimation:animation forKey:kGradientAnimationKey];

    // 更新当前颜色索引
    self.currentGradientIndex = nextIndex;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag && [self.backgroundGradientLayer animationForKey:kGradientAnimationKey] == anim) {
         // 确保是因为动画正常完成而不是被手动移除
         // 从 presentationLayer 获取当前颜色值 (类型为 id)
         id currentColors = [self.backgroundGradientLayer.presentationLayer valueForKeyPath:@"colors"];
         // 检查类型是否为 NSArray
         if ([currentColors isKindOfClass:[NSArray class]]) {
             // 更新图层的实际 colors 属性为动画结束时的值
             self.backgroundGradientLayer.colors = (NSArray *)currentColors;
         } else {
             // 如果类型不匹配，可以记录一个错误或使用默认值
             NSLog(@"Warning: presentationLayer.colors was not an NSArray.");
             // 可以选择恢复为目标值，以防万一
             // self.backgroundGradientLayer.colors = self.gradientColorSets[self.currentGradientIndex];
         }

        // 移除旧动画（虽然设置了 removedOnCompletion = NO，但手动移除更清晰）
        [self.backgroundGradientLayer removeAnimationForKey:kGradientAnimationKey];
        // 延迟一小段时间后开始下一次动画，避免 CPU 占用过高
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             // 检查视图是否仍然可见
             if (self.view.window) {
                 [self startGradientAnimation];
             }
        });
    }
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
