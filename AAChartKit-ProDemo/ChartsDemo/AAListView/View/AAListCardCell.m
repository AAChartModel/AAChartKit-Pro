#import "AAListCardCell.h"

#import <QuartzCore/QuartzCore.h>

#import "../Support/AAListColorPalette.h"

@interface AAListCardCell ()

@property (nonatomic, strong) UIView *cardContainerViewInternal;
@property (nonatomic, strong) UIVisualEffectView *blurView;
@property (nonatomic, strong) UIView *gradientOverlayView;
@property (nonatomic, strong) UIView *contentContainerView;
@property (nonatomic, strong) UILabel *badgeLabel;
@property (nonatomic, strong) UILabel *titleLabelInternal;
@property (nonatomic, strong) UILabel *subtitleLabelInternal;
@property (nonatomic, strong) UIImageView *chevronImageView;
@property (nonatomic, assign) BOOL darkMode;

@end

@implementation AAListCardCell

+ (NSString *)reuseIdentifier {
    return @"AAListCardCell";
}

+ (CGFloat)cardShadowBaseOpacityForDarkMode:(BOOL)isDarkMode {
    return isDarkMode ? 0.45f : 0.20f;
}

#pragma mark - Lifecycle

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.titleLabelInternal.text = nil;
    self.subtitleLabelInternal.text = nil;
    self.badgeLabel.text = nil;
}

#pragma mark - Public API

- (UIView *)cardContainerView {
    return self.cardContainerViewInternal;
}

- (void)configureWithPrimaryTitle:(NSString *)primaryTitle
                    secondaryTitle:(NSString *)secondaryTitle
                          badgeText:(NSString *)badgeText
                          darkMode:(BOOL)isDarkMode
                        accentColor:(UIColor *)accentColor {
    self.darkMode = isDarkMode;
    self.titleLabelInternal.text = primaryTitle ?: @"";
    self.subtitleLabelInternal.text = secondaryTitle.length > 0 ? secondaryTitle : @"探索这个图表";
    self.badgeLabel.text = badgeText ?: @"00";
    [self applyThemeWithDarkMode:isDarkMode accentColor:accentColor];
}

- (void)applyThemeWithDarkMode:(BOOL)isDarkMode accentColor:(UIColor *)accentColor {
    self.darkMode = isDarkMode;

    self.cardContainerViewInternal.layer.shadowOpacity = [[self class] cardShadowBaseOpacityForDarkMode:isDarkMode];
    self.cardContainerViewInternal.layer.shadowColor = (isDarkMode ? [UIColor blackColor] : ColorWithRGB(210, 170, 130, 0.4)).CGColor;
    self.cardContainerViewInternal.layer.shadowRadius = isDarkMode ? 18.0 : 16.0;
    self.cardContainerViewInternal.layer.shadowOffset = CGSizeMake(0, isDarkMode ? 12 : 10);
    self.cardContainerViewInternal.layer.borderWidth = isDarkMode ? 0.5 : 0.0;
    self.cardContainerViewInternal.layer.borderColor = isDarkMode ? ColorWithRGB(255, 200, 160, 0.20).CGColor : [UIColor clearColor].CGColor;

    [self updateBlurEffect];
    [self updateGradientOverlay];

    self.badgeLabel.backgroundColor = accentColor;
    self.badgeLabel.layer.shadowColor = accentColor.CGColor;
    self.badgeLabel.layer.shadowOpacity = 0.4;
    self.badgeLabel.layer.shadowOffset = CGSizeMake(0, 2);
    self.badgeLabel.layer.shadowRadius = 6.0;

    if (isDarkMode) {
        self.titleLabelInternal.textColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        self.subtitleLabelInternal.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        self.chevronImageView.tintColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    } else {
        self.titleLabelInternal.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
        self.subtitleLabelInternal.textColor = ColorWithRGB(156, 113, 95, 1);
        self.chevronImageView.tintColor = ColorWithRGB(173, 131, 113, 1);
    }

    if (!self.chevronImageView.image) {
        self.chevronImageView.image = [self fallbackChevronImageForDarkMode:isDarkMode];
    }
    self.chevronImageView.alpha = 0.8;
}

#pragma mark - Setup

- (void)setupViews {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];

    UIView *cardView = [[UIView alloc] init];
    cardView.translatesAutoresizingMaskIntoConstraints = NO;
    cardView.backgroundColor = [UIColor clearColor];
    cardView.layer.cornerRadius = 18.0;
    cardView.layer.masksToBounds = NO;
    [self.contentView addSubview:cardView];
    self.cardContainerViewInternal = cardView;

    [NSLayoutConstraint activateConstraints:@[
        [cardView.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor constant:18.0],
        [cardView.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor constant:-18.0],
        [cardView.topAnchor constraintEqualToAnchor:self.contentView.topAnchor constant:8.0],
        [cardView.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor constant:-8.0]
    ]];

    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:nil];
    blurView.translatesAutoresizingMaskIntoConstraints = NO;
    blurView.userInteractionEnabled = NO;
    blurView.layer.cornerRadius = cardView.layer.cornerRadius;
    blurView.layer.masksToBounds = YES;
    [cardView addSubview:blurView];
    self.blurView = blurView;

    UIView *gradientOverlay = [[UIView alloc] init];
    gradientOverlay.translatesAutoresizingMaskIntoConstraints = NO;
    gradientOverlay.backgroundColor = [UIColor clearColor];
    gradientOverlay.layer.cornerRadius = cardView.layer.cornerRadius;
    gradientOverlay.layer.masksToBounds = YES;
    [cardView addSubview:gradientOverlay];
    self.gradientOverlayView = gradientOverlay;

    UIView *contentContainer = [[UIView alloc] init];
    contentContainer.translatesAutoresizingMaskIntoConstraints = NO;
    contentContainer.backgroundColor = [UIColor clearColor];
    [cardView addSubview:contentContainer];
    self.contentContainerView = contentContainer;

    UILabel *badgeLabel = [[UILabel alloc] init];
    badgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    badgeLabel.textAlignment = NSTextAlignmentCenter;
    badgeLabel.font = [UIFont monospacedDigitSystemFontOfSize:13.0 weight:UIFontWeightBold];
    badgeLabel.textColor = [UIColor whiteColor];
    badgeLabel.layer.cornerRadius = 15.0;
    badgeLabel.layer.masksToBounds = YES;
    [contentContainer addSubview:badgeLabel];
    self.badgeLabel = badgeLabel;

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold];
    titleLabel.numberOfLines = 1;
    [contentContainer addSubview:titleLabel];
    self.titleLabelInternal = titleLabel;

    UILabel *subtitleLabel = [[UILabel alloc] init];
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    subtitleLabel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
    subtitleLabel.numberOfLines = 0;
    [contentContainer addSubview:subtitleLabel];
    self.subtitleLabelInternal = subtitleLabel;

    UIImageView *chevron = [[UIImageView alloc] init];
    chevron.translatesAutoresizingMaskIntoConstraints = NO;
    chevron.contentMode = UIViewContentModeScaleAspectFit;
    chevron.tintColor = ColorWithRGB(173, 131, 113, 1);
    chevron.image = [UIImage imageNamed:@"icon_arrow_right"];
    [contentContainer addSubview:chevron];
    self.chevronImageView = chevron;

    [NSLayoutConstraint activateConstraints:@[
        [blurView.leadingAnchor constraintEqualToAnchor:cardView.leadingAnchor],
        [blurView.trailingAnchor constraintEqualToAnchor:cardView.trailingAnchor],
        [blurView.topAnchor constraintEqualToAnchor:cardView.topAnchor],
        [blurView.bottomAnchor constraintEqualToAnchor:cardView.bottomAnchor],

        [gradientOverlay.leadingAnchor constraintEqualToAnchor:cardView.leadingAnchor],
        [gradientOverlay.trailingAnchor constraintEqualToAnchor:cardView.trailingAnchor],
        [gradientOverlay.topAnchor constraintEqualToAnchor:cardView.topAnchor],
        [gradientOverlay.bottomAnchor constraintEqualToAnchor:cardView.bottomAnchor],

        [contentContainer.leadingAnchor constraintEqualToAnchor:cardView.leadingAnchor constant:20.0],
        [contentContainer.trailingAnchor constraintEqualToAnchor:cardView.trailingAnchor constant:-20.0],
        [contentContainer.topAnchor constraintEqualToAnchor:cardView.topAnchor constant:14.0],
        [contentContainer.bottomAnchor constraintEqualToAnchor:cardView.bottomAnchor constant:-14.0],

        [badgeLabel.widthAnchor constraintEqualToConstant:30.0],
        [badgeLabel.heightAnchor constraintEqualToConstant:30.0],
        [badgeLabel.leadingAnchor constraintEqualToAnchor:contentContainer.leadingAnchor],
        [badgeLabel.centerYAnchor constraintEqualToAnchor:contentContainer.centerYAnchor],

        [chevron.widthAnchor constraintEqualToConstant:16.0],
        [chevron.heightAnchor constraintEqualToConstant:16.0],
        [chevron.trailingAnchor constraintEqualToAnchor:contentContainer.trailingAnchor],
        [chevron.centerYAnchor constraintEqualToAnchor:contentContainer.centerYAnchor],

        [titleLabel.leadingAnchor constraintEqualToAnchor:badgeLabel.trailingAnchor constant:14.0],
        [titleLabel.trailingAnchor constraintEqualToAnchor:chevron.leadingAnchor constant:-14.0],
        [titleLabel.topAnchor constraintEqualToAnchor:contentContainer.topAnchor],

        [subtitleLabel.leadingAnchor constraintEqualToAnchor:titleLabel.leadingAnchor],
        [subtitleLabel.trailingAnchor constraintEqualToAnchor:titleLabel.trailingAnchor],
        [subtitleLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:6.0],
        [subtitleLabel.bottomAnchor constraintLessThanOrEqualToAnchor:contentContainer.bottomAnchor]
    ]];
}

#pragma mark - Layout

- (void)layoutSubviews {
    [super layoutSubviews];
    [self updateGradientLayerFrameInView:self.gradientOverlayView named:@"card.overlay.gradient"];
}

#pragma mark - Helpers

- (void)updateBlurEffect {
    UIVisualEffect *newEffect = nil;
    BOOL isDarkMode = self.darkMode;
    if (@available(iOS 13.0, *)) {
        newEffect = [UIBlurEffect effectWithStyle:isDarkMode ? UIBlurEffectStyleSystemThinMaterialDark : UIBlurEffectStyleSystemThinMaterialLight];
    } else {
        newEffect = [UIBlurEffect effectWithStyle:isDarkMode ? UIBlurEffectStyleDark : UIBlurEffectStyleExtraLight];
    }
    self.blurView.effect = newEffect;
}

- (void)updateGradientOverlay {
    NSArray *colors = [self cardGradientColorsForDarkMode:self.darkMode];
    [self updateGradientLayerInView:self.gradientOverlayView named:@"card.overlay.gradient" colors:colors];
    self.gradientOverlayView.layer.borderWidth = self.darkMode ? 0.6 : 0.8;
    self.gradientOverlayView.layer.borderColor = self.darkMode ? ColorWithRGB(210, 150, 120, 0.22).CGColor : ColorWithRGB(255, 213, 190, 0.55).CGColor;
}

- (NSArray<id> *)cardGradientColorsForDarkMode:(BOOL)isDarkMode {
    if (isDarkMode) {
        return @[(__bridge id)ColorWithRGB(70, 47, 41, 0.90).CGColor,
                 (__bridge id)ColorWithRGB(58, 36, 32, 0.92).CGColor,
                 (__bridge id)ColorWithRGB(82, 52, 44, 0.88).CGColor];
    }
    return @[(__bridge id)ColorWithRGB(255, 245, 232, 0.94).CGColor,
             (__bridge id)ColorWithRGB(255, 235, 215, 0.92).CGColor,
             (__bridge id)ColorWithRGB(255, 228, 214, 0.92).CGColor];
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

- (UIImage *)fallbackChevronImageForDarkMode:(BOOL)isDarkMode {
    CGSize size = CGSizeMake(16, 16);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(4, 2)];
    [path addLineToPoint:CGPointMake(12, 8)];
    [path addLineToPoint:CGPointMake(4, 14)];
    UIColor *strokeColor = isDarkMode ? [UIColor colorWithWhite:0.82 alpha:0.95] : ColorWithRGB(173, 131, 113, 0.95);
    [strokeColor setStroke];
    path.lineWidth = 2.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [path stroke];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
