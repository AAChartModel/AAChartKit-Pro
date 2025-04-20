#import "ChartExampleCollectionViewCell.h"
#import "AAChartKit.h" // 导入 AAChartView 和 AAOptions

@interface ChartExampleCollectionViewCell ()

// 与 TableViewCell 相同的内部视图属性
@property (nonatomic, strong) AAChartView *aaChartView;
@property (nonatomic, strong) UIView *containerView;
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
        _aaChartView.backgroundColor = [UIColor whiteColor];
    }
    return _aaChartView;
}

- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.translatesAutoresizingMaskIntoConstraints = NO;
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.cornerRadius = 6;
        _containerView.layer.masksToBounds = YES;
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
    [self.containerView addSubview:self.aaChartView]; // 使用懒加载

    // 设置约束 (与 TableViewCell 版本相同，因为约束是相对于 contentView 的)
    [NSLayoutConstraint activateConstraints:@[
        // Shadow view constraints (注意常量可能需要根据 CollectionView 布局调整，但这里保持一致)
        [self.shadowView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:16],
        [self.shadowView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-16],
        [self.shadowView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:12],
        [self.shadowView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-12],

        // Container view fills the shadow view
        [self.containerView.leadingAnchor constraintEqualToAnchor:self.shadowView.leadingAnchor],
        [self.containerView.trailingAnchor constraintEqualToAnchor:self.shadowView.trailingAnchor],
        [self.containerView.topAnchor constraintEqualToAnchor:self.shadowView.topAnchor],
        [self.containerView.bottomAnchor constraintEqualToAnchor:self.shadowView.bottomAnchor],

        // Chart view fills the container view
        [self.aaChartView.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor constant:0],
        [self.aaChartView.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor constant:0],
        [self.aaChartView.topAnchor constraintEqualToAnchor:self.containerView.topAnchor constant:0],
        [self.aaChartView.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor constant:0]
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
