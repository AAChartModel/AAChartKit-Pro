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

// 添加模式切换属性
@property (nonatomic, assign) BOOL isNightMode;
@property (nonatomic, strong) UISwitch *modeSwitch;

@end

@implementation ChartListCollectionViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isNightMode = YES; // 默认启动为夜间模式
    self.chartExamples = [ChartSampleProvider allProTypeSamples];
    [self setupView];
    [self setupNavigationBar]; // 设置导航栏开关
    [self applyCurrentMode]; // 应用初始模式
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
    // 背景色将在 applyCurrentMode 中设置

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

- (void)setupNavigationBar {
    self.modeSwitch = [[UISwitch alloc] init];
    [self.modeSwitch addTarget:self action:@selector(toggleMode:) forControlEvents:UIControlEventValueChanged];
    self.modeSwitch.on = self.isNightMode; // 设置开关初始状态

    UIBarButtonItem *switchItem = [[UIBarButtonItem alloc] initWithCustomView:self.modeSwitch];
    self.navigationItem.rightBarButtonItem = switchItem;
}

- (void)toggleMode:(UISwitch *)sender {
    self.isNightMode = sender.isOn;
    [self applyCurrentMode];
}

- (void)applyCurrentMode {
    NSLog(@"Applying mode: %@", self.isNightMode ? @"Night" : @"Day"); // 添加日志确认调用

    // 1. 更新视图背景色
    self.view.backgroundColor = self.isNightMode ? [UIColor blackColor] : [UIColor whiteColor];

    // 2. 更新 CollectionView 背景色
    self.collectionView.backgroundColor = self.isNightMode ? [UIColor clearColor] : [UIColor clearColor];

    // 3. (可选) 更新 SKScene 外观
    // 例如: [self.backgroundScene updateForNightMode:self.isNightMode];
    // 这需要在 BackgroundEffectsScene 中实现相应的方法
    // 如果 SKView 不透明且覆盖了 vc.view，这里的背景色变化可能看不到

    // 4. 重新加载 CollectionView 以应用图表颜色和单元格外观更改
    [self.collectionView reloadData];

    // 5. (可选) 更新导航栏外观
    UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
    if (self.isNightMode) {
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor = [UIColor blackColor]; // 或者其他深色
        appearance.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        self.navigationController.navigationBar.barStyle = UIBarStyleBlack; // 状态栏文字变白
    } else {
        [appearance configureWithDefaultBackground]; // 或者 configureWithOpaqueBackground 并设置白色背景
        appearance.backgroundColor = [UIColor whiteColor];
        appearance.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
        self.navigationController.navigationBar.barStyle = UIBarStyleDefault; // 状态栏文字变黑
    }
    self.navigationController.navigationBar.standardAppearance = appearance;
    self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    self.navigationController.navigationBar.tintColor = self.isNightMode ? [UIColor whiteColor] : [UIColor blackColor]; // 按钮颜色
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

    // --- 根据模式设置文本颜色 ---
    NSString *textColor = self.isNightMode ? @"#FFFFFF" : @"#333333"; // 白色或深灰色

    // 标题颜色
    if (!chartOptions.title) chartOptions.title = AATitle.new;
    if (!chartOptions.title.style) chartOptions.title.style = AAStyle.new;
    chartOptions.title.style.color = textColor;

    // 副标题颜色
    if (!chartOptions.subtitle) chartOptions.subtitle = AASubtitle.new;
    if (!chartOptions.subtitle.style) chartOptions.subtitle.style = AAStyle.new;
    chartOptions.subtitle.style.color = textColor;

    // Y 轴标签颜色
    if (!chartOptions.yAxis) chartOptions.yAxis = AAYAxis.new;
    if ([chartOptions.yAxis isKindOfClass:[NSArray class]]) {
        NSArray *yAxes = (NSArray *)chartOptions.yAxis;
        for (AAYAxis *axis in yAxes) {
            if ([axis isKindOfClass:[AAYAxis class]]) {
                if (!axis.labels) axis.labels = AALabels.new;
                if (!axis.labels.style) axis.labels.style = AAStyle.new;
                axis.labels.style.color = textColor;
            }
        }
    } else {
        if (!chartOptions.yAxis.labels) chartOptions.yAxis.labels = AALabels.new;
        if (!chartOptions.yAxis.labels.style) chartOptions.yAxis.labels.style = AAStyle.new;
        chartOptions.yAxis.labels.style.color = textColor;
    }

    // X 轴标签颜色
    if (!chartOptions.xAxis) chartOptions.xAxis = AAXAxis.new;
    if ([chartOptions.xAxis isKindOfClass:[NSArray class]]) {
         NSArray *xAxes = (NSArray *)chartOptions.xAxis;
         for (AAXAxis *axis in xAxes) {
                if ([axis isKindOfClass:[AAXAxis class]]) {
                    if (!axis.labels) axis.labels = AALabels.new;
                    if (!axis.labels.style) axis.labels.style = AAStyle.new;
                    axis.labels.style.color = textColor;
                }
         }
    } else {
        if (!chartOptions.xAxis.labels) chartOptions.xAxis.labels = AALabels.new;
        if (!chartOptions.xAxis.labels.style) chartOptions.xAxis.labels.style = AAStyle.new;
        chartOptions.xAxis.labels.style.color = textColor;
    }

    // 图例标签颜色
    if (!chartOptions.legend) chartOptions.legend = AALegend.new;
    if (!chartOptions.legend.itemStyle) chartOptions.legend.itemStyle = AAItemStyle.new;
    chartOptions.legend.itemStyle.color = textColor;
    // --- 文本颜色设置结束 ---

    // --- (可选) 设置图表背景色 ---
    // 通常让图表背景透明以显示下层视图
     if (!chartOptions.chart) chartOptions.chart = AAChart.new;
     chartOptions.chart.backgroundColor = @"transparent"; // 明确设置透明
    // --- 图表背景色设置结束 ---

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

    // --- 移除 Cell 背景硬编码 ---
    // 由 Cell 内部根据模式处理
    // --- Cell 背景设置结束 ---

    // --- 通知 Cell 当前模式 ---
    // **重要**: 调用 Cell 内部的方法来更新其外观。
    // 你需要在 ChartExampleCollectionViewCell.h 中声明这个方法，并在 .m 中实现它。
    if ([cell respondsToSelector:@selector(configureAppearanceForNightMode:)]) {
              
        [cell configureAppearanceForNightMode:self.isNightMode];
    } else {
        // 如果 Cell 没有实现该方法，可以给一个默认的简单背景色切换作为后备
        cell.contentView.backgroundColor = self.isNightMode ? [UIColor colorWithWhite:0.1 alpha:0.7] : [UIColor colorWithWhite:0.95 alpha:0.8];
        NSLog(@"Warning: ChartExampleCollectionViewCell does not respond to configureAppearanceForNightMode:");
    }
    // --- 模式通知结束 ---

    // 配置自定义单元格
    AAOptions *chartOptions = self.chartExamples[indexPath.row];
    // 禁用动画并应用当前模式的颜色
    AAOptions *chartOptionsWithoutAnimation = [self optionsItemsWithoutAnimation:chartOptions];

    [cell setChartOptions:chartOptionsWithoutAnimation completion:^(AAChartView *aaChartView) {
        // 这里可以处理图表加载完成后的回调
        NSLog(@"Chart loaded successfully in cell: %ld", (long)indexPath.item);
        // --- 确保 AAChartView 背景也透明 ---
        // 这一步在 optionsItemsWithoutAnimation 中通过 chart.backgroundColor = @"transparent" 完成了
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
