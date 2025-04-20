#import "ChartListCollectionViewVC.h"
#import "ChartSampleProvider.h"
#import "ChartExampleCollectionViewCell.h" // 导入自定义 CollectionView Cell 的头文件
#import "AAChartKit.h" // 导入 AAChartKit 相关头文件

static NSString * const kChartSampleCollectionViewCellIdentifier = @"ChartSampleCollectionViewCell";
static NSString * const kGradientAnimationKey = @"gradientAnimation"; // 动画 Key
static NSString * const kLightSourceAnimationKey = @"lightSourceAnimation"; // 光源动画 Key
static NSString * const kLightSourceColorAnimationKey = @"lightSourceColorAnimation"; // 光源颜色动画 Key

#define NUM_LIGHT_SOURCES 5 // 定义光源数量

@interface ChartListCollectionViewVC () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CAAnimationDelegate> // 确保协议已声明
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<AAOptions *> *chartExamples;
@property (nonatomic, strong) CAGradientLayer *backgroundGradientLayer; // 添加渐变层属性
@property (nonatomic, strong) NSArray *gradientColorSets; // 存储多组渐变颜色
@property (nonatomic, assign) NSInteger currentGradientIndex; // 当前颜色组索引
@property (nonatomic, strong) NSMutableArray<CALayer *> *lightSourceLayers; // 光源图层数组
@property (nonatomic, strong) NSArray *lightSourceImages; // 预生成的光源图像 (CGImage)
@end

@implementation ChartListCollectionViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.chartExamples = [ChartSampleProvider allProTypeSamples];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self startGradientAnimation]; // 视图出现时启动渐变动画
    // 确保布局完成后再启动光源动画，以获得正确的边界
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.view.window) { // 再次检查视图是否可见
             [self startLightSourceAnimation]; // 启动光源动画
        }
    });
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.backgroundGradientLayer removeAnimationForKey:kGradientAnimationKey]; // 视图消失时移除渐变动画
    for (CALayer *layer in self.lightSourceLayers) { // 移除所有光源动画
        [layer removeAnimationForKey:kLightSourceAnimationKey];
        [layer removeAnimationForKey:kLightSourceColorAnimationKey]; // 移除颜色动画
    }
}

// --- 辅助方法：创建径向渐变图像 ---
- (UIImage *)createRadialGradientImageWithSize:(CGSize)size centerColor:(UIColor *)centerColor edgeColor:(UIColor *)edgeColor {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();

    CGFloat radius = MIN(size.width, size.height) / 2.0;
    CGPoint center = CGPointMake(size.width / 2.0, size.height / 2.0);

    // 定义渐变颜色和位置
    NSArray *colors = @[(__bridge id)centerColor.CGColor, (__bridge id)edgeColor.CGColor];
    CGFloat locations[] = { 0.0, 1.0 }; // 中心颜色在 0.0，边缘颜色在 1.0

    // 创建渐变
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);

    // 绘制径向渐变
    CGContextDrawRadialGradient(context, gradient, center, 0, center, radius, kCGGradientDrawsAfterEndLocation);

    // 清理
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);

    UIImage *gradientImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return gradientImage;
}
// --- 辅助方法结束 ---


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

    // --- 预生成光源图像 ---
    CGFloat maxLightSourceSize = 500.0; // 定义一个统一的最大尺寸用于预生成图像
    CGSize imageSize = CGSizeMake(maxLightSourceSize, maxLightSourceSize);
    UIColor *transparentEdge = [UIColor colorWithWhite:1.0 alpha:0.0];
    NSArray *centerColors = @[
        [UIColor colorWithRed:1.0 green:0.85 blue:0.4 alpha:0.6], // 暖黄
        [UIColor colorWithRed:1.0 green:0.7 blue:0.3 alpha:0.6], // 橙黄
        [UIColor colorWithRed:1.0 green:0.5 blue:0.4 alpha:0.55] // 浅红橙
    ];
    NSMutableArray *images = [NSMutableArray array];
    for (UIColor *centerColor in centerColors) {
        UIImage *img = [self createRadialGradientImageWithSize:imageSize centerColor:centerColor edgeColor:transparentEdge];
        if (img.CGImage) {
            [images addObject:(__bridge id)img.CGImage]; // 直接存储 CGImage
        }
    }
    self.lightSourceImages = [images copy];
    // --- 预生成光源图像结束 ---


    // --- 添加多个光源图层 ---
    self.lightSourceLayers = [NSMutableArray arrayWithCapacity:NUM_LIGHT_SOURCES];
    for (int i = 0; i < NUM_LIGHT_SOURCES; ++i) {
        CALayer *lightLayer = [CALayer layer];
        // 增大光源尺寸范围 (300-500)
        CGFloat lightSourceSize = arc4random_uniform(200) + 300.0;
        lightLayer.bounds = CGRectMake(0, 0, lightSourceSize, lightSourceSize); // 使用随机大小

        // 设置随机初始位置
        CGFloat initialX = arc4random_uniform((uint32_t)self.view.bounds.size.width);
        CGFloat initialY = arc4random_uniform((uint32_t)self.view.bounds.size.height);
        lightLayer.position = CGPointMake(initialX, initialY);

        // 设置初始内容为第一个预生成的图像
        if (self.lightSourceImages.count > 0) {
            lightLayer.contents = self.lightSourceImages[0];
        }
        // 设置 contentsGravity 以便图像缩放适应图层大小
        lightLayer.contentsGravity = kCAGravityResizeAspect;

        // 设置混合模式以增强融合效果
        lightLayer.compositingFilter = @"plusL"; // Lighter Color Dodge

        // 将光源图层插入到背景渐变层之上，collectionView 之下
        [self.view.layer insertSublayer:lightLayer above:self.backgroundGradientLayer];
        [self.lightSourceLayers addObject:lightLayer];
    }
    // --- 光源图层结束 ---


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
    self.collectionView.backgroundColor = [UIColor clearColor]; // 设置 CollectionView 背景透明以显示渐变和光源

    // 注册自定义单元格类
    [self.collectionView registerClass:[ChartExampleCollectionViewCell class] forCellWithReuseIdentifier:kChartSampleCollectionViewCellIdentifier];

    [self.view addSubview:self.collectionView]; // 确保 CollectionView 在最上层

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

    BOOL needsRestartAnimation = NO;
    for (CALayer *layer in self.lightSourceLayers) {
        // 检查位置或颜色动画是否存在
        if ([layer animationForKey:kLightSourceAnimationKey] || [layer animationForKey:kLightSourceColorAnimationKey]) {
            needsRestartAnimation = YES;
            break;
        }
    }

    if (needsRestartAnimation) {
         // 简单的处理方式是重新启动所有光源动画
        [self startLightSourceAnimation];
    } else {
         // 如果动画未运行，确保初始位置在视图变化后仍然合理（或随机重置）
         for (CALayer *layer in self.lightSourceLayers) {
             CGFloat randomX = arc4random_uniform((uint32_t)self.view.bounds.size.width);
             CGFloat randomY = arc4random_uniform((uint32_t)self.view.bounds.size.height);
             layer.position = CGPointMake(randomX, randomY);
         }
    }
}

// --- 修改光源动画方法以处理多个图层和颜色变化 ---
- (void)startLightSourceAnimation {
    // 确保视图边界有效
    if (CGRectIsEmpty(self.view.bounds)) {
        return;
    }

    CGFloat viewWidth = self.view.bounds.size.width;
    CGFloat viewHeight = self.view.bounds.size.height;

    // 确保有预生成的图像可供动画使用
    if (self.lightSourceImages.count == 0) {
        return;
    }

    for (CALayer *layer in self.lightSourceLayers) {
        [layer removeAnimationForKey:kLightSourceAnimationKey]; // 移除旧位置动画
        [layer removeAnimationForKey:kLightSourceColorAnimationKey]; // 移除旧颜色动画

        // --- 位置动画 ---
        int numPoints = arc4random_uniform(4) + 4; // 随机路径点数量 (4-7)
        NSMutableArray *points = [NSMutableArray arrayWithCapacity:numPoints + 1];

        // 使用当前位置作为起点
        [points addObject:[NSValue valueWithCGPoint:layer.position]];

        for (int i = 0; i < numPoints; ++i) {
            CGFloat randomX = arc4random_uniform((uint32_t)viewWidth);
            CGFloat randomY = arc4random_uniform((uint32_t)viewHeight);
            [points addObject:[NSValue valueWithCGPoint:CGPointMake(randomX, randomY)]];
        }

        CAKeyframeAnimation *positionAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        positionAnimation.values = points;
        positionAnimation.duration = arc4random_uniform(15) + 20.0; // (20-35s)
        positionAnimation.calculationMode = kCAAnimationPaced;
        positionAnimation.repeatCount = HUGE_VALF;
        [layer addAnimation:positionAnimation forKey:kLightSourceAnimationKey];


        // --- 颜色 (contents) 动画 ---
        CAKeyframeAnimation *colorAnimation = [CAKeyframeAnimation animationWithKeyPath:@"contents"];
        // 使用预生成的 CGImage 数组
        colorAnimation.values = self.lightSourceImages;
        // 颜色变化的总时长，可以与位置动画不同步
        colorAnimation.duration = arc4random_uniform(10) + 10.0; // (10-20s)
        colorAnimation.calculationMode = kCAAnimationDiscrete; // 离散变化，颜色会跳变
        colorAnimation.repeatCount = HUGE_VALF;
        [layer addAnimation:colorAnimation forKey:kLightSourceColorAnimationKey];
    }
}
// --- 光源动画方法结束 ---


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
     // --- 处理渐变动画结束 ---
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
         }

        // 移除旧动画（虽然设置了 removedOnCompletion = NO，但手动移除更清晰）
        [self.backgroundGradientLayer removeAnimationForKey:kGradientAnimationKey];
        // 延迟一小段时间后开始下一次动画，避免 CPU 占用过高
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             // 检查视图是否仍然可见
             if (self.view.window) {
                 [self startGradientAnimation]; // 只重新启动渐变动画
             }
        });
    }
     // --- 渐变动画处理结束 ---
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
    }];
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
