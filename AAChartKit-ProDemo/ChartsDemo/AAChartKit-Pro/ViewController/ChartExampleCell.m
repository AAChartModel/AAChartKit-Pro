#import "ChartExampleCell.h"
#import "AAChartKit.h" // 导入 AAChartView 和 AAOptions

@interface ChartExampleCell ()

@property (nonatomic, strong) AAChartView *aaChartView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *shadowView;

@end

@implementation ChartExampleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

// 懒加载 AAChartView
- (AAChartView *)aaChartView {
    if (!_aaChartView) {
        _aaChartView = [[AAChartView alloc] init];
        _aaChartView.translatesAutoresizingMaskIntoConstraints = NO;
        // 注意：在 Objective-C 中直接设置 layer 属性
        // _aaChartView.layer.cornerRadius = 6; // Corner radius 在 containerView 上设置
        // _aaChartView.layer.shadowColor = [UIColor darkGrayColor].CGColor; // Shadow 在 shadowView 上设置
        // _aaChartView.layer.shadowOpacity = 0.3;
        // _aaChartView.layer.shadowOffset = CGSizeMake(0, 2);
        // _aaChartView.layer.shadowRadius = 6;
        // _aaChartView.layer.masksToBounds = NO; // masksToBounds 在 containerView 上设置
        _aaChartView.backgroundColor = [UIColor whiteColor]; // 背景色可以在这里设置，或在 containerView 设置
    }
    return _aaChartView;
}

// 懒加载 ContainerView
- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [[UIView alloc] init];
        _containerView.translatesAutoresizingMaskIntoConstraints = NO;
        _containerView.backgroundColor = [UIColor whiteColor];
        _containerView.layer.cornerRadius = 6;
        _containerView.layer.masksToBounds = YES; // 裁剪内部视图（如图表）以匹配圆角
    }
    return _containerView;
}

// 懒加载 ShadowView
- (UIView *)shadowView {
    if (!_shadowView) {
        _shadowView = [[UIView alloc] init];
        _shadowView.translatesAutoresizingMaskIntoConstraints = NO;
        _shadowView.layer.shadowColor = [UIColor blackColor].CGColor;
        _shadowView.layer.shadowOpacity = 0.2;
        _shadowView.layer.shadowOffset = CGSizeMake(0, 2);
        _shadowView.layer.shadowRadius = 8;
        _shadowView.layer.cornerRadius = 6; // 阴影视图也设置圆角以匹配容器
        _shadowView.backgroundColor = [UIColor whiteColor]; // 设置背景色以显示阴影
    }
    return _shadowView;
}


- (void)setupUI {
    self.contentView.backgroundColor = [UIColor colorWithWhite:0.97 alpha:1.0];
    self.selectionStyle = UITableViewCellSelectionStyleNone;

    // 先添加阴影视图，再添加容器视图，最后添加图表视图
    [self.contentView addSubview:self.shadowView];
    [self.shadowView addSubview:self.containerView];
    [self.containerView addSubview:self.aaChartView]; // 使用懒加载

    // 设置约束
    [NSLayoutConstraint activateConstraints:@[
        // Shadow view constraints
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

- (void)setChartOptions:(AAOptions *)options completion:(nullable ChartCompletionBlock)completion {
    [self.aaChartView aa_drawChartWithOptions:options]; // 调用 Objective-C 的绘图方法
    if (completion) {
        // 可以在这里添加延迟或其他逻辑，如果需要等待图表渲染完成
        // Highcharts 本身可能有回调，需要查阅 AAChartView 的 Objective-C 接口
        completion(self.aaChartView);
    }
}

- (void)prepareForReuse {
    [super prepareForReuse];
    // 清理图表视图状态（如果需要）
    // 例如，停止动画或清除数据，但 AAChartView 内部可能已处理
    // [self.aaChartView.layer removeAllAnimations]; // 如果有手动添加的动画
    // self.aaChartView = nil; // 如果每次重用都重新创建图表视图
}

@end
