#import "ChartExampleCollectionViewCell.h"

@interface ChartExampleCollectionViewCell()
@property (nonatomic, strong, readwrite) AAChartView *aaChartView;
@property (nonatomic, strong) UIVisualEffectView *blurEffectView; // 假设有毛玻璃视图
@end

@implementation ChartExampleCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.contentView.layer.cornerRadius = 8.0; // 给 contentView 加圆角
    self.contentView.layer.masksToBounds = YES; // 确保毛玻璃效果被裁剪

    // --- 初始化毛玻璃效果 ---
    // 初始效果将在 configureAppearanceForNightMode 中设置
    self.blurEffectView = [[UIVisualEffectView alloc] init];
    self.blurEffectView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.contentView addSubview:self.blurEffectView]; // 添加到 contentView

    // --- 初始化 AAChartView ---
    self.aaChartView = [[AAChartView alloc] init];
    self.aaChartView.translatesAutoresizingMaskIntoConstraints = NO;
    self.aaChartView.scrollEnabled = NO; // 通常列表中的图表不需要滚动
    self.aaChartView.backgroundColor = [UIColor clearColor]; // 确保图表背景透明
    [self.contentView addSubview:self.aaChartView]; // 添加到 contentView (在毛玻璃之上)

    // --- 设置约束 ---
    [NSLayoutConstraint activateConstraints:@[
        // 毛玻璃填充 contentView
        [self.blurEffectView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
        [self.blurEffectView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
        [self.blurEffectView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
        [self.blurEffectView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],

        // AAChartView 填充 contentView (或根据需要添加边距)
        [self.aaChartView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:5], // 示例边距
        [self.aaChartView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:5],
        [self.aaChartView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-5],
        [self.aaChartView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-5]
    ]];

    // 确保 contentView 和 cell 本身背景透明，以便看到毛玻璃
    self.contentView.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
}

// --- 添加方法实现 ---
- (void)configureAppearanceForNightMode:(BOOL)isNightMode {
    if (isNightMode) {
        self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        // 可以添加其他夜间模式特定的 UI 调整
    } else {
        // 为日间模式选择一个合适的模糊效果，例如 SystemMaterialLight 或 ExtraLight
        self.blurEffectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemMaterialLight];
        // 可以添加其他日间模式特定的 UI 调整
    }
}
// --- 方法实现结束 ---


- (void)setChartOptions:(AAOptions *)chartOptions completion:(void (^)(AAChartView *aaChartView))completion {
    // 确保 aaChartView 存在
    if (!self.aaChartView) {
        // 如果需要，可以在这里重新创建或处理错误
        NSLog(@"Error: aaChartView is nil in cell reuse.");
        return;
    }
    // 绘制图表
    [self.aaChartView aa_drawChartWithOptions:chartOptions];

    // 执行完成回调
    if (completion) {
        completion(self.aaChartView);
    }
}

// (可选) 重写 prepareForReuse 以重置状态
- (void)prepareForReuse {
    [super prepareForReuse];
    // 可以在这里重置图表内容或单元格状态，防止复用时显示旧数据
    // [self.aaChartView aa_clearChart]; // 如果需要清空图表
}

@end
