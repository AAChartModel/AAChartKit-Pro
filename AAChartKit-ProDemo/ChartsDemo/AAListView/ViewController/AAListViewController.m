//
//  AAListViewController.m
//  AAChartKit-ProDemo
//
//  Created by AnAn on 2025/10/23.
//  Copyright © 2025 An An. All rights reserved.
//

#import "AAListViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <math.h>

#import "AAListColorPalette.h"
#import "AAListCardCell.h"
#import "AAListHeaderCardView.h"

static const CGFloat kCardPressScale = 0.96f;
static const CGFloat kAnimationDurationFast = 0.2f;
static const CGFloat kSectionHeaderCornerRadius = 16.0f;
static const NSTimeInterval kThemeToastDuration = 1.5;

@interface AAListViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CAGradientLayer *backgroundGradientLayer;
@property (nonatomic, strong) AAListHeaderCardView *headerCardView;
@property (nonatomic, strong) UIBarButtonItem *themeToggleButton;

@property (nonatomic, assign) BOOL hasManualThemeOverride;
@property (nonatomic, assign) BOOL manualDarkModeEnabled;

@property (nonatomic, copy) NSArray<NSString *> *cachedSectionTitles;
@property (nonatomic, copy) NSArray<NSArray<NSString *> *> *cachedDataArray;

- (void)applyDefaultConfiguration;

@end

@implementation AAListViewController

@synthesize tableView = _tableView;

#pragma mark - Life Cycle

- (instancetype)init {
    self = [super init];
    if (self) {
        [self applyDefaultConfiguration];
    }
    return self;
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self applyDefaultConfiguration];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self applyDefaultConfiguration];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = UIColor.clearColor;

    [self loadThemeSettings];
    [self setupTableView];
    [self setupBackgroundGradient];

    if (self.enableThemeToggle) {
        [self setupThemeToggleButton];
    }

    [self configureTableHeaderViewIfNeeded];
    [self reloadData];
    [self applyTheme];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateTableHeaderLayout];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self updateGradientFrame];
    [self updateTableHeaderLayout];
}

#pragma mark - Configuration

- (void)applyDefaultConfiguration {
    _enableThemeToggle = YES;
    _showHeaderCard = YES;
    if (_headerTitle.length == 0) {
        _headerTitle = @"探索更丰富的高级图表示例";
    }
    if (_headerSubtitle.length == 0) {
        _headerSubtitle = @"精选多类图表，助你快速找到灵感。轻触任意卡片即可查看详细演示。";
    }
    if (_cachedSectionTitles == nil) {
        _cachedSectionTitles = @[];
    }
    if (_cachedDataArray == nil) {
        _cachedDataArray = @[];
    }
}

#pragma mark - Property Overrides

- (void)setEnableThemeToggle:(BOOL)enableThemeToggle {
    if (_enableThemeToggle == enableThemeToggle) {
        return;
    }
    _enableThemeToggle = enableThemeToggle;

    if (!self.isViewLoaded) {
        return;
    }

    if (enableThemeToggle) {
        [self setupThemeToggleButton];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
        self.themeToggleButton = nil;
        self.hasManualThemeOverride = NO;
    }
}

- (void)setShowHeaderCard:(BOOL)showHeaderCard {
    if (_showHeaderCard == showHeaderCard) {
        return;
    }
    _showHeaderCard = showHeaderCard;

    if (!self.isViewLoaded) {
        return;
    }

    [self configureTableHeaderViewIfNeeded];
}

- (void)setHeaderTitle:(NSString *)headerTitle {
    if ((_headerTitle == headerTitle) || [_headerTitle isEqualToString:headerTitle]) {
        return;
    }
    _headerTitle = [headerTitle copy];

    if (self.headerCardView) {
        self.headerCardView.titleText = _headerTitle ?: @"";
        [self updateTableHeaderLayout];
    } else if (self.showHeaderCard && self.isViewLoaded) {
        [self configureTableHeaderViewIfNeeded];
    }
}

- (void)setHeaderSubtitle:(NSString *)headerSubtitle {
    if ((_headerSubtitle == headerSubtitle) || [_headerSubtitle isEqualToString:headerSubtitle]) {
        return;
    }
    _headerSubtitle = [headerSubtitle copy];

    if (self.headerCardView) {
        self.headerCardView.subtitleText = _headerSubtitle ?: @"";
        [self updateTableHeaderLayout];
    } else if (self.showHeaderCard && self.isViewLoaded) {
        [self configureTableHeaderViewIfNeeded];
    }
}

#pragma mark - Setup

- (void)setupTableView {
    UITableView *tableView = self.tableView;
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.backgroundColor = UIColor.clearColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.showsVerticalScrollIndicator = NO;
    tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    tableView.estimatedRowHeight = 120.0f;
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedSectionHeaderHeight = 62.0f;
    tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];

    [tableView registerClass:[AAListCardCell class] forCellReuseIdentifier:[AAListCardCell reuseIdentifier]];

    [self.view addSubview:tableView];

    [NSLayoutConstraint activateConstraints:@[
        [tableView.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor],
        [tableView.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor],
        [tableView.topAnchor constraintEqualToAnchor:self.view.topAnchor],
        [tableView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor]
    ]];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.backgroundColor = UIColor.clearColor;
    }
    return _tableView;
}

- (void)setupBackgroundGradient {
    if (self.backgroundGradientLayer) {
        return;
    }

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.colors = @[
        (__bridge id)AABackgroundLightStart.CGColor,
        (__bridge id)AABackgroundLightMid.CGColor,
        (__bridge id)AABackgroundLightEnd.CGColor
    ];
    gradientLayer.startPoint = CGPointMake(0.0f, 0.0f);
    gradientLayer.endPoint = CGPointMake(1.0f, 1.0f);
    gradientLayer.locations = @[@0.0f, @0.5f, @1.0f];
    gradientLayer.frame = self.view.bounds;
    gradientLayer.needsDisplayOnBoundsChange = YES;

    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    self.backgroundGradientLayer = gradientLayer;

    CABasicAnimation *startAnimation = [CABasicAnimation animationWithKeyPath:@"startPoint"];
    startAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(0.0f, 0.0f)];
    startAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.25f, -0.15f)];
    startAnimation.duration = 18.0;
    startAnimation.autoreverses = YES;
    startAnimation.repeatCount = HUGE_VALF;
    startAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    startAnimation.removedOnCompletion = NO;
    [gradientLayer addAnimation:startAnimation forKey:@"aa.background.startPoint"];

    CABasicAnimation *endAnimation = [CABasicAnimation animationWithKeyPath:@"endPoint"];
    endAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(1.0f, 1.0f)];
    endAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.8f, 1.2f)];
    endAnimation.duration = 18.0;
    endAnimation.autoreverses = YES;
    endAnimation.repeatCount = HUGE_VALF;
    endAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    endAnimation.removedOnCompletion = NO;
    [gradientLayer addAnimation:endAnimation forKey:@"aa.background.endPoint"];
}

- (void)setupThemeToggleButton {
    UIImage *buttonImage = [self themeToggleButtonImage];
    self.themeToggleButton = [[UIBarButtonItem alloc] initWithImage:buttonImage
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(toggleThemeMode)];
    self.themeToggleButton.accessibilityLabel = @"Toggle theme";
    self.themeToggleButton.accessibilityHint = @"Switch between light and dark appearance";
    self.navigationItem.rightBarButtonItem = self.themeToggleButton;
}

#pragma mark - Header Handling

- (void)configureTableHeaderViewIfNeeded {
    if (!self.isViewLoaded) {
        return;
    }

    if (!self.showHeaderCard) {
        self.tableView.tableHeaderView = nil;
        self.headerCardView = nil;
        return;
    }

    if (self.tableView.tableHeaderView == nil) {
        UIView *header = [self buildTableHeaderView];
        self.tableView.tableHeaderView = header;
    } else {
        self.headerCardView.titleText = self.headerTitle ?: @"";
        self.headerCardView.subtitleText = self.headerSubtitle ?: @"";
        [self.headerCardView applyThemeWithDarkMode:[self isDarkMode]];
    }

    [self updateTableHeaderLayout];
}

- (UIView *)buildTableHeaderView {
    if (!self.showHeaderCard) {
        return nil;
    }

    UIView *container = [[UIView alloc] initWithFrame:CGRectZero];
    container.backgroundColor = UIColor.clearColor;

    AAListHeaderCardView *cardView = [[AAListHeaderCardView alloc] initWithTitle:self.headerTitle ?: @""
                                                                        subtitle:self.headerSubtitle ?: @""];
    cardView.translatesAutoresizingMaskIntoConstraints = NO;
    [cardView applyThemeWithDarkMode:[self isDarkMode]];

    [container addSubview:cardView];

    UIEdgeInsets insets = UIEdgeInsetsMake(28.0f, 20.0f, 16.0f, 20.0f);
    [NSLayoutConstraint activateConstraints:@[
        [cardView.leadingAnchor constraintEqualToAnchor:container.leadingAnchor constant:insets.left],
        [cardView.trailingAnchor constraintEqualToAnchor:container.trailingAnchor constant:-insets.right],
        [cardView.topAnchor constraintEqualToAnchor:container.topAnchor constant:insets.top],
        [cardView.bottomAnchor constraintEqualToAnchor:container.bottomAnchor constant:-insets.bottom]
    ]];

    self.headerCardView = cardView;

    container.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.view.bounds), 1.0f);
    [container setNeedsLayout];
    [container layoutIfNeeded];

    CGSize fittingSize = [container systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGRect frame = container.frame;
    frame.size.height = fittingSize.height;
    container.frame = frame;

    return container;
}

- (void)updateTableHeaderLayout {
    UIView *header = self.tableView.tableHeaderView;
    if (!header) {
        return;
    }

    CGFloat targetWidth = CGRectGetWidth(self.tableView.bounds);
    if (targetWidth <= 0.0f) {
        return;
    }

    if (!CGSizeEqualToSize(header.bounds.size, CGSizeMake(targetWidth, header.bounds.size.height))) {
        header.bounds = CGRectMake(0.0f, 0.0f, targetWidth, header.bounds.size.height);
    }

    [header setNeedsLayout];
    [header layoutIfNeeded];

    CGSize fittingSize = [header systemLayoutSizeFittingSize:CGSizeMake(targetWidth, UILayoutFittingCompressedSize.height)];
    if (fabs(header.frame.size.height - fittingSize.height) > 0.5f) {
        CGRect frame = header.frame;
        frame.size.height = fittingSize.height;
        header.frame = frame;
        self.tableView.tableHeaderView = header;
    }
}

#pragma mark - Data Handling

- (void)reloadData {
    if (!self.dataSource) {
        self.cachedSectionTitles = @[];
        self.cachedDataArray = @[];
        [self.tableView reloadData];
        return;
    }

    NSInteger sectionCount = MAX(0, [self.dataSource numberOfSectionsInListView:self]);
    NSArray<NSString *> *rawTitles = [self.dataSource sectionTitlesForListView:self] ?: @[];
    NSArray<NSArray<NSString *> *> *rawMatrix = [self.dataSource dataArrayForListView:self] ?: @[];

    NSMutableArray<NSString *> *normalizedTitles = [[NSMutableArray alloc] initWithCapacity:sectionCount];
    NSMutableArray<NSArray<NSString *> *> *normalizedMatrix = [[NSMutableArray alloc] initWithCapacity:sectionCount];

    for (NSInteger section = 0; section < sectionCount; section++) {
        NSString *title = (section < rawTitles.count) ? rawTitles[section] : @"";
        [normalizedTitles addObject:title ?: @""];

        NSArray<NSString *> *rows = (section < rawMatrix.count && [rawMatrix[section] isKindOfClass:[NSArray class]]) ? rawMatrix[section] : @[];
        NSInteger expectedRows = MAX(0, [self.dataSource listView:self numberOfRowsInSection:section]);
        if (expectedRows < rows.count) {
            rows = [rows subarrayWithRange:NSMakeRange(0, expectedRows)];
        }
        [normalizedMatrix addObject:rows ?: @[]];
    }

    self.cachedSectionTitles = [normalizedTitles copy];
    self.cachedDataArray = [normalizedMatrix copy];

    [self.tableView reloadData];
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
    return 58.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = UIColor.clearColor;

    BOOL isDarkMode = [self isDarkMode];

    UIView *backdropView = [[UIView alloc] init];
    backdropView.translatesAutoresizingMaskIntoConstraints = NO;
    backdropView.layer.cornerRadius = kSectionHeaderCornerRadius;
    backdropView.layer.masksToBounds = NO;

    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    if (isDarkMode) {
        gradientLayer.colors = @[
            (__bridge id)ColorWithRGB(66, 44, 48, 1).CGColor,
            (__bridge id)ColorWithRGB(82, 52, 40, 1).CGColor,
            (__bridge id)ColorWithRGB(58, 38, 33, 1).CGColor
        ];
        backdropView.layer.shadowColor = UIColor.blackColor.CGColor;
        backdropView.layer.shadowOpacity = 0.48f;
        backdropView.layer.shadowOffset = CGSizeMake(0.0f, 8.0f);
        backdropView.layer.shadowRadius = 20.0f;
        backdropView.layer.borderWidth = 0.5f;
        backdropView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.18f].CGColor;
    } else {
        gradientLayer.colors = @[
            (__bridge id)ColorWithRGB(255, 247, 239, 1).CGColor,
            (__bridge id)ColorWithRGB(255, 235, 222, 1).CGColor
        ];
        backdropView.layer.shadowColor = ColorWithRGB(205, 170, 130, 0.34f).CGColor;
        backdropView.layer.shadowOpacity = 0.28f;
        backdropView.layer.shadowOffset = CGSizeMake(0.0f, 4.0f);
        backdropView.layer.shadowRadius = 12.0f;
        backdropView.layer.borderWidth = 0.8f;
        backdropView.layer.borderColor = ColorWithRGB(248, 216, 190, 1).CGColor;
        backdropView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9f];
    }

    gradientLayer.startPoint = CGPointMake(0.0f, 0.0f);
    gradientLayer.endPoint = CGPointMake(1.0f, 1.0f);
    gradientLayer.frame = backdropView.bounds;
    gradientLayer.cornerRadius = backdropView.layer.cornerRadius;
    gradientLayer.masksToBounds = YES;
    [backdropView.layer insertSublayer:gradientLayer atIndex:0];
    [containerView addSubview:backdropView];

    UIView *accentView = [[UIView alloc] init];
    accentView.translatesAutoresizingMaskIntoConstraints = NO;
    UIColor *accentColor = [self accentColorForSection:section darkMode:isDarkMode];
    accentView.backgroundColor = accentColor;
    accentView.layer.cornerRadius = 3.0f;
    accentView.layer.masksToBounds = NO;
    accentView.layer.shadowColor = accentColor.CGColor;
    accentView.layer.shadowOpacity = isDarkMode ? 0.8f : 0.35f;
    accentView.layer.shadowOffset = isDarkMode ? CGSizeZero : CGSizeMake(0.0f, 2.0f);
    accentView.layer.shadowRadius = isDarkMode ? 6.0f : 5.0f;
    [backdropView addSubview:accentView];

    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.textAlignment = NSTextAlignmentLeft;
    label.font = [UIFont systemFontOfSize:16.0f weight:UIFontWeightSemibold];
    label.adjustsFontSizeToFitWidth = YES;
    label.minimumScaleFactor = 0.9f;
    label.textColor = isDarkMode ? [UIColor colorWithWhite:0.95f alpha:1.0f] : ColorWithRGB(118, 82, 62, 1);
    label.text = [self titleForSection:section];
    [backdropView addSubview:label];

    [NSLayoutConstraint activateConstraints:@[
        [backdropView.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor constant:18.0f],
        [backdropView.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor constant:-18.0f],
        [backdropView.topAnchor constraintEqualToAnchor:containerView.topAnchor constant:6.0f],
        [backdropView.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor constant:-6.0f],

        [accentView.widthAnchor constraintEqualToConstant:6.0f],
        [accentView.heightAnchor constraintEqualToConstant:24.0f],
        [accentView.leadingAnchor constraintEqualToAnchor:backdropView.leadingAnchor constant:16.0f],
        [accentView.centerYAnchor constraintEqualToAnchor:backdropView.centerYAnchor],

        [label.leadingAnchor constraintEqualToAnchor:accentView.trailingAnchor constant:12.0f],
        [label.trailingAnchor constraintEqualToAnchor:backdropView.trailingAnchor constant:-20.0f],
        [label.centerYAnchor constraintEqualToAnchor:backdropView.centerYAnchor]
    ]];

    return containerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == self.cachedSectionTitles.count - 1 ? 32.0f : 16.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray<NSString *> *titles = [[NSMutableArray alloc] initWithCapacity:self.cachedSectionTitles.count];
    for (NSString *item in self.cachedSectionTitles) {
        if (item.length > 0) {
            [titles addObject:[item substringToIndex:1]];
        }
    }
    return titles;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AAListCardCell *cell = [tableView dequeueReusableCellWithIdentifier:[AAListCardCell reuseIdentifier]
                                                           forIndexPath:indexPath];

    NSString *fullTitle = nil;
    if (indexPath.section < self.cachedDataArray.count) {
        NSArray<NSString *> *sectionData = self.cachedDataArray[indexPath.section];
        if (indexPath.row < sectionData.count) {
            fullTitle = sectionData[indexPath.row];
        }
    }

    NSString *primaryTitle = @"";
    NSString *secondaryTitle = @"Explore this chart";
    if (fullTitle.length > 0) {
        NSArray<NSString *> *components = [fullTitle componentsSeparatedByString:@"---"];
        if (components.count > 0) {
            primaryTitle = components.firstObject ?: @"";
        }
        if (components.count > 1) {
            NSArray<NSString *> *secondaryParts = [components subarrayWithRange:NSMakeRange(1, components.count - 1)];
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"length > 0"];
            NSArray<NSString *> *filtered = [secondaryParts filteredArrayUsingPredicate:predicate];
            if (filtered.count > 0) {
                secondaryTitle = [filtered componentsJoinedByString:@" · "];
            }
        }
    }

    BOOL isDarkMode = [self isDarkMode];
    UIColor *accentColor = [self accentColorForSection:indexPath.section darkMode:isDarkMode];
    NSString *badgeText = [NSString stringWithFormat:@"%02ld", (long)indexPath.row + 1];

    [cell configureWithPrimaryTitle:primaryTitle
                      secondaryTitle:secondaryTitle
                           badgeText:badgeText
                            darkMode:isDarkMode
                          accentColor:accentColor];

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
    AAListCardCell *cell = (AAListCardCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIView *cardView = cell.cardContainerView;
    if (!cardView) {
        return;
    }

    CGFloat baseOpacity = [AAListCardCell cardShadowBaseOpacityForDarkMode:[self isDarkMode]];

    [UIView animateWithDuration:kAnimationDurationFast
                          delay:0.0
         usingSpringWithDamping:0.8
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        cardView.transform = CGAffineTransformMakeScale(kCardPressScale, kCardPressScale);
        cardView.layer.shadowOpacity = MAX(baseOpacity * 0.5f, 0.05f);
        cardView.alpha = 0.92f;
    }
                     completion:nil];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    AAListCardCell *cell = (AAListCardCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIView *cardView = cell.cardContainerView;
    if (!cardView) {
        return;
    }

    CGFloat baseOpacity = [AAListCardCell cardShadowBaseOpacityForDarkMode:[self isDarkMode]];

    [UIView animateWithDuration:0.4
                          delay:0.0
         usingSpringWithDamping:0.6
          initialSpringVelocity:0.8
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        cardView.transform = CGAffineTransformIdentity;
        cardView.layer.shadowOpacity = baseOpacity;
        cardView.alpha = 1.0f;
    }
                     completion:nil];
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

    if (self.navigationController) {
        if (@available(iOS 13.0, *)) {
            UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
            [appearance configureWithOpaqueBackground];
            appearance.backgroundColor = isDarkMode ? [UIColor colorWithRed:18.0/255.0f green:20.0/255.0f blue:28.0/255.0f alpha:1.0f]
                                                    : UIColor.whiteColor;
            appearance.titleTextAttributes = @{ NSForegroundColorAttributeName : isDarkMode ? UIColor.whiteColor : UIColor.blackColor };
            appearance.shadowColor = UIColor.clearColor;
            self.navigationController.navigationBar.standardAppearance = appearance;
            self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
            self.navigationController.navigationBar.tintColor = isDarkMode ? UIColor.whiteColor : UIColor.blackColor;
        } else {
            self.navigationController.navigationBar.barTintColor = isDarkMode ? [UIColor colorWithRed:18.0/255.0f green:20.0/255.0f blue:28.0/255.0f alpha:1.0f]
                                                                            : UIColor.whiteColor;
            self.navigationController.navigationBar.titleTextAttributes = @{ NSForegroundColorAttributeName : isDarkMode ? UIColor.whiteColor : UIColor.blackColor };
            self.navigationController.navigationBar.tintColor = isDarkMode ? UIColor.whiteColor : UIColor.blackColor;
        }
    }

    [self updateBackgroundGradient];

    if (self.headerCardView) {
        [self.headerCardView applyThemeWithDarkMode:isDarkMode];
        [self updateTableHeaderLayout];
    }

    if (self.themeToggleButton) {
        self.themeToggleButton.image = [self themeToggleButtonImage];
    }

    [self.tableView reloadData];
}

- (void)updateBackgroundGradient {
    if (!self.backgroundGradientLayer) {
        return;
    }

    BOOL isDarkMode = [self isDarkMode];

    NSArray *colors = isDarkMode ? @[ (__bridge id)AABackgroundDarkStart.CGColor,
                                      (__bridge id)AABackgroundDarkMid.CGColor,
                                      (__bridge id)AABackgroundDarkEnd.CGColor ]
                                 : @[ (__bridge id)AABackgroundLightStart.CGColor,
                                      (__bridge id)AABackgroundLightMid.CGColor,
                                      (__bridge id)AABackgroundLightEnd.CGColor ];

    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.fromValue = self.backgroundGradientLayer.colors;
    animation.toValue = colors;
    animation.duration = 0.4;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.backgroundGradientLayer addAnimation:animation forKey:@"aa.background.colors"];

    self.backgroundGradientLayer.colors = colors;
}

- (void)updateGradientFrame {
    if (!self.backgroundGradientLayer) {
        return;
    }
    CGRect bounds = self.view.bounds;
    if (!CGRectEqualToRect(self.backgroundGradientLayer.frame, bounds)) {
        self.backgroundGradientLayer.frame = bounds;
    }
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

#pragma mark - Theme Toggle

- (void)loadThemeSettings {
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    self.hasManualThemeOverride = [defaults boolForKey:@"AAChartKit_HasManualThemeOverride"];
    self.manualDarkModeEnabled = [defaults boolForKey:@"AAChartKit_ManualDarkModeEnabled"];
}

- (void)saveThemeSettings {
    NSUserDefaults *defaults = NSUserDefaults.standardUserDefaults;
    [defaults setBool:self.hasManualThemeOverride forKey:@"AAChartKit_HasManualThemeOverride"];
    [defaults setBool:self.manualDarkModeEnabled forKey:@"AAChartKit_ManualDarkModeEnabled"];
    [defaults synchronize];
}

- (UIImage *)themeToggleButtonImage {
    BOOL isDarkMode = [self isDarkMode];

    CGSize size = CGSizeMake(24.0f, 24.0f);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0f);
    CGContextRef context = UIGraphicsGetCurrentContext();

    if (isDarkMode) {
        UIColor *sunColor = [UIColor colorWithRed:1.0f green:0.85f blue:0.0f alpha:1.0f];
        [sunColor setFill];
        [sunColor setStroke];

        CGFloat centerX = size.width / 2.0f;
        CGFloat centerY = size.height / 2.0f;
        CGFloat radius = 6.0f;

        CGContextFillEllipseInRect(context, CGRectMake(centerX - radius, centerY - radius, radius * 2.0f, radius * 2.0f));

        CGContextSetLineWidth(context, 2.0f);
        CGContextSetLineCap(context, kCGLineCapRound);

        for (NSInteger i = 0; i < 8; i++) {
            CGFloat angle = (CGFloat)((M_PI * 2.0) / 8.0 * i);
            CGFloat startX = centerX + cos(angle) * (radius + 2.0f);
            CGFloat startY = centerY + sin(angle) * (radius + 2.0f);
            CGFloat endX = centerX + cos(angle) * (radius + 5.0f);
            CGFloat endY = centerY + sin(angle) * (radius + 5.0f);

            CGContextMoveToPoint(context, startX, startY);
            CGContextAddLineToPoint(context, endX, endY);
            CGContextStrokePath(context);
        }
    } else {
        UIColor *moonColor = [UIColor colorWithRed:0.4f green:0.4f blue:0.6f alpha:1.0f];
        [moonColor setFill];

        CGFloat centerX = size.width / 2.0f;
        CGFloat centerY = size.height / 2.0f;
        CGFloat radius = 8.0f;

        CGContextAddEllipseInRect(context, CGRectMake(centerX - radius, centerY - radius, radius * 2.0f, radius * 2.0f));
        CGContextFillPath(context);

        [[UIColor clearColor] setFill];
        CGContextSetBlendMode(context, kCGBlendModeDestinationOut);
        CGFloat offsetX = 3.0f;
        CGFloat offsetY = -2.0f;
        CGContextAddEllipseInRect(context, CGRectMake(centerX - radius + offsetX, centerY - radius + offsetY, radius * 2.0f, radius * 2.0f));
        CGContextFillPath(context);
    }

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return image;
}

- (void)toggleThemeMode {
    if (!self.enableThemeToggle) {
        return;
    }

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
    NSString *message = isDark ? @"Dark mode enabled" : @"Light mode enabled";

    UIView *toastContainer = [[UIView alloc] init];
    toastContainer.backgroundColor = UIColor.clearColor;
    toastContainer.alpha = 0.0f;

    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:isDark ? UIBlurEffectStyleDark : UIBlurEffectStyleLight];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurView.layer.cornerRadius = 24.0f;
    blurView.layer.masksToBounds = YES;

    UILabel *feedbackLabel = [[UILabel alloc] init];
    feedbackLabel.text = message;
    feedbackLabel.textColor = isDark ? UIColor.whiteColor : ColorWithRGB(40, 40, 40, 1);
    feedbackLabel.backgroundColor = UIColor.clearColor;
    feedbackLabel.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightSemibold];
    feedbackLabel.textAlignment = NSTextAlignmentCenter;

    [feedbackLabel sizeToFit];
    CGRect labelFrame = feedbackLabel.frame;
    labelFrame.size.width += 40.0f;
    labelFrame.size.height = 48.0f;
    feedbackLabel.frame = labelFrame;

    blurView.frame = labelFrame;
    toastContainer.frame = labelFrame;
    toastContainer.center = CGPointMake(self.view.center.x, self.view.center.y - 120.0f);

    [toastContainer addSubview:blurView];
    [blurView.contentView addSubview:feedbackLabel];
    feedbackLabel.center = CGPointMake(CGRectGetWidth(blurView.bounds) / 2.0f, CGRectGetHeight(blurView.bounds) / 2.0f);

    toastContainer.layer.shadowColor = UIColor.blackColor.CGColor;
    toastContainer.layer.shadowOpacity = isDark ? 0.5f : 0.15f;
    toastContainer.layer.shadowOffset = CGSizeMake(0.0f, 8.0f);
    toastContainer.layer.shadowRadius = 16.0f;

    [self.view addSubview:toastContainer];

    toastContainer.transform = CGAffineTransformMakeTranslation(0.0f, -20.0f);
    [UIView animateWithDuration:0.5
                          delay:0.0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
        toastContainer.alpha = 1.0f;
        toastContainer.transform = CGAffineTransformIdentity;
    }
                     completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(kThemeToastDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.4
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                toastContainer.alpha = 0.0f;
                toastContainer.transform = CGAffineTransformMakeTranslation(0.0f, -15.0f);
            }
                             completion:^(BOOL finished2) {
                [toastContainer removeFromSuperview];
            }];
        });
    }];
}

@end
