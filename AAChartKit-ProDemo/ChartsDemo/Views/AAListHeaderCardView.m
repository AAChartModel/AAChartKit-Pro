#import "AAListHeaderCardView.h"

#import <QuartzCore/QuartzCore.h>

#import "../Support/AAListColorPalette.h"

@interface AAListHeaderCardView ()

@property (nonatomic, strong) UIView *cardContainerView;
@property (nonatomic, strong) CAGradientLayer *cardGradientLayer;
@property (nonatomic, strong) UIVisualEffectView *glassEffectView;
@property (nonatomic, strong) UIView *innerBackgroundView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UIStackView *chipStackView;
@property (nonatomic, strong) NSArray<UIView *> *chipViews;
@property (nonatomic, strong) NSArray<UILabel *> *chipLabels;
@property (nonatomic, strong) UIView *floatingOrbView;
@property (nonatomic, strong) CAShapeLayer *haloLayer;
@property (nonatomic, copy) NSArray<NSString *> *chipTitles;

@end

@implementation AAListHeaderCardView

- (instancetype)initWithTitle:(NSString *)title subtitle:(NSString *)subtitle {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        _titleText = [title copy];
        _subtitleText = [subtitle copy];
        _chipTitles = @[@"✨ 交互体验", @"📊 数据探索", @"⚡️ 高性能渲染"];
        [self setupViews];
        _darkMode = NO;
        [self applyThemeWithDarkMode:_darkMode];
    }
    return self;
}

#pragma mark - Setup

- (void)setupViews {
    self.translatesAutoresizingMaskIntoConstraints = NO;
    self.backgroundColor = [UIColor clearColor];

    UIView *cardView = [[UIView alloc] init];
    cardView.translatesAutoresizingMaskIntoConstraints = NO;
    cardView.backgroundColor = [UIColor clearColor];
    cardView.layer.cornerRadius = 26.0;
    cardView.layer.masksToBounds = NO;
    [self addSubview:cardView];
    self.cardContainerView = cardView;

    CAGradientLayer *cardGradient = [CAGradientLayer layer];
    cardGradient.name = @"header.card.gradient";
    cardGradient.startPoint = CGPointMake(0.0, 0.0);
    cardGradient.endPoint = CGPointMake(1.0, 1.0);
    cardGradient.locations = @[@0.0, @0.55, @1.0];
    cardGradient.cornerRadius = cardView.layer.cornerRadius;
    cardGradient.masksToBounds = YES;
    [cardView.layer insertSublayer:cardGradient atIndex:0];
    self.cardGradientLayer = cardGradient;

    UIVisualEffectView *glassView = [[UIVisualEffectView alloc] initWithEffect:nil];
    glassView.translatesAutoresizingMaskIntoConstraints = NO;
    glassView.userInteractionEnabled = NO;
    glassView.layer.cornerRadius = cardView.layer.cornerRadius;
    glassView.layer.masksToBounds = YES;
    [cardView addSubview:glassView];
    self.glassEffectView = glassView;

    UIView *contentContainer = [[UIView alloc] init];
    contentContainer.translatesAutoresizingMaskIntoConstraints = NO;
    contentContainer.backgroundColor = [UIColor clearColor];
    contentContainer.layer.cornerRadius = cardView.layer.cornerRadius;
    contentContainer.layer.masksToBounds = NO;
    [glassView.contentView addSubview:contentContainer];

    UIView *innerBackground = [[UIView alloc] init];
    innerBackground.translatesAutoresizingMaskIntoConstraints = NO;
    innerBackground.backgroundColor = [UIColor clearColor];
    innerBackground.layer.cornerRadius = cardView.layer.cornerRadius;
    innerBackground.layer.masksToBounds = YES;
    innerBackground.userInteractionEnabled = NO;
    [contentContainer addSubview:innerBackground];
    [contentContainer sendSubviewToBack:innerBackground];
    self.innerBackgroundView = innerBackground;

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.numberOfLines = 0;
    titleLabel.font = [UIFont systemFontOfSize:27.0 weight:UIFontWeightBold];
    titleLabel.text = self.titleText;
    [contentContainer addSubview:titleLabel];
    self.titleLabel = titleLabel;

    UILabel *subtitleLabel = [[UILabel alloc] init];
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    subtitleLabel.numberOfLines = 0;
    subtitleLabel.font = [UIFont systemFontOfSize:15.5 weight:UIFontWeightMedium];
    subtitleLabel.text = self.subtitleText;
    [contentContainer addSubview:subtitleLabel];
    self.subtitleLabel = subtitleLabel;

    UIStackView *chipStack = [[UIStackView alloc] init];
    chipStack.translatesAutoresizingMaskIntoConstraints = NO;
    chipStack.axis = UILayoutConstraintAxisHorizontal;
    chipStack.alignment = UIStackViewAlignmentCenter;
    chipStack.spacing = 14.0;
    chipStack.distribution = UIStackViewDistributionFillProportionally;
    [contentContainer addSubview:chipStack];
    self.chipStackView = chipStack;

    NSMutableArray<UIView *> *chipViews = [NSMutableArray array];
    NSMutableArray<UILabel *> *chipLabels = [NSMutableArray array];
    [self.chipTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *chip = [self buildChipViewWithText:obj index:idx];
        UILabel *label = chip.subviews.firstObject;
        if (label) {
            [chipLabels addObject:label];
        }
        [chipStack addArrangedSubview:chip];
        [chipViews addObject:chip];
    }];
    self.chipViews = [chipViews copy];
    self.chipLabels = [chipLabels copy];

    UIView *floatingOrb = [[UIView alloc] init];
    floatingOrb.translatesAutoresizingMaskIntoConstraints = NO;
    floatingOrb.layer.cornerRadius = 36.0;
    floatingOrb.layer.masksToBounds = NO;
    floatingOrb.userInteractionEnabled = NO;
    [cardView insertSubview:floatingOrb belowSubview:glassView];
    self.floatingOrbView = floatingOrb;

    CAShapeLayer *haloLayer = [CAShapeLayer layer];
    haloLayer.name = @"header.halo.layer";
    haloLayer.fillColor = [UIColor clearColor].CGColor;
    haloLayer.lineWidth = 1.4;
    haloLayer.lineDashPattern = @[@6, @8];
    [cardView.layer addSublayer:haloLayer];
    self.haloLayer = haloLayer;

    [self applyBreathingAnimationToLayer:haloLayer from:0.25 to:0.55 duration:3.6];
    [self applyFloatingAnimationToView:floatingOrb amplitude:9.0 duration:5.0];

    [NSLayoutConstraint activateConstraints:@[
        [cardView.topAnchor constraintEqualToAnchor:self.topAnchor constant:28.0],
        [cardView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor constant:-12.0],
        [cardView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor constant:20.0],
        [cardView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor constant:-20.0],

        [glassView.leadingAnchor constraintEqualToAnchor:cardView.leadingAnchor],
        [glassView.trailingAnchor constraintEqualToAnchor:cardView.trailingAnchor],
        [glassView.topAnchor constraintEqualToAnchor:cardView.topAnchor],
        [glassView.bottomAnchor constraintEqualToAnchor:cardView.bottomAnchor],

        [contentContainer.leadingAnchor constraintEqualToAnchor:glassView.contentView.leadingAnchor],
        [contentContainer.trailingAnchor constraintEqualToAnchor:glassView.contentView.trailingAnchor],
        [contentContainer.topAnchor constraintEqualToAnchor:glassView.contentView.topAnchor],
        [contentContainer.bottomAnchor constraintEqualToAnchor:glassView.contentView.bottomAnchor],

        [innerBackground.leadingAnchor constraintEqualToAnchor:contentContainer.leadingAnchor],
        [innerBackground.trailingAnchor constraintEqualToAnchor:contentContainer.trailingAnchor],
        [innerBackground.topAnchor constraintEqualToAnchor:contentContainer.topAnchor],
        [innerBackground.bottomAnchor constraintEqualToAnchor:contentContainer.bottomAnchor],

        [titleLabel.topAnchor constraintEqualToAnchor:contentContainer.topAnchor constant:28.0],
        [titleLabel.leadingAnchor constraintEqualToAnchor:contentContainer.leadingAnchor constant:28.0],
        [titleLabel.trailingAnchor constraintEqualToAnchor:contentContainer.trailingAnchor constant:-28.0],

        [subtitleLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:12.0],
        [subtitleLabel.leadingAnchor constraintEqualToAnchor:titleLabel.leadingAnchor],
        [subtitleLabel.trailingAnchor constraintEqualToAnchor:titleLabel.trailingAnchor],

        [chipStack.topAnchor constraintEqualToAnchor:subtitleLabel.bottomAnchor constant:18.0],
        [chipStack.leadingAnchor constraintEqualToAnchor:titleLabel.leadingAnchor],
        [chipStack.trailingAnchor constraintLessThanOrEqualToAnchor:contentContainer.trailingAnchor constant:-28.0],
        [chipStack.bottomAnchor constraintEqualToAnchor:contentContainer.bottomAnchor constant:-26.0],

        [floatingOrb.widthAnchor constraintEqualToConstant:72.0],
        [floatingOrb.heightAnchor constraintEqualToConstant:72.0],
        [floatingOrb.trailingAnchor constraintEqualToAnchor:cardView.trailingAnchor constant:-22.0],
        [floatingOrb.topAnchor constraintEqualToAnchor:cardView.topAnchor constant:12.0]
    ]];
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];

    self.cardGradientLayer.frame = self.cardContainerView.bounds;
    self.haloLayer.frame = self.cardContainerView.bounds;

    CGRect haloBounds = CGRectInset(self.cardContainerView.bounds, 16.0, 16.0);
    UIBezierPath *haloPath = [UIBezierPath bezierPathWithRoundedRect:haloBounds
                                                         cornerRadius:MAX(self.cardContainerView.layer.cornerRadius - 16.0, 8.0)];
    self.haloLayer.path = haloPath.CGPath;

    for (UIView *chipView in self.chipViews) {
        [self updateGradientLayerFrameInView:chipView named:@"chip.gradient"];
    }
    [self updateGradientLayerFrameInView:self.cardContainerView named:@"header.card.gradient"];
}

#pragma mark - Public

- (void)applyThemeWithDarkMode:(BOOL)isDarkMode {
    self.darkMode = isDarkMode;

    NSArray *colors = nil;
    if (isDarkMode) {
        colors = @[(__bridge id)ColorWithRGB(120, 76, 60, 1).CGColor,
                   (__bridge id)ColorWithRGB(138, 86, 70, 1).CGColor,
                   (__bridge id)ColorWithRGB(162, 98, 92, 1).CGColor];
    } else {
        colors = @[(__bridge id)ColorWithRGB(255, 188, 145, 1).CGColor,
                   (__bridge id)ColorWithRGB(255, 209, 162, 1).CGColor,
                   (__bridge id)ColorWithRGB(255, 195, 183, 1).CGColor];
    }
    self.cardGradientLayer.colors = colors;

    self.cardContainerView.backgroundColor = AALightDarkColor([[UIColor whiteColor] colorWithAlphaComponent:0.18], [[UIColor blackColor] colorWithAlphaComponent:0.28]);
    self.cardContainerView.layer.shadowColor = (isDarkMode ? [UIColor blackColor] : ColorWithRGB(210, 170, 120, 1)).CGColor;
    self.cardContainerView.layer.shadowOpacity = isDarkMode ? 0.36 : 0.24;
    self.cardContainerView.layer.shadowRadius = isDarkMode ? 34.0 : 28.0;
    self.cardContainerView.layer.shadowOffset = CGSizeMake(0, isDarkMode ? 20.0 : 16.0);
    self.cardContainerView.layer.borderWidth = isDarkMode ? 0.6 : 0.0;
    self.cardContainerView.layer.borderColor = isDarkMode ? ColorWithRGB(255, 200, 160, 0.20).CGColor : [UIColor clearColor].CGColor;

    UIVisualEffect *newEffect = nil;
    if (@available(iOS 13.0, *)) {
        newEffect = [UIBlurEffect effectWithStyle:isDarkMode ? UIBlurEffectStyleSystemThinMaterialDark : UIBlurEffectStyleSystemThinMaterialLight];
    } else {
        newEffect = [UIBlurEffect effectWithStyle:isDarkMode ? UIBlurEffectStyleDark : UIBlurEffectStyleExtraLight];
    }
    self.glassEffectView.effect = newEffect;

    self.innerBackgroundView.backgroundColor = AALightDarkColor(ColorWithRGB(255, 255, 255, 0.18), ColorWithRGB(60, 40, 36, 0.28));
    self.titleLabel.textColor = isDarkMode ? [UIColor colorWithWhite:0.96 alpha:1.0] : [UIColor colorWithWhite:1.0 alpha:0.98];
    self.subtitleLabel.textColor = isDarkMode ? [[UIColor whiteColor] colorWithAlphaComponent:0.74] : [[UIColor whiteColor] colorWithAlphaComponent:0.90];

    [self.chipViews enumerateObjectsUsingBlock:^(UIView * _Nonnull chipView, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *chipColors = [self chipGradientColorsForIndex:idx darkMode:isDarkMode];
        [self updateGradientLayerInView:chipView named:@"chip.gradient" colors:chipColors];
        chipView.layer.borderColor = isDarkMode ? ColorWithRGB(242, 184, 150, 0.26).CGColor : ColorWithRGB(255, 215, 190, 0.7).CGColor;
        chipView.layer.borderWidth = isDarkMode ? 0.8 : 0.6;
        chipView.layer.shadowColor = isDarkMode ? ColorWithRGB(206, 132, 96, 1).CGColor : ColorWithRGB(255, 186, 140, 1).CGColor;
        chipView.layer.shadowOpacity = isDarkMode ? 0.42 : 0.30;
        chipView.layer.shadowOffset = CGSizeZero;
        chipView.layer.shadowRadius = 8.0;
    }];

    [self.chipLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull label, NSUInteger idx, BOOL * _Nonnull stop) {
        label.textColor = isDarkMode ? [UIColor colorWithWhite:0.94 alpha:1.0] : [UIColor colorWithWhite:1.0 alpha:0.95];
    }];

    self.floatingOrbView.backgroundColor = AALightDarkColor(ColorWithRGB(255, 213, 153, 0.42), ColorWithRGB(148, 90, 60, 0.52));
    self.floatingOrbView.layer.shadowColor = (isDarkMode ? ColorWithRGB(210, 130, 88, 1) : ColorWithRGB(255, 191, 140, 1)).CGColor;
    self.floatingOrbView.layer.shadowOpacity = isDarkMode ? 0.64 : 0.48;
    self.floatingOrbView.layer.shadowOffset = CGSizeZero;
    self.floatingOrbView.layer.shadowRadius = 20.0;

    self.haloLayer.strokeColor = isDarkMode ? ColorWithRGB(255, 204, 170, 0.20).CGColor : ColorWithRGB(255, 255, 255, 0.28).CGColor;
    self.haloLayer.shadowColor = (isDarkMode ? ColorWithRGB(218, 140, 98, 1) : ColorWithRGB(255, 186, 135, 1)).CGColor;
    self.haloLayer.shadowOpacity = isDarkMode ? 0.58 : 0.34;
    self.haloLayer.shadowOffset = CGSizeZero;
    self.haloLayer.shadowRadius = 18.0;
}

- (void)updateChipTitles:(NSArray<NSString *> *)chipTitles {
    if (chipTitles.count == 0) { return; }
    self.chipTitles = [chipTitles copy];
    NSUInteger count = MIN(self.chipTitles.count, self.chipLabels.count);
    for (NSUInteger idx = 0; idx < count; idx++) {
        self.chipLabels[idx].text = self.chipTitles[idx];
    }
}

- (void)setTitleText:(NSString *)titleText {
    _titleText = [titleText copy];
    self.titleLabel.text = _titleText;
}

- (void)setSubtitleText:(NSString *)subtitleText {
    _subtitleText = [subtitleText copy];
    self.subtitleLabel.text = _subtitleText;
}

#pragma mark - Private Helpers

- (UIView *)buildChipViewWithText:(NSString *)text index:(NSUInteger)index {
    UIView *chipView = [[UIView alloc] init];
    chipView.translatesAutoresizingMaskIntoConstraints = NO;
    chipView.backgroundColor = [UIColor clearColor];
    chipView.layer.cornerRadius = 18.0;
    chipView.layer.masksToBounds = NO;

    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.font = [UIFont systemFontOfSize:13.5 weight:UIFontWeightSemibold];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    label.textColor = [UIColor whiteColor];
    [chipView addSubview:label];

    [NSLayoutConstraint activateConstraints:@[
        [label.leadingAnchor constraintEqualToAnchor:chipView.leadingAnchor constant:16.0],
        [label.trailingAnchor constraintEqualToAnchor:chipView.trailingAnchor constant:-16.0],
        [label.topAnchor constraintEqualToAnchor:chipView.topAnchor constant:8.0],
        [label.bottomAnchor constraintEqualToAnchor:chipView.bottomAnchor constant:-8.0]
    ]];

    [label setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];

    NSArray *colors = [self chipGradientColorsForIndex:index darkMode:self.isDarkMode];
    [self updateGradientLayerInView:chipView named:@"chip.gradient" colors:colors];

    return chipView;
}

- (NSArray<id> *)chipGradientColorsForIndex:(NSUInteger)index darkMode:(BOOL)isDarkMode {
    NSUInteger styleIndex = index % 3;
    switch (styleIndex) {
        case 0:
            if (isDarkMode) {
                return @[(__bridge id)ColorWithRGB(196, 108, 70, 0.90).CGColor,
                         (__bridge id)ColorWithRGB(176, 86, 66, 0.92).CGColor];
            }
            return @[(__bridge id)ColorWithRGB(255, 170, 116, 0.96).CGColor,
                     (__bridge id)ColorWithRGB(255, 143, 96, 0.94).CGColor];
        case 1:
            if (isDarkMode) {
                return @[(__bridge id)ColorWithRGB(194, 132, 68, 0.88).CGColor,
                         (__bridge id)ColorWithRGB(170, 112, 60, 0.90).CGColor];
            }
            return @[(__bridge id)ColorWithRGB(255, 193, 120, 0.92).CGColor,
                     (__bridge id)ColorWithRGB(255, 210, 150, 0.96).CGColor];
        default:
            if (isDarkMode) {
                return @[(__bridge id)ColorWithRGB(170, 88, 94, 0.82).CGColor,
                         (__bridge id)ColorWithRGB(148, 72, 86, 0.86).CGColor];
            }
            return @[(__bridge id)ColorWithRGB(255, 186, 180, 0.90).CGColor,
                     (__bridge id)ColorWithRGB(255, 210, 204, 0.95).CGColor];
    }
}

- (void)updateGradientLayerInView:(UIView *)view named:(NSString *)name colors:(NSArray<id> *)colors {
    if (!view || colors.count == 0) { return; }
    CAGradientLayer *targetLayer = nil;
    for (CALayer *layer in view.layer.sublayers) {
        if ([layer.name isEqualToString:name] && [layer isKindOfClass:[CAGradientLayer class]]) {
            targetLayer = (CAGradientLayer *)layer;
            break;
        }
    }
    if (!targetLayer) {
        targetLayer = [CAGradientLayer layer];
        targetLayer.name = name;
        targetLayer.cornerRadius = view.layer.cornerRadius;
        targetLayer.startPoint = CGPointMake(0.0, 0.0);
        targetLayer.endPoint = CGPointMake(1.0, 1.0);
        targetLayer.needsDisplayOnBoundsChange = YES;
        targetLayer.masksToBounds = YES;
        [view.layer insertSublayer:targetLayer atIndex:0];
    }
    targetLayer.frame = view.bounds;
    targetLayer.colors = colors;
}

- (void)updateGradientLayerFrameInView:(UIView *)view named:(NSString *)name {
    for (CALayer *layer in view.layer.sublayers) {
        if ([layer.name isEqualToString:name] && [layer isKindOfClass:[CAGradientLayer class]]) {
            layer.frame = view.bounds;
        }
    }
}

- (void)applyFloatingAnimationToView:(UIView *)view amplitude:(CGFloat)amplitude duration:(CFTimeInterval)duration {
    if (!view) { return; }
    CAKeyframeAnimation *vertical = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    vertical.values = @[@0, @(amplitude), @0, @(-amplitude * 0.6), @0];
    vertical.duration = MAX(duration, 3.0);
    vertical.repeatCount = HUGE_VALF;
    vertical.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    CAKeyframeAnimation *horizontal = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    horizontal.values = @[@0, @(amplitude * 0.3), @0, @(-amplitude * 0.2), @0];
    horizontal.duration = vertical.duration * 1.2;
    horizontal.repeatCount = HUGE_VALF;
    horizontal.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];

    [view.layer addAnimation:vertical forKey:@"aa.floatingY"];
    [view.layer addAnimation:horizontal forKey:@"aa.floatingX"];
}

- (void)applyBreathingAnimationToLayer:(CALayer *)layer from:(CGFloat)fromOpacity to:(CGFloat)toOpacity duration:(CFTimeInterval)duration {
    if (!layer) { return; }
    layer.opacity = fromOpacity;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @(fromOpacity);
    animation.toValue = @(toOpacity);
    animation.duration = MAX(duration, 2.4);
    animation.autoreverses = YES;
    animation.repeatCount = HUGE_VALF;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [layer addAnimation:animation forKey:@"aa.breathing"];
}

@end
