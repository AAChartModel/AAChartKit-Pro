#import "ChartExampleCollectionViewCell.h"
#import "AAChartKit.h" // 导入 AAChartView 和 AAOptions

@interface ChartExampleCollectionViewCell ()

// 与 TableViewCell 相同的内部视图属性
@property (nonatomic, strong) AAChartView *aaChartView;
@property (nonatomic, strong) UIVisualEffectView *containerView; // 改为 UIVisualEffectView
@property (nonatomic, strong) UIView *shadowView;

@end

@implementation ChartExampleCollectionViewCell

// CollectionViewCell 使用 initWithFrame:
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

// --- 懒加载方法 (与 TableViewCell 版本相同) ---
- (AAChartView *)aaChartView {
    if (!_aaChartView) {
        _aaChartView = [[AAChartView alloc] init];
        _aaChartView.translatesAutoresizingMaskIntoConstraints = NO;
//        _aaChartView.backgroundColor = [UIColor clearColor]; // 设置图表背景透明(这种简单设置不足以使得图表背景透明, 因为 AAChartView 实际上是一个 WKWebView)
        _aaChartView.isClearBackgroundColor = YES; // 设置图表背景透明
    }
    return _aaChartView;
}

- (UIVisualEffectView *)containerView { // 返回类型改为 UIVisualEffectView
    if (!_containerView) {
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemMaterial]; // 使用系统材质模糊效果
        _containerView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _containerView.translatesAutoresizingMaskIntoConstraints = NO;
        _containerView.layer.cornerRadius = 6;
        _containerView.layer.masksToBounds = YES; // 确保模糊效果也被裁剪
    }
    return _containerView;
}

- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.translatesAutoresizingMaskIntoConstraints = NO;
        _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        _shadowView.layer.shadowOpacity = 0.2;
        _shadowView.layer.shadowOffset = CGSizeMake(0, 2);
        _shadowView.layer.shadowRadius = 8;
        _shadowView.layer.cornerRadius = 6;
        _shadowView.backgroundColor = [UIColor whiteColor];
    }
    return _shadowView;
}
// --- 懒加载方法结束 ---

- (void)setupUI {
    // CollectionViewCell 不需要设置 contentView 的背景色和 selectionStyle
    // self.contentView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0]; // 通常在 CollectionView 背景设置
    // self.selectionStyle = UITableViewCellSelectionStyleNone; // CollectionViewCell 没有这个属性

    // 将视图添加到 contentView
    [self.contentView addSubview:self.shadowView];
    [self.shadowView addSubview:self.containerView];
    // 将 aaChartView 添加到 UIVisualEffectView 的 contentView 中
    [self.containerView.contentView addSubview:self.aaChartView]; // 注意是 contentView

    // 设置约束 - 再次减小常量值
    [NSLayoutConstraint activateConstraints:@[
        // Shadow view constraints (再次减小常量)
        [self.shadowView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:4], // 原为 8
        [self.shadowView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-4], // 原为 -8
        [self.shadowView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:3], // 原为 6
        [self.shadowView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-3], // 原为 -6

        // Container view fills the shadow view
        [self.containerView.leadingAnchor constraintEqualToAnchor:self.shadowView.leadingAnchor],
        [self.containerView.trailingAnchor constraintEqualToAnchor:self.shadowView.trailingAnchor],
        [self.containerView.topAnchor constraintEqualToAnchor:self.shadowView.topAnchor],
        [self.containerView.bottomAnchor constraintEqualToAnchor:self.shadowView.bottomAnchor],

        // Chart view fills the container view's contentView
        [self.aaChartView.leadingAnchor constraintEqualToAnchor:self.containerView.contentView.leadingAnchor constant:0], // 约束到 contentView
        [self.aaChartView.trailingAnchor constraintEqualToAnchor:self.containerView.contentView.trailingAnchor constant:0], // 约束到 contentView
        [self.aaChartView.topAnchor constraintEqualToAnchor:self.containerView.contentView.topAnchor constant:0],       // 约束到 contentView
        [self.aaChartView.bottomAnchor constraintEqualToAnchor:self.containerView.contentView.bottomAnchor constant:0]    // 约束到 contentView
    ]];
}

#pragma mark - Public Methods

// --- setChartOptions 方法 (与 TableViewCell 版本相同) ---
- (void)setChartOptions:(AAOptions *)options completion:(nullable ChartCompletionBlock)completion {
    [self.aaChartView aa_drawChartWithOptions:options]; // 调用 Objective-C 的绘图方法
    if (completion) {
        completion(self.aaChartView);
    }
}
// --- setChartOptions 方法结束 ---


// --- prepareForReuse 方法 (与 TableViewCell 版本相同) ---
- (void)prepareForReuse {
    [super prepareForReuse];
    // 清理图表视图状态（如果需要）
    // [self.aaChartView.layer removeAllAnimations];
}
// --- prepareForReuse 方法结束 ---

@end
