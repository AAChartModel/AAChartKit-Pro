//
//  AAListViewController.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2025/10/23.
//  Copyright © 2025 An An. All rights reserved.
//

#import "AAListViewController.h"
#import <QuartzCore/QuartzCore.h>

// MARK: - Color System

#define ColorWithRGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// Modern Color Palette
#define AABackgroundLightStart     ColorWithRGB(255, 248, 240, 1)
#define AABackgroundLightMid       ColorWithRGB(255, 236, 224, 1)
#define AABackgroundLightEnd       ColorWithRGB(255, 229, 233, 1)

#define AABackgroundDarkStart      ColorWithRGB(28, 22, 30, 1)
#define AABackgroundDarkMid        ColorWithRGB(42, 30, 32, 1)
#define AABackgroundDarkEnd        ColorWithRGB(58, 36, 29, 1)

#define AAAccentBlueLight          ColorWithRGB(255, 138, 101, 1)
#define AAAccentBlueDark           ColorWithRGB(255, 171, 145, 1)
#define AAAccentPurple             ColorWithRGB(255, 199, 95, 1)

#define AACardShadowLight          [[UIColor blackColor] colorWithAlphaComponent:0.08]
#define AACardShadowDark           [UIColor blackColor]

static inline UIColor *AALightDarkColor(UIColor *lightColor, UIColor *darkColor) {
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return darkColor ?: lightColor;
            }
            return lightColor;
        }];
    }
    return lightColor;
}

// MARK: - Constants

static const CGFloat kCardPressScale = 0.96;
static const CGFloat kAnimationDurationFast = 0.2;
static const CGFloat kAnimationDurationMedium = 0.3;
static const CGFloat kCardCornerRadius = 18.0;
static const CGFloat kSectionHeaderCornerRadius = 16.0;
static const CGFloat kBadgeCornerRadius = 15.0;

@interface AAListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CAGradientLayer *backgroundGradientLayer;
@property (nonatomic, strong) UIView *tableHeaderCardView;
@property (nonatomic, strong) UILabel *headerTitleLabel;
@property (nonatomic, strong) UILabel *headerSubtitleLabel;
@property (nonatomic, strong) CAGradientLayer *headerCardGradientLayer;
@property (nonatomic, strong) UIVisualEffectView *headerGlassEffectView;
@property (nonatomic, strong) UIView *headerInnerBackgroundView;
@property (nonatomic, strong) NSArray<UIView *> *headerChipViews;
@property (nonatomic, strong) NSArray<UILabel *> *headerChipLabels;
@property (nonatomic, strong) UIView *headerFloatingOrbView;
@property (nonatomic, strong) CAShapeLayer *headerHaloLayer;
@property (nonatomic, strong) UIBarButtonItem *themeToggleButton;

@property (nonatomic, assign) BOOL hasManualThemeOverride;
@property (nonatomic, assign) BOOL manualDarkModeEnabled;

@property (nonatomic, copy) NSArray<NSString *> *cachedSectionTitles;
@property (nonatomic, copy) NSArray<NSArray<NSString *> *> *cachedDataArray;

@end

@implementation AAListViewController

@synthesize tableView = _tableView;

#pragma mark - Life Cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    _enableThemeToggle = YES;
    _showHeaderCard = YES;
    _headerTitle = @"探索更丰富的高级图表示例";
    _headerSubtitle = @"精选多类图表，助你快速找到灵感。轻触任意卡片即可查看详细演示。";
    _cachedSectionTitles = @[];
    _cachedDataArray = @[];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self loadThemeSettings];
    [self setupNavigationBar];
    [self setupBackgroundGradient];
    [self configTheTableView];
    if (self.showHeaderCard) {
        self.tableView.tableHeaderView = [self buildTableHeaderView];
    }
    [self reloadData];
    [self applyTheme];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self applyTheme];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    if (self.backgroundGradientLayer) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.backgroundGradientLayer.frame = self.view.bounds;
        [CATransaction commit];
    }

    if (self.tableView.tableHeaderView) {
        UIView *headerView = self.tableView.tableHeaderView;
        [headerView setNeedsLayout];
        [headerView layoutIfNeeded];

        CGFloat height = [headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        CGRect headerFrame = headerView.frame;

        if (fabs(headerFrame.size.height - height) > 0.5) {
            headerFrame.size.height = height;
            headerView.frame = headerFrame;
            self.tableView.tableHeaderView = headerView;
        }
    }

    if (self.headerHaloLayer && self.tableHeaderCardView) {
        CGRect haloBounds = CGRectInset(self.tableHeaderCardView.bounds, 16.0, 16.0);
        UIBezierPath *haloPath = [UIBezierPath bezierPathWithRoundedRect:haloBounds
                                                             cornerRadius:MAX(self.tableHeaderCardView.layer.cornerRadius - 16.0, 8.0)];
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.headerHaloLayer.frame = self.tableHeaderCardView.bounds;
        self.headerHaloLayer.path = haloPath.CGPath;
        [CATransaction commit];
    }
}

#pragma mark - Property Setters

- (void)setEnableThemeToggle:(BOOL)enableThemeToggle {
    if (_enableThemeToggle == enableThemeToggle) { return; }
    _enableThemeToggle = enableThemeToggle;
    if (self.isViewLoaded) {
        [self setupNavigationBar];
    }
}

- (void)setShowHeaderCard:(BOOL)showHeaderCard {
    if (_showHeaderCard == showHeaderCard) { return; }
    _showHeaderCard = showHeaderCard;
    if (!self.isViewLoaded) { return; }

    if (showHeaderCard) {
        self.tableView.tableHeaderView = [self buildTableHeaderView];
    } else {
        self.tableView.tableHeaderView = nil;
        self.tableHeaderCardView = nil;
        self.headerCardGradientLayer = nil;
        self.headerGlassEffectView = nil;
        self.headerInnerBackgroundView = nil;
        self.headerChipViews = nil;
        self.headerChipLabels = nil;
        self.headerFloatingOrbView = nil;
        self.headerHaloLayer = nil;
    }
}

- (void)setHeaderTitle:(NSString *)headerTitle {
    _headerTitle = [headerTitle copy];
    self.headerTitleLabel.text = _headerTitle;
}

- (void)setHeaderSubtitle:(NSString *)headerSubtitle {
    _headerSubtitle = [headerSubtitle copy];
    self.headerSubtitleLabel.text = _headerSubtitle;
}

- (UITableView *)tableView {
    if (!_tableView) {
        [self configTheTableView];
    }
    return _tableView;
}

#pragma mark - Setup

- (void)setupNavigationBar {
    if (!self.navigationController) { return; }
    self.navigationController.navigationBar.prefersLargeTitles = NO;

    if (self.enableThemeToggle) {
        if (!self.themeToggleButton) {
            [self setupThemeToggleButton];
        } else {
            self.themeToggleButton.image = [self themeToggleButtonImage];
            self.navigationItem.rightBarButtonItem = self.themeToggleButton;
        }
    } else {
        self.navigationItem.rightBarButtonItem = nil;
        self.themeToggleButton = nil;
    }
}

- (void)configTheTableView {
    if (_tableView) { return; }

    UITableViewStyle style = UITableViewStyleGrouped;
    if (@available(iOS 13.0, *)) {
        style = UITableViewStyleInsetGrouped;
    }

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:style];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.contentInset = UIEdgeInsetsMake(20, 0, 40, 0);
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 80;
    tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    tableView.estimatedSectionHeaderHeight = 58;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 1)];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;

    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    backgroundView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = backgroundView;

    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }

    [self.view addSubview:tableView];
    [self.view addConstraints:[self configureTheConstraintArrayWithItem:tableView toItem:self.view]];

    _tableView = tableView;
}

- (NSArray *)configureTheConstraintArrayWithItem:(UIView *)view1 toItem:(UIView *)view2 {
    return  @[[NSLayoutConstraint constraintWithItem:view1
                                           attribute:NSLayoutAttributeLeft
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:view2
                                           attribute:NSLayoutAttributeLeft
                                          multiplier:1.0
                                            constant:0],
              [NSLayoutConstraint constraintWithItem:view1
                                           attribute:NSLayoutAttributeRight
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:view2
                                           attribute:NSLayoutAttributeRight
                                          multiplier:1.0
                                            constant:0],
              [NSLayoutConstraint constraintWithItem:view1
                                           attribute:NSLayoutAttributeTop
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:view2
                                           attribute:NSLayoutAttributeTop
                                          multiplier:1.0
                                            constant:0],
              [NSLayoutConstraint constraintWithItem:view1
                                           attribute:NSLayoutAttributeBottom
                                           relatedBy:NSLayoutRelationEqual
                                              toItem:view2
                                           attribute:NSLayoutAttributeBottom
                                          multiplier:1.0
                                            constant:0]];
}

- (void)setupBackgroundGradient {
    if (self.backgroundGradientLayer) { return; }

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[
        (__bridge id)AABackgroundLightStart.CGColor,
        (__bridge id)AABackgroundLightMid.CGColor,
        (__bridge id)AABackgroundLightEnd.CGColor
    ];
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.locations = @[@0.0, @0.5, @1.0];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.needsDisplayOnBoundsChange = YES;

    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    self.backgroundGradientLayer = gradientLayer;

    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"startPoint"];
    startAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.0, 0.0)];
    startAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.25, -0.15)];
    startAnimation.duration = 18.0;
    startAnimation.autoreverses = YES;
    startAnimation.repeatCount = HUGE_VALF;
    startAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    startAnimation.removedOnCompletion = NO;
    [gradientLayer addAnimation:startAnimation forKey:@"aa.background.startPoint"];

    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"endPoint"];
    endAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.0, 1.0)];
    endAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.8, 1.2)];
    endAnimation.duration = 18.0;
    endAnimation.autoreverses = YES;
    endAnimation.repeatCount = HUGE_VALF;
    endAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    endAnimation.removedOnCompletion = NO;
    [gradientLayer addAnimation:endAnimation forKey:@"aa.background.endPoint"];
}

- (UIView *)buildTableHeaderView {
    if (!self.showHeaderCard) { return nil; }

    UIView *headerView = [[UIView alloc] init];
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    headerView.backgroundColor = [UIColor clearColor];
    BOOL isDarkMode = [self isDarkMode];

    UIView *cardView = [[UIView alloc] init];
    cardView.translatesAutoresizingMaskIntoConstraints = NO;
    cardView.backgroundColor = AALightDarkColor([[UIColor whiteColor] colorWithAlphaComponent:0.18], [[UIColor blackColor] colorWithAlphaComponent:0.28]);
    cardView.layer.cornerRadius = 26.0;
    cardView.layer.masksToBounds = NO;
    cardView.layer.shadowColor = (isDarkMode ? [UIColor blackColor] : ColorWithRGB(90, 120, 180, 1)).CGColor;
    cardView.layer.shadowOpacity = isDarkMode ? 0.35 : 0.22;
    cardView.layer.shadowOffset = CGSizeMake(0, 18);
    cardView.layer.shadowRadius = 28.0;
    [headerView addSubview:cardView];

    self.tableHeaderCardView = cardView;

    CAGradientLayer *cardGradient = [CAGradientLayer layer];
    cardGradient.name = @"header.card.gradient";
    cardGradient.colors = @[
        (__bridge id)AALightDarkColor(ColorWithRGB(255, 179, 120, 1), ColorWithRGB(104, 62, 48, 1)).CGColor,
        (__bridge id)AALightDarkColor(ColorWithRGB(255, 204, 143, 1), ColorWithRGB(129, 72, 55, 1)).CGColor,
        (__bridge id)AALightDarkColor(ColorWithRGB(255, 188, 170, 1), ColorWithRGB(140, 76, 82, 1)).CGColor
    ];
    cardGradient.locations = @[@0.0, @0.55, @1.0];
    cardGradient.startPoint = CGPointMake(0.0, 0.0);
    cardGradient.endPoint = CGPointMake(1.0, 1.0);
    cardGradient.cornerRadius = cardView.layer.cornerRadius;
    cardGradient.frame = cardView.bounds;
    cardGradient.masksToBounds = YES;
    [cardView.layer insertSublayer:cardGradient atIndex:0];
    self.headerCardGradientLayer = cardGradient;

    UIVisualEffect *glassEffect = nil;
    if (@available(iOS 13.0, *)) {
        glassEffect = [UIBlurEffect effectWithStyle:isDarkMode ? UIBlurEffectStyleSystemThinMaterialDark : UIBlurEffectStyleSystemThinMaterialLight];
    } else {
        glassEffect = [UIBlurEffect effectWithStyle:isDarkMode ? UIBlurEffectStyleDark : UIBlurEffectStyleExtraLight];
    }

    UIVisualEffectView *glassView = [[UIVisualEffectView alloc] initWithEffect:glassEffect];
    glassView.translatesAutoresizingMaskIntoConstraints = NO;
    glassView.userInteractionEnabled = NO;
    glassView.layer.cornerRadius = cardView.layer.cornerRadius;
    glassView.layer.masksToBounds = YES;
    [cardView addSubview:glassView];
    self.headerGlassEffectView = glassView;

    UIView *contentContainer = [[UIView alloc] init];
    contentContainer.translatesAutoresizingMaskIntoConstraints = NO;
    contentContainer.backgroundColor = [UIColor clearColor];
    contentContainer.layer.cornerRadius = cardView.layer.cornerRadius;
    contentContainer.layer.masksToBounds = NO;
    [glassView.contentView addSubview:contentContainer];

    UIView *innerBackground = [[UIView alloc] init];
    innerBackground.translatesAutoresizingMaskIntoConstraints = NO;
    innerBackground.backgroundColor = AALightDarkColor(ColorWithRGB(255, 255, 255, 0.18), ColorWithRGB(60, 40, 36, 0.28));
    innerBackground.layer.cornerRadius = cardView.layer.cornerRadius;
    innerBackground.layer.masksToBounds = YES;
    innerBackground.userInteractionEnabled = NO;
    [contentContainer addSubview:innerBackground];
    [contentContainer sendSubviewToBack:innerBackground];
    self.headerInnerBackgroundView = innerBackground;

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.numberOfLines = 0;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:27.0 weight:UIFontWeightBold];
    titleLabel.text = self.headerTitle;
    [contentContainer addSubview:titleLabel];
    self.headerTitleLabel = titleLabel;

    UILabel *subtitleLabel = [[UILabel alloc] init];
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    subtitleLabel.numberOfLines = 0;
    subtitleLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.80];
    subtitleLabel.font = [UIFont systemFontOfSize:15.5 weight:UIFontWeightMedium];
    subtitleLabel.text = self.headerSubtitle;
    [contentContainer addSubview:subtitleLabel];
    self.headerSubtitleLabel = subtitleLabel;

    UIStackView *chipStack = [[UIStackView alloc] init];
    chipStack.translatesAutoresizingMaskIntoConstraints = NO;
    chipStack.axis = UILayoutConstraintAxisHorizontal;
    chipStack.alignment = UIStackViewAlignmentCenter;
    chipStack.spacing = 14.0;
    chipStack.distribution = UIStackViewDistributionFillProportionally;
    [contentContainer addSubview:chipStack];

    NSArray<NSString *> *chipTitles = @[@"✨ 交互体验", @"📊 数据探索", @"⚡️ 高性能渲染"];
    NSMutableArray<UIView *> *chipViews = [NSMutableArray array];
    NSMutableArray<UILabel *> *chipLabels = [NSMutableArray array];
    [chipTitles enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *chip = [self buildHeaderChipViewWithText:obj index:idx];
        UILabel *label = chip.subviews.firstObject;
        if (label) {
            [chipLabels addObject:label];
        }
        [chipStack addArrangedSubview:chip];
        [chipViews addObject:chip];
    }];
    self.headerChipViews = [chipViews copy];
    self.headerChipLabels = [chipLabels copy];

    UIView *floatingOrb = [[UIView alloc] init];
    floatingOrb.translatesAutoresizingMaskIntoConstraints = NO;
    floatingOrb.backgroundColor = AALightDarkColor(ColorWithRGB(255, 213, 153, 0.42), ColorWithRGB(148, 90, 60, 0.52));
    floatingOrb.layer.cornerRadius = 36.0;
    floatingOrb.layer.shadowColor = AALightDarkColor(ColorWithRGB(255, 191, 140, 1), ColorWithRGB(200, 120, 78, 1)).CGColor;
    floatingOrb.layer.shadowOpacity = 0.48;
    floatingOrb.layer.shadowOffset = CGSizeZero;
    floatingOrb.layer.shadowRadius = 20.0;
    floatingOrb.userInteractionEnabled = NO;
    [cardView insertSubview:floatingOrb belowSubview:glassView];
    [self applyFloatingAnimationToView:floatingOrb amplitude:9.0 duration:5.0];
    self.headerFloatingOrbView = floatingOrb;

    CAShapeLayer *haloLayer = [CAShapeLayer layer];
    haloLayer.name = @"header.halo.layer";
    haloLayer.fillColor = [UIColor clearColor].CGColor;
    haloLayer.strokeColor = ColorWithRGB(255, 255, 255, isDarkMode ? 0.16 : 0.28).CGColor;
    haloLayer.lineWidth = 1.4;
    haloLayer.lineDashPattern = @[@6, @8];
    haloLayer.shadowColor = ColorWithRGB(255, 182, 135, 1).CGColor;
    haloLayer.shadowOpacity = isDarkMode ? 0.58 : 0.32;
    haloLayer.shadowOffset = CGSizeZero;
    haloLayer.shadowRadius = 18.0;
    [cardView.layer addSublayer:haloLayer];
    [self applyBreathingAnimationToLayer:haloLayer from:0.25 to:0.55 duration:3.6];
    self.headerHaloLayer = haloLayer;

    [NSLayoutConstraint activateConstraints:@[
        [cardView.topAnchor constraintEqualToAnchor:headerView.topAnchor constant:28.0],
        [cardView.bottomAnchor constraintEqualToAnchor:headerView.bottomAnchor constant:-12.0],
        [cardView.leadingAnchor constraintEqualToAnchor:headerView.leadingAnchor constant:20.0],
        [cardView.trailingAnchor constraintEqualToAnchor:headerView.trailingAnchor constant:-20.0],

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

    return headerView;
}

#pragma mark - Data Handling

- (void)reloadData {
    NSArray<NSString *> *sectionTitles = @[];
    NSArray<NSArray<NSString *> *> *dataArray = @[];

    if (self.dataSource) {
        NSInteger sectionCount = [self.dataSource numberOfSectionsInListView:self];
        NSArray<NSString *> *titles = [self.dataSource sectionTitlesForListView:self];
        NSArray<NSArray<NSString *> *> *data = [self.dataSource dataArrayForListView:self];

        if (sectionCount > 0 && titles.count == sectionCount) {
            sectionTitles = titles;
        } else {
            sectionTitles = titles ?: @[];
        }

        dataArray = data ?: @[];
    }

    self.cachedSectionTitles = sectionTitles;
    self.cachedDataArray = dataArray;

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.cachedSectionTitles.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section >= self.cachedDataArray.count) {
        return 0;
    }
    return self.cachedDataArray[section].count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 58.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor clearColor];

    BOOL isDarkMode = [self isDarkMode];

    UIView *backdropView = [[UIView alloc] init];
    backdropView.translatesAutoresizingMaskIntoConstraints = NO;
    backdropView.layer.cornerRadius = kSectionHeaderCornerRadius;
    backdropView.layer.masksToBounds = NO;

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    if (isDarkMode) {
        gradientLayer.colors = @[
            (__bridge id)ColorWithRGB(66, 44, 48, 1).CGColor,
            (__bridge id)ColorWithRGB(80, 52, 40, 1).CGColor,
            (__bridge id)ColorWithRGB(58, 38, 33, 1).CGColor
        ];
        backdropView.layer.shadowColor = [UIColor blackColor].CGColor;
        backdropView.layer.shadowOpacity = 0.48;
        backdropView.layer.shadowOffset = CGSizeMake(0, 8);
        backdropView.layer.shadowRadius = 20.0;
        backdropView.layer.borderWidth = 0.5;
        backdropView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.18].CGColor;
    } else {
        gradientLayer.colors = @[
            (__bridge id)ColorWithRGB(255, 247, 239, 1).CGColor,
            (__bridge id)ColorWithRGB(255, 235, 222, 1).CGColor
        ];
        backdropView.layer.shadowColor = ColorWithRGB(205, 170, 130, 0.34).CGColor;
        backdropView.layer.shadowOpacity = 0.28;
        backdropView.layer.shadowOffset = CGSizeMake(0, 4);
        backdropView.layer.shadowRadius = 12.0;
        backdropView.layer.borderWidth = 0.8;
        backdropView.layer.borderColor = ColorWithRGB(248, 216, 190, 1).CGColor;
        backdropView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.90];
    }

    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.frame = backdropView.bounds;
    gradientLayer.cornerRadius = backdropView.layer.cornerRadius;
    gradientLayer.masksToBounds = YES;
    [backdropView.layer insertSublayer:gradientLayer atIndex:0];
    [containerView addSubview:backdropView];

    UIView *accentView = [[UIView alloc] init];
    accentView.translatesAutoresizingMaskIntoConstraints = NO;

    UIColor *accentColor = [self accentColorForSection:section darkMode:isDarkMode];

    if (isDarkMode) {
        accentView.backgroundColor = accentColor;
        accentView.layer.shadowColor = accentColor.CGColor;
        accentView.layer.shadowOpacity = 0.8;
        accentView.layer.shadowOffset = CGSizeMake(0, 0);
        accentView.layer.shadowRadius = 6.0;
    } else {
        accentView.backgroundColor = accentColor;
        accentView.layer.shadowColor = accentColor.CGColor;
        accentView.layer.shadowOpacity = 0.35;
        accentView.layer.shadowOffset = CGSizeMake(0, 2);
        accentView.layer.shadowRadius = 5.0;
    }

    accentView.layer.cornerRadius = 3.0;
    accentView.layer.masksToBounds = NO;
    [backdropView addSubview:accentView];

    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:16.0 weight:UIFontWeightSemibold];
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 0.9;
    label.textColor = isDarkMode ? [UIColor colorWithWhite:0.95 alpha:1.0] : ColorWithRGB(118, 82, 62, 1);
    label.text = [self titleForSection:section];
    [backdropView addSubview:label];

    [NSLayoutConstraint activateConstraints:@[
        [backdropView.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor constant:18.0],
        [backdropView.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor constant:-18.0],
        [backdropView.topAnchor constraintEqualToAnchor:containerView.topAnchor constant:6.0],
        [backdropView.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor constant:-6.0],

        [accentView.widthAnchor constraintEqualToConstant:6.0],
        [accentView.heightAnchor constraintEqualToConstant:24.0],
        [accentView.leadingAnchor constraintEqualToAnchor:backdropView.leadingAnchor constant:16.0],
        [accentView.centerYAnchor constraintEqualToAnchor:backdropView.centerYAnchor],

        [label.leadingAnchor constraintEqualToAnchor:accentView.trailingAnchor constant:12.0],
        [label.trailingAnchor constraintEqualToAnchor:backdropView.trailingAnchor constant:-20.0],
        [label.centerYAnchor constraintEqualToAnchor:backdropView.centerYAnchor]
    ]];

    return containerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == self.cachedSectionTitles.count - 1 ? 32.0 : 16.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *listTitles = [[NSMutableArray alloc] init];
    for (NSString *item in self.cachedSectionTitles) {
        if (item.length > 0) {
            NSString *title = [item substringToIndex:1];
            [listTitles addObject:title];
        }
    }
    return listTitles;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.hidden = YES;

    UIView *cardView = [cell.contentView viewWithTag:1001];
    UILabel *titleLabel = nil;
    UILabel *subtitleLabel = nil;
    UILabel *badgeLabel = nil;
    UIImageView *chevronImageView = nil;

    if (!cardView) {
        NSUInteger colorIndex = indexPath.section % 6;
        BOOL isDarkMode = [self isDarkMode];
        UIColor *badgeColor = [self accentColorForSection:indexPath.section darkMode:isDarkMode];

        cardView = [[UIView alloc] init];
        cardView.tag = 1001;
        cardView.translatesAutoresizingMaskIntoConstraints = NO;
        cardView.backgroundColor = [UIColor clearColor];
        cardView.layer.cornerRadius = kCardCornerRadius;
        cardView.layer.shadowColor = [UIColor blackColor].CGColor;
        cardView.layer.shadowOpacity = 0.18;
        cardView.layer.shadowOffset = CGSizeMake(0, 10);
        cardView.layer.shadowRadius = 16.0;
        cardView.layer.masksToBounds = NO;
        [cell.contentView addSubview:cardView];

        [NSLayoutConstraint activateConstraints:@[
            [cardView.leadingAnchor constraintEqualToAnchor:cell.contentView.leadingAnchor constant:18.0],
            [cardView.trailingAnchor constraintEqualToAnchor:cell.contentView.trailingAnchor constant:-18.0],
            [cardView.topAnchor constraintEqualToAnchor:cell.contentView.topAnchor constant:8.0],
            [cardView.bottomAnchor constraintEqualToAnchor:cell.contentView.bottomAnchor constant:-8.0]
        ]];

        UIVisualEffect *blurEffect = nil;
        if (@available(iOS 13.0, *)) {
            blurEffect = [UIBlurEffect effectWithStyle:isDarkMode ? UIBlurEffectStyleSystemThinMaterialDark : UIBlurEffectStyleSystemThinMaterialLight];
        } else {
            blurEffect = [UIBlurEffect effectWithStyle:isDarkMode ? UIBlurEffectStyleDark : UIBlurEffectStyleExtraLight];
        }

        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurView.tag = 1006;
        blurView.frame = cardView.bounds;
        blurView.userInteractionEnabled = NO;
        blurView.layer.cornerRadius = cardView.layer.cornerRadius;
        blurView.layer.masksToBounds = YES;
        [cardView addSubview:blurView];

        [self updateBlurEffectView:blurView];

        UIView *backgroundOverlay = [[UIView alloc] init];
        backgroundOverlay.tag = 1007;
        backgroundOverlay.translatesAutoresizingMaskIntoConstraints = NO;
        backgroundOverlay.layer.cornerRadius = cardView.layer.cornerRadius;
        backgroundOverlay.layer.masksToBounds = YES;
        backgroundOverlay.backgroundColor = [UIColor clearColor];
        [cardView addSubview:backgroundOverlay];

        [NSLayoutConstraint activateConstraints:@[
            [backgroundOverlay.leadingAnchor constraintEqualToAnchor:cardView.leadingAnchor],
            [backgroundOverlay.trailingAnchor constraintEqualToAnchor:cardView.trailingAnchor],
            [backgroundOverlay.topAnchor constraintEqualToAnchor:cardView.topAnchor],
            [backgroundOverlay.bottomAnchor constraintEqualToAnchor:cardView.bottomAnchor]
        ]];

        [self updateCardGradientInView:backgroundOverlay];

        UIView *contentContainer = [[UIView alloc] init];
        contentContainer.translatesAutoresizingMaskIntoConstraints = NO;
        contentContainer.backgroundColor = [UIColor clearColor];
        [cardView addSubview:contentContainer];

        [NSLayoutConstraint activateConstraints:@[
            [contentContainer.leadingAnchor constraintEqualToAnchor:cardView.leadingAnchor constant:20.0],
            [contentContainer.trailingAnchor constraintEqualToAnchor:cardView.trailingAnchor constant:-20.0],
            [contentContainer.topAnchor constraintEqualToAnchor:cardView.topAnchor constant:14.0],
            [contentContainer.bottomAnchor constraintEqualToAnchor:cardView.bottomAnchor constant:-14.0]
        ]];

        badgeLabel = [[UILabel alloc] init];
        badgeLabel.tag = 1002;
        badgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        badgeLabel.textAlignment = NSTextAlignmentCenter;
        badgeLabel.font = [UIFont monospacedDigitSystemFontOfSize:13.0 weight:UIFontWeightBold];
        badgeLabel.textColor = [UIColor whiteColor];
        badgeLabel.layer.cornerRadius = kBadgeCornerRadius;
        badgeLabel.layer.masksToBounds = YES;
        badgeLabel.backgroundColor = badgeColor;
        badgeLabel.layer.shadowColor = badgeColor.CGColor;
        badgeLabel.layer.shadowOpacity = 0.4;
        badgeLabel.layer.shadowOffset = CGSizeMake(0, 2);
        badgeLabel.layer.shadowRadius = 6.0;
        [contentContainer addSubview:badgeLabel];

        titleLabel = [[UILabel alloc] init];
        titleLabel.tag = 1003;
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        titleLabel.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold];
        titleLabel.textColor = isDarkMode ? [UIColor colorWithWhite:0.95 alpha:1.0] : [UIColor colorWithWhite:0.1 alpha:1.0];
        titleLabel.numberOfLines = 1;
        [contentContainer addSubview:titleLabel];

        subtitleLabel = [[UILabel alloc] init];
        subtitleLabel.tag = 1004;
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        subtitleLabel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
        subtitleLabel.textColor = isDarkMode ? [UIColor colorWithWhite:0.7 alpha:1.0] : ColorWithRGB(156, 113, 95, 1);
        subtitleLabel.numberOfLines = 0;
        [contentContainer addSubview:subtitleLabel];

        chevronImageView = [[UIImageView alloc] init];
        chevronImageView.tag = 1005;
        chevronImageView.translatesAutoresizingMaskIntoConstraints = NO;
        chevronImageView.contentMode = UIViewContentModeScaleAspectFit;
        chevronImageView.tintColor = isDarkMode ? [UIColor colorWithWhite:0.7 alpha:1.0] : ColorWithRGB(173, 131, 113, 1);
        chevronImageView.image = [UIImage imageNamed:@"icon_arrow_right"];
        if (!chevronImageView.image) {
            chevronImageView.image = [self fallbackChevronImage];
        }
        [contentContainer addSubview:chevronImageView];

        [NSLayoutConstraint activateConstraints:@[
            [badgeLabel.widthAnchor constraintEqualToConstant:30.0],
            [badgeLabel.heightAnchor constraintEqualToConstant:30.0],
            [badgeLabel.leadingAnchor constraintEqualToAnchor:contentContainer.leadingAnchor],
            [badgeLabel.centerYAnchor constraintEqualToAnchor:contentContainer.centerYAnchor],

            [chevronImageView.widthAnchor constraintEqualToConstant:16.0],
            [chevronImageView.heightAnchor constraintEqualToConstant:16.0],
            [chevronImageView.trailingAnchor constraintEqualToAnchor:contentContainer.trailingAnchor],
            [chevronImageView.centerYAnchor constraintEqualToAnchor:contentContainer.centerYAnchor],

            [titleLabel.leadingAnchor constraintEqualToAnchor:badgeLabel.trailingAnchor constant:14.0],
            [titleLabel.trailingAnchor constraintEqualToAnchor:chevronImageView.leadingAnchor constant:-14.0],
            [titleLabel.topAnchor constraintEqualToAnchor:contentContainer.topAnchor],

            [subtitleLabel.leadingAnchor constraintEqualToAnchor:titleLabel.leadingAnchor],
            [subtitleLabel.trailingAnchor constraintEqualToAnchor:titleLabel.trailingAnchor],
            [subtitleLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:6.0],
            [subtitleLabel.bottomAnchor constraintLessThanOrEqualToAnchor:contentContainer.bottomAnchor]
        ]];
    } else {
        badgeLabel = [cardView viewWithTag:1002];
        titleLabel = [cardView viewWithTag:1003];
        subtitleLabel = [cardView viewWithTag:1004];
        chevronImageView = [cardView viewWithTag:1005];
        UIVisualEffectView *blurView = [cardView viewWithTag:1006];
        if (blurView) {
            [self updateBlurEffectView:blurView];
        }
        UIView *backgroundOverlay = [cardView viewWithTag:1007];
        if (backgroundOverlay) {
            [self updateCardGradientInView:backgroundOverlay];
        }

        NSUInteger colorIndex = indexPath.section % 6;
        BOOL isDarkMode = [self isDarkMode];
        UIColor *badgeColor = [self accentColorForSection:indexPath.section darkMode:isDarkMode];

        badgeLabel.backgroundColor = badgeColor;
        badgeLabel.layer.shadowColor = badgeColor.CGColor;
        badgeLabel.layer.shadowOpacity = 0.4;
        badgeLabel.layer.shadowOffset = CGSizeMake(0, 2);
        badgeLabel.layer.shadowRadius = 6.0;

        if (isDarkMode) {
            titleLabel.textColor = [UIColor colorWithWhite:0.95 alpha:1.0];
            subtitleLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
            chevronImageView.tintColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        } else {
            titleLabel.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
            subtitleLabel.textColor = ColorWithRGB(156, 113, 95, 1);
            chevronImageView.tintColor = ColorWithRGB(173, 131, 113, 1);
        }
    }

    NSString *fullTitle = nil;
    if (indexPath.section < self.cachedDataArray.count) {
        NSArray<NSString *> *sectionData = self.cachedDataArray[indexPath.section];
        if (indexPath.row < sectionData.count) {
            fullTitle = sectionData[indexPath.row];
        }
    }

    NSArray<NSString *> *components = [fullTitle componentsSeparatedByString:@"---"];
    NSString *primaryTitle = components.firstObject ?: @"";
    NSMutableArray<NSString *> *secondaryParts = components.count > 1 ? [[components subarrayWithRange:NSMakeRange(1, components.count - 1)] mutableCopy] : nil;
    NSString *secondaryTitle = secondaryParts.count ? [secondaryParts componentsJoinedByString:@" · "] : @"探索这个图表";

    badgeLabel.text = [NSString stringWithFormat:@"%02ld", (long)indexPath.row + 1];
    titleLabel.text = primaryTitle;
    subtitleLabel.text = secondaryTitle;
    chevronImageView.alpha = 0.8;

    [self applyThemeToCardView:cardView];

    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if ([self.delegate respondsToSelector:@selector(listView:didSelectRowAtIndexPath:)]) {
        [self.delegate listView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView *cardView = [cell.contentView viewWithTag:1001];
    if (!cardView) { return; }

    CGFloat baseOpacity = [self cardShadowBaseOpacity];

    [UIView animateWithDuration:kAnimationDurationFast
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        cardView.transform = CGAffineTransformMakeScale(kCardPressScale, kCardPressScale);
        cardView.layer.shadowOpacity = MAX(baseOpacity * 0.5, 0.05f);
        cardView.alpha = 0.92;
    } completion:nil];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView *cardView = [cell.contentView viewWithTag:1001];
    if (!cardView) { return; }

    CGFloat baseOpacity = [self cardShadowBaseOpacity];

    [UIView animateWithDuration:0.4
                          delay:0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.8
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        cardView.transform = CGAffineTransformIdentity;
        cardView.layer.shadowOpacity = baseOpacity;
        cardView.alpha = 1.0;
    } completion:nil];
}

#pragma mark - Theme Support

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if (@available(iOS 13.0, *)) {
        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
            if (!self.hasManualThemeOverride) {
                [self applyTheme];
            }
        }
    }
}

- (BOOL)isDarkMode {
    if (self.hasManualThemeOverride) {
        return self.manualDarkModeEnabled;
    }
    if (@available(iOS 13.0, *)) {
        return self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
    }
    return NO;
}

- (void)applyTheme {
    BOOL isDarkMode = [self isDarkMode];

    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        [appearance configureWithOpaqueBackground];
        appearance.backgroundColor = isDarkMode ? [UIColor colorWithRed:18/255.0 green:20/255.0 blue:28/255.0 alpha:1.0] : [UIColor whiteColor];
        appearance.titleTextAttributes = @{NSForegroundColorAttributeName: isDarkMode ? [UIColor whiteColor] : [UIColor blackColor]};
        appearance.shadowColor = [UIColor clearColor];
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    } else {
        self.navigationController.navigationBar.barTintColor = isDarkMode ? [UIColor colorWithRed:18/255.0 green:20/255.0 blue:28/255.0 alpha:1.0] : [UIColor whiteColor];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: isDarkMode ? [UIColor whiteColor] : [UIColor blackColor]};
    }

    [self updateBackgroundGradient];

    if (self.tableHeaderCardView) {
        [self updateHeaderViewTheme];
    }

    if (self.themeToggleButton) {
        self.themeToggleButton.image = [self themeToggleButtonImage];
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)updateBackgroundGradient {
    if (!self.backgroundGradientLayer) return;

    BOOL isDarkMode = [self isDarkMode];

    NSArray *colors = nil;
    if (isDarkMode) {
        colors = @[
            (__bridge id)AABackgroundDarkStart.CGColor,
            (__bridge id)AABackgroundDarkMid.CGColor,
            (__bridge id)AABackgroundDarkEnd.CGColor
        ];
    } else {
        colors = @[
            (__bridge id)AABackgroundLightStart.CGColor,
            (__bridge id)AABackgroundLightMid.CGColor,
            (__bridge id)AABackgroundLightEnd.CGColor
        ];
    }

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.fromValue = self.backgroundGradientLayer.colors;
    animation.toValue = colors;
    animation.duration = 0.4;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.backgroundGradientLayer addAnimation:animation forKey:@"colorsChange"];

    self.backgroundGradientLayer.colors = colors;
}

- (void)updateHeaderViewTheme {
    if (!self.headerCardGradientLayer) return;

    BOOL isDarkMode = [self isDarkMode];

    NSArray *colors = nil;
    if (isDarkMode) {
        colors = @[
            (__bridge id)ColorWithRGB(120, 76, 60, 1).CGColor,
            (__bridge id)ColorWithRGB(138, 86, 70, 1).CGColor,
            (__bridge id)ColorWithRGB(162, 98, 92, 1).CGColor
        ];
    } else {
        colors = @[
            (__bridge id)ColorWithRGB(255, 188, 145, 1).CGColor,
            (__bridge id)ColorWithRGB(255, 209, 162, 1).CGColor,
            (__bridge id)ColorWithRGB(255, 195, 183, 1).CGColor
        ];
    }

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.fromValue = self.headerCardGradientLayer.colors;
    animation.toValue = colors;
    animation.duration = 0.4;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.headerCardGradientLayer addAnimation:animation forKey:@"headerColorsChange"];

    self.headerCardGradientLayer.colors = colors;

    if (self.tableHeaderCardView) {
        self.tableHeaderCardView.backgroundColor = AALightDarkColor([[UIColor whiteColor] colorWithAlphaComponent:0.18], [[UIColor blackColor] colorWithAlphaComponent:0.28]);
        self.tableHeaderCardView.layer.shadowColor = (isDarkMode ? [UIColor blackColor] : ColorWithRGB(210, 170, 120, 1)).CGColor;
        self.tableHeaderCardView.layer.shadowOpacity = isDarkMode ? 0.36 : 0.24;
        self.tableHeaderCardView.layer.shadowRadius = isDarkMode ? 34.0 : 28.0;
        self.tableHeaderCardView.layer.shadowOffset = CGSizeMake(0, isDarkMode ? 20.0 : 16.0);
        self.tableHeaderCardView.layer.borderWidth = isDarkMode ? 0.6 : 0.0;
        self.tableHeaderCardView.layer.borderColor = isDarkMode ? ColorWithRGB(255, 200, 160, 0.20).CGColor : [UIColor clearColor].CGColor;
    }

    if (self.headerGlassEffectView) {
        UIVisualEffect *newEffect = nil;
        if (@available(iOS 13.0, *)) {
            newEffect = [UIBlurEffect effectWithStyle:isDarkMode ? UIBlurEffectStyleSystemThinMaterialDark : UIBlurEffectStyleSystemThinMaterialLight];
        } else {
            newEffect = [UIBlurEffect effectWithStyle:isDarkMode ? UIBlurEffectStyleDark : UIBlurEffectStyleExtraLight];
        }
        self.headerGlassEffectView.effect = newEffect;
    }

    if (self.headerInnerBackgroundView) {
        self.headerInnerBackgroundView.backgroundColor = AALightDarkColor(ColorWithRGB(255, 255, 255, 0.18), ColorWithRGB(60, 40, 36, 0.28));
    }

    if (self.headerTitleLabel) {
        self.headerTitleLabel.textColor = isDarkMode ? [UIColor colorWithWhite:0.96 alpha:1.0] : [UIColor colorWithWhite:1.0 alpha:0.98];
    }

    if (self.headerSubtitleLabel) {
        self.headerSubtitleLabel.textColor = isDarkMode ? [[UIColor whiteColor] colorWithAlphaComponent:0.74] : [[UIColor whiteColor] colorWithAlphaComponent:0.90];
    }

    [self.headerChipViews enumerateObjectsUsingBlock:^(UIView * _Nonnull chipView, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray *chipColors = [self chipGradientColorsForIndex:idx darkMode:isDarkMode];
        [self updateGradientLayerInView:chipView named:@"chip.gradient" colors:chipColors];
        chipView.layer.borderColor = isDarkMode ? ColorWithRGB(242, 184, 150, 0.26).CGColor : ColorWithRGB(255, 215, 190, 0.7).CGColor;
        chipView.layer.borderWidth = isDarkMode ? 0.8 : 0.6;
        chipView.layer.shadowColor = isDarkMode ? ColorWithRGB(206, 132, 96, 1).CGColor : ColorWithRGB(255, 186, 140, 1).CGColor;
        chipView.layer.shadowOpacity = isDarkMode ? 0.42 : 0.30;
        chipView.layer.shadowOffset = CGSizeZero;
        chipView.layer.shadowRadius = 8.0;
    }];

    [self.headerChipLabels enumerateObjectsUsingBlock:^(UILabel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.textColor = isDarkMode ? [UIColor colorWithWhite:0.94 alpha:1.0] : [UIColor colorWithWhite:1.0 alpha:0.95];
    }];

    if (self.headerFloatingOrbView) {
        self.headerFloatingOrbView.backgroundColor = AALightDarkColor(ColorWithRGB(255, 213, 153, 0.42), ColorWithRGB(148, 90, 60, 0.52));
        self.headerFloatingOrbView.layer.shadowColor = (isDarkMode ? ColorWithRGB(210, 130, 88, 1) : ColorWithRGB(255, 191, 140, 1)).CGColor;
        self.headerFloatingOrbView.layer.shadowOpacity = isDarkMode ? 0.64 : 0.48;
    }

    if (self.headerHaloLayer) {
        self.headerHaloLayer.strokeColor = isDarkMode ? ColorWithRGB(255, 204, 170, 0.20).CGColor : ColorWithRGB(255, 255, 255, 0.28).CGColor;
        self.headerHaloLayer.shadowColor = (isDarkMode ? ColorWithRGB(218, 140, 98, 1) : ColorWithRGB(255, 186, 135, 1)).CGColor;
        self.headerHaloLayer.shadowOpacity = isDarkMode ? 0.58 : 0.34;
    }
}

- (void)applyThemeToCardView:(UIView *)cardView {
    if (!cardView) return;

    BOOL isDarkMode = [self isDarkMode];
    CGFloat shadowOpacity = [self cardShadowBaseOpacity];

    cardView.layer.shadowOpacity = shadowOpacity;

    if (isDarkMode) {
        cardView.layer.shadowColor = [UIColor blackColor].CGColor;
        cardView.layer.shadowRadius = 18.0;
        cardView.layer.shadowOffset = CGSizeMake(0, 12);
        cardView.layer.borderWidth = 0.5;
        cardView.layer.borderColor = ColorWithRGB(255, 200, 160, 0.20).CGColor;
    } else {
        cardView.layer.shadowColor = ColorWithRGB(210, 170, 130, 0.4).CGColor;
        cardView.layer.shadowRadius = 16.0;
        cardView.layer.shadowOffset = CGSizeMake(0, 10);
        cardView.layer.borderWidth = 0;
        cardView.layer.borderColor = [UIColor clearColor].CGColor;
    }

    UIView *overlayView = [cardView viewWithTag:1007];
    if (overlayView) {
        [self updateCardGradientInView:overlayView];
    }
}

- (void)updateBlurEffectView:(UIVisualEffectView *)blurView {
    if (!blurView) return;

    BOOL isDarkMode = [self isDarkMode];
    UIVisualEffect *newEffect = nil;

    if (@available(iOS 13.0, *)) {
        newEffect = [UIBlurEffect effectWithStyle:isDarkMode ? UIBlurEffectStyleSystemThinMaterialDark : UIBlurEffectStyleSystemThinMaterialLight];
    } else {
        newEffect = [UIBlurEffect effectWithStyle:isDarkMode ? UIBlurEffectStyleDark : UIBlurEffectStyleExtraLight];
    }

    blurView.effect = newEffect;
}

- (CGFloat)cardShadowBaseOpacity {
    return [self isDarkMode] ? 0.45f : 0.20f;
}

#pragma mark - Design Helpers

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

- (void)updateCardGradientInView:(UIView *)overlayView {
    if (!overlayView) { return; }
    BOOL isDarkMode = [self isDarkMode];
    NSArray *colors = [self cardGradientColorsForDarkMode:isDarkMode];
    [self updateGradientLayerInView:overlayView named:@"card.overlay.gradient" colors:colors];
    overlayView.layer.borderWidth = isDarkMode ? 0.6 : 0.8;
    overlayView.layer.borderColor = isDarkMode ? ColorWithRGB(210, 150, 120, 0.22).CGColor : ColorWithRGB(255, 213, 190, 0.55).CGColor;
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
        targetLayer.frame = view.bounds;
        targetLayer.cornerRadius = view.layer.cornerRadius;
        targetLayer.startPoint = CGPointMake(0.0, 0.0);
        targetLayer.endPoint = CGPointMake(1.0, 1.0);
        targetLayer.needsDisplayOnBoundsChange = YES;
        targetLayer.masksToBounds = YES;
        [view.layer insertSublayer:targetLayer atIndex:0];
    }
    targetLayer.colors = colors;
    targetLayer.locations = nil;
}

- (UIView *)buildHeaderChipViewWithText:(NSString *)text index:(NSUInteger)index {
    UIView *chipView = [[UIView alloc] init];
    chipView.translatesAutoresizingMaskIntoConstraints = NO;
    chipView.backgroundColor = [UIColor clearColor];
    chipView.layer.cornerRadius = 18.0;
    chipView.layer.masksToBounds = NO;
    chipView.layer.borderWidth = 0.0;

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

    NSArray *colors = [self chipGradientColorsForIndex:index darkMode:[self isDarkMode]];
    [self updateGradientLayerInView:chipView named:@"chip.gradient" colors:colors];

    return chipView;
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

- (NSString *)titleForSection:(NSInteger)section {
    if ([self.delegate respondsToSelector:@selector(listView:titleForHeaderInSection:)]) {
        NSString *custom = [self.delegate listView:self titleForHeaderInSection:section];
        if (custom.length > 0) {
            return custom;
        }
    }
    if (section < self.cachedSectionTitles.count) {
        return self.cachedSectionTitles[section];
    }
    return @"";
}

- (UIColor *)accentColorForSection:(NSUInteger)section darkMode:(BOOL)isDarkMode {
    NSArray<UIColor *> *accentColorsLight = @[
        ColorWithRGB(255, 138, 101, 1),
        ColorWithRGB(255, 199, 95, 1),
        ColorWithRGB(255, 163, 190, 1),
        ColorWithRGB(116, 205, 255, 1),
        ColorWithRGB(178, 130, 255, 1),
        ColorWithRGB(163, 255, 120, 1)
    ];
    NSArray<UIColor *> *accentColorsDark = @[
        ColorWithRGB(255, 171, 145, 1),
        ColorWithRGB(255, 204, 143, 1),
        ColorWithRGB(255, 186, 180, 1),
        ColorWithRGB(148, 235, 255, 1),
        ColorWithRGB(255, 207, 235, 1),
        ColorWithRGB(186, 255, 163, 1)
    ];

    if (isDarkMode) {
        return accentColorsDark[section % accentColorsDark.count];
    }
    return accentColorsLight[section % accentColorsLight.count];
}

- (UIImage *)fallbackChevronImage {
    CGSize size = CGSizeMake(16, 16);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(4, 2)];
    [path addLineToPoint:CGPointMake(12, 8)];
    [path addLineToPoint:CGPointMake(4, 14)];
    BOOL isDarkMode = [self isDarkMode];
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

#pragma mark - Theme Toggle

- (void)loadThemeSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.hasManualThemeOverride = [defaults boolForKey:@"AAChartKit_HasManualThemeOverride"];
    self.manualDarkModeEnabled = [defaults boolForKey:@"AAChartKit_ManualDarkModeEnabled"];
}

- (void)saveThemeSettings {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.hasManualThemeOverride forKey:@"AAChartKit_HasManualThemeOverride"];
    [defaults setBool:self.manualDarkModeEnabled forKey:@"AAChartKit_ManualDarkModeEnabled"];
    [defaults synchronize];
}

- (void)setupThemeToggleButton {
    UIImage *buttonImage = [self themeToggleButtonImage];
    self.themeToggleButton = [[UIBarButtonItem alloc] initWithImage:buttonImage
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(toggleThemeMode)];

    self.themeToggleButton.accessibilityLabel = @"切换主题模式";
    self.themeToggleButton.accessibilityHint = @"在浅色和深色主题之间切换";

    self.navigationItem.rightBarButtonItem = self.themeToggleButton;
}

- (UIImage *)themeToggleButtonImage {
    BOOL isDarkMode = [self isDarkMode];

    CGSize size = CGSizeMake(24, 24);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);

    CGContextRef context = UIGraphicsGetCurrentContext();

    if (isDarkMode) {
        UIColor *sunColor = [UIColor colorWithRed:1.0 green:0.85 blue:0.0 alpha:1.0];
        [sunColor setFill];
        [sunColor setStroke];

        CGFloat centerX = size.width / 2.0;
        CGFloat centerY = size.height / 2.0;
        CGFloat radius = 6.0;

        CGContextFillEllipseInRect(context, CGRectMake(centerX - radius, centerY - radius, radius * 2, radius * 2));

        CGContextSetLineWidth(context, 2.0);
        CGContextSetLineCap(context, kCGLineCapRound);

        for (int i = 0; i < 8; i++) {
            CGFloat angle = (M_PI * 2 / 8) * i;
            CGFloat startX = centerX + cos(angle) * (radius + 2);
            CGFloat startY = centerY + sin(angle) * (radius + 2);
            CGFloat endX = centerX + cos(angle) * (radius + 5);
            CGFloat endY = centerY + sin(angle) * (radius + 5);

            CGContextMoveToPoint(context, startX, startY);
            CGContextAddLineToPoint(context, endX, endY);
            CGContextStrokePath(context);
        }
    } else {
        UIColor *moonColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.6 alpha:1.0];
        [moonColor setFill];

        CGFloat centerX = size.width / 2.0;
        CGFloat centerY = size.height / 2.0;
        CGFloat radius = 8.0;

        CGContextAddEllipseInRect(context, CGRectMake(centerX - radius, centerY - radius, radius * 2, radius * 2));
        CGContextFillPath(context);

        [[UIColor clearColor] setFill];
        CGContextSetBlendMode(context, kCGBlendModeDestinationOut);
        CGFloat offsetX = 3.0;
        CGFloat offsetY = -2.0;
        CGContextAddEllipseInRect(context, CGRectMake(centerX - radius + offsetX, centerY - radius + offsetY, radius * 2, radius * 2));
        CGContextFillPath(context);
    }

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (void)toggleThemeMode {
    if (!self.enableThemeToggle) { return; }

    if (self.hasManualThemeOverride) {
        self.manualDarkModeEnabled = !self.manualDarkModeEnabled;
    } else {
        self.hasManualThemeOverride = YES;
        if (@available(iOS 13.0, *)) {
            self.manualDarkModeEnabled = (self.traitCollection.userInterfaceStyle != UIUserInterfaceStyleDark);
        } else {
            self.manualDarkModeEnabled = YES;
        }
    }

    [self saveThemeSettings];

    self.themeToggleButton.image = [self themeToggleButtonImage];

    [UIView transitionWithView:self.view
                      duration:0.35
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
        [self applyTheme];
    }
                    completion:nil];

    [self showThemeToggleFeedback];
}

- (void)showThemeToggleFeedback {
    BOOL isDark = [self isDarkMode];
    NSString *message = isDark ? @"🌙 已切换到深色模式" : @"☀️ 已切换到浅色模式";

    UIView *toastContainer = [[UIView alloc] init];
    toastContainer.backgroundColor = [UIColor clearColor];
    toastContainer.alpha = 0.0;

    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:isDark ? UIBlurEffectStyleDark : UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurView.layer.cornerRadius = 24.0;
    blurView.layer.masksToBounds = YES;

    UILabel *feedbackLabel = [[UILabel alloc] init];
    feedbackLabel.text = message;
    feedbackLabel.textColor = isDark ? [UIColor whiteColor] : ColorWithRGB(40, 40, 40, 1);
    feedbackLabel.backgroundColor = [UIColor clearColor];
    feedbackLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightSemibold];
    feedbackLabel.textAlignment = NSTextAlignmentCenter;

    [feedbackLabel sizeToFit];
    CGRect labelFrame = feedbackLabel.frame;
    labelFrame.size.width += 40.0;
    labelFrame.size.height = 48.0;
    feedbackLabel.frame = labelFrame;

    blurView.frame = labelFrame;
    toastContainer.frame = labelFrame;
    toastContainer.center = CGPointMake(self.view.center.x, self.view.center.y - 120);

    [toastContainer addSubview:blurView];
    [blurView.contentView addSubview:feedbackLabel];
    feedbackLabel.center = CGPointMake(blurView.bounds.size.width / 2, blurView.bounds.size.height / 2);

    toastContainer.layer.shadowColor = [UIColor blackColor].CGColor;
    toastContainer.layer.shadowOpacity = isDark ? 0.5 : 0.15;
    toastContainer.layer.shadowOffset = CGSizeMake(0, 8);
    toastContainer.layer.shadowRadius = 16.0;

    [self.view addSubview:toastContainer];

    toastContainer.transform = CGAffineTransformMakeTranslation(0, -20);
    [UIView animateWithDuration:0.5
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        toastContainer.alpha = 1.0;
        toastContainer.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.4
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                toastContainer.alpha = 0.0;
                toastContainer.transform = CGAffineTransformMakeTranslation(0, -15);
            } completion:^(BOOL finished2) {
                [toastContainer removeFromSuperview];
            }];
        });
    }];
}

@end
