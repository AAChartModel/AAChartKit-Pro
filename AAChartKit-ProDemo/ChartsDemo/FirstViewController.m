//
//  FirstViewController.m
//  AAChartKit-Pro
//
//  Created by An An on 17/3/14.
//  Copyright © 2017年 An An. All rights reserved.
//*************** ...... SOURCE CODE ...... ***************
//***...................................................***
//*** https://github.com/AAChartModel/AAChartKit        ***
//*** https://github.com/AAChartModel/AAChartKit-Swift  ***
//***...................................................***
//*************** ...... SOURCE CODE ...... ***************

/*
 
 * -------------------------------------------------------------------------------
 *
 * 🌕 🌖 🌗 🌘  ❀❀❀   WARM TIPS!!!   ❀❀❀ 🌑 🌒 🌓 🌔
 *
 * Please contact me on GitHub,if there are any problems encountered in use.
 * GitHub Issues : https://github.com/AAChartModel/AAChartKit/issues
 * -------------------------------------------------------------------------------
 * And if you want to contribute for this project, please contact me as well
 * GitHub        : https://github.com/AAChartModel
 * StackOverflow : https://stackoverflow.com/users/12302132/codeforu
 * JianShu       : http://www.jianshu.com/u/f1e6753d4254
 * SegmentFault  : https://segmentfault.com/u/huanghunbieguan
 *
 * -------------------------------------------------------------------------------
 
 */

#import "FirstViewController.h"
#import "ChartProVC.h"
#import "AATilemapChartVC.h"
#import "AARelationshipChartVC.h"
#import "AABubbleChartVC.h"
#import "AAColumnVariantChartVC.h"
#import "AAHeatmapChartVC.h"
#import "AATreemapChartVC.h"
#import "AATreegraphChartVC.h"
#import "AABoostChartVC.h"
#import "AADrilldownChartVC.h"
#import "AAOptions3DChartVC.h"
#import "ChartListTableViewVC.h"
#import "ChartListCollectionViewVC.h"
#import <QuartzCore/QuartzCore.h>

// MARK: - Color System

#define ColorWithRGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// Modern Color Palette
#define AABackgroundLightStart     ColorWithRGB(240, 246, 255, 1)    // Soft blue-white
#define AABackgroundLightMid       ColorWithRGB(230, 241, 255, 1)    // Light sky blue
#define AABackgroundLightEnd       ColorWithRGB(248, 237, 255, 1)    // Lavender touch

#define AABackgroundDarkStart      ColorWithRGB(15, 17, 26, 1)       // Deep navy
#define AABackgroundDarkMid        ColorWithRGB(25, 30, 42, 1)       // Midnight blue
#define AABackgroundDarkEnd        ColorWithRGB(32, 22, 42, 1)       // Dark purple

#define AAAccentBlueLight          ColorWithRGB(88, 116, 255, 1)     // Vibrant blue
#define AAAccentBlueDark           ColorWithRGB(120, 140, 255, 1)    // Lighter blue for dark mode
#define AAAccentPurple             ColorWithRGB(155, 81, 224, 1)     // Purple accent

#define AACardShadowLight          [[UIColor blackColor] colorWithAlphaComponent:0.08]
#define AACardShadowDark           [UIColor blackColor]

// Dynamic Color Helper
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

// MARK: - Animation Constants

static const CGFloat kCardPressScale = 0.96;
static const CGFloat kAnimationDurationFast = 0.2;
static const CGFloat kAnimationDurationMedium = 0.3;
static const CGFloat kCardCornerRadius = 18.0;
static const CGFloat kSectionHeaderCornerRadius = 16.0;
static const CGFloat kBadgeCornerRadius = 15.0;

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *chartTypeNameArr;
@property (nonatomic, strong) NSArray *sectionTypeArr;
@property (nonatomic, strong) NSArray <NSLayoutConstraint *>*constraintArr;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CAGradientLayer *backgroundGradientLayer;
@property (nonatomic, strong) UIView *tableHeaderCardView;
@property (nonatomic, strong) UILabel *headerTitleLabel;
@property (nonatomic, strong) UILabel *headerSubtitleLabel;
@property (nonatomic, strong) CAGradientLayer *headerCardGradientLayer;
@property (nonatomic, strong) UIBarButtonItem *themeToggleButton;
@property (nonatomic, assign) BOOL hasManualThemeOverride;
@property (nonatomic, assign) BOOL manualDarkModeEnabled;

@end

#pragma mark - Implementation

@implementation FirstViewController

#pragma mark - Lifecycle Methods

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self applyTheme];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Configure basic setup
    self.title = @"AAChartKit-Pro";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // Initialize theme system
    [self loadThemeSettings];
    
    // Setup UI components in order
    [self setupNavigationBar];
    [self setupBackgroundGradient];
    [self configTheTableView];
    
    // Apply initial theme
    [self applyTheme];
}

#pragma mark - Setup Methods

- (void)setupNavigationBar {
    // Configure navigation bar style
    self.navigationController.navigationBar.prefersLargeTitles = NO;
    
    // Add theme toggle button
    [self setupThemeToggleButton];
}

- (void)configTheTableView {
    // Use modern grouped style
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
    
    // Modern spacing
    tableView.contentInset = UIEdgeInsetsMake(20, 0, 40, 0);
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 80;
    tableView.sectionHeaderHeight = UITableViewAutomaticDimension;
    tableView.estimatedSectionHeaderHeight = 58;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 1)];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    // Transparent background
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    backgroundView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = backgroundView;
    
    // Add smooth bounce effect
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
    }
    
    [self.view addSubview:tableView];
    [self.view addConstraints:[self configureTheConstraintArrayWithItem:tableView toItem:self.view]];

    // Setup header view
    tableView.tableHeaderView = [self buildTableHeaderView];
    
    self.tableView = tableView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    // Update background gradient frame to match view bounds
    if (self.backgroundGradientLayer) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        self.backgroundGradientLayer.frame = self.view.bounds;
        [CATransaction commit];
    }
    
    // Dynamically resize table header view based on content
    if (self.tableView.tableHeaderView) {
        UIView *headerView = self.tableView.tableHeaderView;
        [headerView setNeedsLayout];
        [headerView layoutIfNeeded];
        
        CGFloat height = [headerView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        CGRect headerFrame = headerView.frame;
        
        if (headerFrame.size.height != height) {
            headerFrame.size.height = height;
            headerView.frame = headerFrame;
            self.tableView.tableHeaderView = headerView;
        }
    }
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.chartTypeNameArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 58; // Modern section header height
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    // Create container for the section header
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor clearColor];

    BOOL isDarkMode = [self isDarkMode];

    // Create backdrop view with gradient and shadow
    UIView *backdropView = [[UIView alloc] init];
    backdropView.translatesAutoresizingMaskIntoConstraints = NO;
    backdropView.layer.cornerRadius = kSectionHeaderCornerRadius;
    backdropView.layer.masksToBounds = NO;

    // Create sophisticated gradient background
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    if (isDarkMode) {
        gradientLayer.colors = @[
            (__bridge id)ColorWithRGB(42, 45, 65, 1).CGColor,
            (__bridge id)ColorWithRGB(55, 63, 90, 1).CGColor,
            (__bridge id)ColorWithRGB(36, 48, 88, 1).CGColor
        ];
        backdropView.layer.shadowColor = [UIColor blackColor].CGColor;
        backdropView.layer.shadowOpacity = 0.50;
        backdropView.layer.shadowOffset = CGSizeMake(0, 8);
        backdropView.layer.shadowRadius = 20.0;
        backdropView.layer.borderWidth = 0.5;
        backdropView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.15].CGColor;
    } else {
        gradientLayer.colors = @[
            (__bridge id)ColorWithRGB(250, 252, 255, 1).CGColor,
            (__bridge id)ColorWithRGB(235, 243, 255, 1).CGColor
        ];
        backdropView.layer.shadowColor = ColorWithRGB(100, 120, 180, 0.3).CGColor;
        backdropView.layer.shadowOpacity = 0.25;
        backdropView.layer.shadowOffset = CGSizeMake(0, 4);
        backdropView.layer.shadowRadius = 12.0;
        backdropView.layer.borderWidth = 0.8;
        backdropView.layer.borderColor = ColorWithRGB(215, 228, 252, 1).CGColor;
        backdropView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.90];
    }
    
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.frame = backdropView.bounds;
    gradientLayer.cornerRadius = backdropView.layer.cornerRadius;
    gradientLayer.masksToBounds = YES;
    gradientLayer.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;
    [backdropView.layer insertSublayer:gradientLayer atIndex:0];
    [containerView addSubview:backdropView];

    // Create elegant accent indicator
    UIView *accentView = [[UIView alloc] init];
    accentView.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (isDarkMode) {
        // Glowing accent for dark mode
        accentView.backgroundColor = AAAccentBlueDark;
        accentView.layer.shadowColor = AAAccentBlueDark.CGColor;
        accentView.layer.shadowOpacity = 0.8;
        accentView.layer.shadowOffset = CGSizeMake(0, 0);
        accentView.layer.shadowRadius = 6.0;
    } else {
        // Subtle shadow for light mode
        accentView.backgroundColor = AAAccentBlueLight;
        accentView.layer.shadowColor = AAAccentBlueLight.CGColor;
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
    // Simple and reliable text colors
    if (isDarkMode) {
        label.textColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    } else {
        label.textColor = ColorWithRGB(60, 75, 120, 1);
    }
    label.text = self.sectionTypeArr[section];
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
        [label.centerYAnchor constraintEqualToAnchor:backdropView.centerYAnchor],
    ]];

    return containerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return section == self.sectionTypeArr.count - 1 ? 32.0 : 16.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc] initWithFrame:CGRectZero];
}

- (NSArray *)sectionIndexTitlesForTableView: (UITableView *)tableView {
    NSMutableArray *listTitles = [[NSMutableArray alloc] init];
    for (NSString *item in self.sectionTypeArr) {
          NSString *title = [item substringToIndex: 1];
          [listTitles addObject: title];
    }
    return listTitles;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.chartTypeNameArr[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
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
        // Create modern card container
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
            [cardView.bottomAnchor constraintEqualToAnchor:cell.contentView.bottomAnchor constant:-8.0],
        ]];

        // Enhanced blur effects based on current theme
        UIVisualEffect *blurEffect = nil;
        BOOL isDarkMode = [self isDarkMode];
        
        if (@available(iOS 13.0, *)) {
            if (isDarkMode) {
                blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemThinMaterialDark];
            } else {
                blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemThinMaterialLight];
            }
        } else {
            blurEffect = [UIBlurEffect effectWithStyle:isDarkMode ? UIBlurEffectStyleDark : UIBlurEffectStyleExtraLight];
        }
        
        UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        blurView.tag = 1006;
        blurView.frame = cardView.bounds;
        blurView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
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
        backgroundOverlay.backgroundColor = [self cardOverlayBackgroundColor];
        [cardView addSubview:backgroundOverlay];

        [NSLayoutConstraint activateConstraints:@[
            [backgroundOverlay.leadingAnchor constraintEqualToAnchor:cardView.leadingAnchor],
            [backgroundOverlay.trailingAnchor constraintEqualToAnchor:cardView.trailingAnchor],
            [backgroundOverlay.topAnchor constraintEqualToAnchor:cardView.topAnchor],
            [backgroundOverlay.bottomAnchor constraintEqualToAnchor:cardView.bottomAnchor],
        ]];

        UIView *contentContainer = [[UIView alloc] init];
        contentContainer.translatesAutoresizingMaskIntoConstraints = NO;
        contentContainer.backgroundColor = [UIColor clearColor];
        [cardView addSubview:contentContainer];

        [NSLayoutConstraint activateConstraints:@[
            [contentContainer.leadingAnchor constraintEqualToAnchor:cardView.leadingAnchor constant:20.0],
            [contentContainer.trailingAnchor constraintEqualToAnchor:cardView.trailingAnchor constant:-20.0],
            [contentContainer.topAnchor constraintEqualToAnchor:cardView.topAnchor constant:14.0],
            [contentContainer.bottomAnchor constraintEqualToAnchor:cardView.bottomAnchor constant:-14.0],
        ]];

        badgeLabel = [[UILabel alloc] init];
        badgeLabel.tag = 1002;
        badgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
        badgeLabel.textAlignment = NSTextAlignmentCenter;
        badgeLabel.font = [UIFont monospacedDigitSystemFontOfSize:13.0 weight:UIFontWeightBold];
        badgeLabel.textColor = [UIColor whiteColor];
        badgeLabel.layer.cornerRadius = kBadgeCornerRadius;
        badgeLabel.layer.masksToBounds = NO;
        
        // Modern badge styling
        isDarkMode = [self isDarkMode];
        if (isDarkMode) {
            // Vibrant glow for dark mode
            badgeLabel.backgroundColor = ColorWithRGB(100, 120, 255, 1);
            badgeLabel.layer.shadowColor = ColorWithRGB(100, 120, 255, 1).CGColor;
            badgeLabel.layer.shadowOpacity = 0.6;
            badgeLabel.layer.shadowOffset = CGSizeMake(0, 0);
            badgeLabel.layer.shadowRadius = 8.0;
        } else {
            // Clean look for light mode
            badgeLabel.backgroundColor = ColorWithRGB(85, 105, 255, 1);
            badgeLabel.layer.shadowColor = ColorWithRGB(85, 105, 255, 0.4).CGColor;
            badgeLabel.layer.shadowOpacity = 0.3;
            badgeLabel.layer.shadowOffset = CGSizeMake(0, 3);
            badgeLabel.layer.shadowRadius = 6.0;
        }
        
        [contentContainer addSubview:badgeLabel];

        titleLabel = [[UILabel alloc] init];
        titleLabel.tag = 1003;
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        titleLabel.font = [UIFont systemFontOfSize:17.0 weight:UIFontWeightSemibold];
        // Simple and reliable title colors
        if (isDarkMode) {
            titleLabel.textColor = [UIColor colorWithWhite:0.95 alpha:1.0];
        } else {
            titleLabel.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
        }
        titleLabel.numberOfLines = 1;
        [contentContainer addSubview:titleLabel];

        subtitleLabel = [[UILabel alloc] init];
        subtitleLabel.tag = 1004;
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        subtitleLabel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular];
        // Simple and reliable subtitle colors
        if (isDarkMode) {
            subtitleLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        } else {
            subtitleLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        }
        subtitleLabel.numberOfLines = 0;
        [contentContainer addSubview:subtitleLabel];

        chevronImageView = [[UIImageView alloc] init];
        chevronImageView.tag = 1005;
        chevronImageView.translatesAutoresizingMaskIntoConstraints = NO;
        chevronImageView.contentMode = UIViewContentModeScaleAspectFit;
        // Simple and reliable chevron colors
        if (isDarkMode) {
            chevronImageView.tintColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        } else {
            chevronImageView.tintColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        }
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
            [subtitleLabel.bottomAnchor constraintLessThanOrEqualToAnchor:contentContainer.bottomAnchor],
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
            backgroundOverlay.backgroundColor = [self cardOverlayBackgroundColor];
        }
        
        // Update colors for reused cells
        BOOL isDarkMode = [self isDarkMode];
        
        // Update badge colors
        if (isDarkMode) {
            badgeLabel.backgroundColor = ColorWithRGB(110, 130, 255, 1);
            badgeLabel.layer.shadowColor = ColorWithRGB(110, 130, 255, 1).CGColor;
            badgeLabel.layer.shadowOpacity = 0.4;
        } else {
            badgeLabel.backgroundColor = ColorWithRGB(93, 112, 255, 1);
            badgeLabel.layer.shadowOpacity = 0.0;
        }
        
        // Update text colors
        if (isDarkMode) {
            titleLabel.textColor = [UIColor colorWithWhite:0.95 alpha:1.0];
            subtitleLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1.0];
            chevronImageView.tintColor = [UIColor colorWithWhite:0.7 alpha:1.0];
        } else {
            titleLabel.textColor = [UIColor colorWithWhite:0.1 alpha:1.0];
            subtitleLabel.textColor = [UIColor colorWithWhite:0.4 alpha:1.0];
            chevronImageView.tintColor = [UIColor colorWithWhite:0.4 alpha:1.0];
        }
    }

    NSString *fullTitle = self.chartTypeNameArr[indexPath.section][indexPath.row];
    NSArray<NSString *> *components = [fullTitle componentsSeparatedByString:@"---"];
    NSString *primaryTitle = components.firstObject ?: fullTitle;
    NSMutableArray<NSString *> *secondaryParts = components.count > 1 ? [[components subarrayWithRange:NSMakeRange(1, components.count - 1)] mutableCopy] : nil;
    NSString *secondaryTitle = secondaryParts.count ? [secondaryParts componentsJoinedByString:@" · "] : @"探索这个图表";

    badgeLabel.text = [NSString stringWithFormat:@"%02ld", (long)indexPath.row + 1];
    titleLabel.text = primaryTitle;
    subtitleLabel.text = secondaryTitle;
    chevronImageView.alpha = 0.8;

    [self applyThemeToCardView:cardView];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    switch (indexPath.section) {
        case 0 : {
            AARelationshipChartVC *vc = [[AARelationshipChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 1 : {
            AATilemapChartVC *vc = [[AATilemapChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 2 : {
            AABubbleChartVC *vc = [[AABubbleChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 3 : {
            AAColumnVariantChartVC *vc = [[AAColumnVariantChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 4 : {
            ChartProVC *vc = [[ChartProVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
         
        case 5 : {
            AAHeatmapChartVC *vc = [[AAHeatmapChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
         
        case 6 : {
            AATreemapChartVC *vc = [[AATreemapChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 7 : {
            AATreegraphChartVC *vc = [[AATreegraphChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 8 : {
            AABoostChartVC *vc = [[AABoostChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 9 : {
            AADrilldownChartVC *vc = [[AADrilldownChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        case 10 : {
            AAOptions3DChartVC *vc = [[AAOptions3DChartVC alloc]init];
            vc.selectedIndex = indexPath.row;
            vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 11 : {
            if (indexPath.row == 0) {
                ChartListTableViewVC *vc = [[ChartListTableViewVC alloc]init];
//                vc.selectedIndex = indexPath.row;
//                vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
                [self.navigationController pushViewController:vc animated:YES];
            } else {
                ChartListCollectionViewVC *vc = [[ChartListCollectionViewVC alloc]init];
//                vc.selectedIndex = indexPath.row;
//                vc.navigationItemTitleArr = self.chartTypeNameArr[indexPath.section];
                [self.navigationController pushViewController:vc animated:YES];
            }

        }
            break;
        
        default:
            break;
    }
    
}

- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView *cardView = [cell.contentView viewWithTag:1001];
    if (!cardView) { return; }
    
    CGFloat baseOpacity = [self cardShadowBaseOpacity];
    
    // Smooth spring animation for press effect
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
    
    // Bouncy spring animation for release effect
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
                                            constant:0],
              
              ];
}

- (NSArray *)chartTypeNameArr {
    if (!_chartTypeNameArr) {
        _chartTypeNameArr = @[

            
            @[
                @"sankeyChart---桑基图",
                @"dependencywheelChart---和弦图🎸",
                @"arcdiagramChart1---弧形图1🌈",
                @"arcdiagramChart2---弧形图2🌈",
                @"arcdiagramChart3---弧形图3🌈",
                @"organizationChart---组织结构图",
                @"networkgraphChart---力导关系图",
                @"simpleDependencyWheelChart---简单的和弦图🎵",
                @"neuralNetworkChart---神经网络图",
                @"carnivoraPhylogenyOrganizationChart---食肉目动物系统发育组织图",
                @"germanicLanguageTreeChart---日耳曼语系树图",
                //     case 11: return [AASankeyComposer sankeyDiagramChart];
//                case 12: return [AASankeyComposer verticalSankeyChart];
                @"sankeyDiagramChart---桑基图",
                @"verticalSankeyChart---垂直桑基图",
            ],
//            "HeatOrTreeMapChart | 热力或树形类型图表",
            @[
                @"heatmapChart---热力图🌡",
//                @"tilemapOrHoneycombChart---砖块图🧱||蜂巢图🐝🌡",
                @"treemapWithColorAxisData---包好色彩轴的矩形树图🌲",
                @"treemapWithLevelsData---包含等级的矩形树图🌲",
                @"drilldownLargeDataTreemapChart---可下钻的大数据量矩形树图🌲",
                @"largeDataHeatmapChart---大数据量热力图🌡",
                @"simpleTilemapWithHexagonTileShape---简单的砖块图🧱(六边形蜂巢图🐝)",
                @"simpleTilemapWithCircleTileShape---简单的砖块图🧱(圆形)",
                @"simpleTilemapWithDiamondTileShape---简单的砖块图🧱(菱形)",
                @"simpleTilemapWithSquareTileShape---简单的砖块图🧱(正方形)",
                
                @"tilemapForAfricaWithHexagonTileShape---非洲砖块图🧱(六边形蜂巢图🐝)",
                @"tilemapForAfricaWithCircleTileShape---非洲砖块图🧱(圆形)",
                @"tilemapForAfricaWithDiamondTileShape---非洲砖块图🧱(菱形)",
                @"tilemapForAfricaWithSquareTileShape---非洲砖块图🧱(正方形)",
                
                @"tilemapForAmericaWithHexagonTileShape---美洲砖块图🧱(六边形蜂巢图🐝)",
                @"tilemapForAmericaWithCircleTileShape---美洲砖块图🧱(圆形)",
                @"tilemapForAmericaWithDiamondTileShape---美洲砖块图🧱(菱形)",
                @"tilemapForAmericaWithSquareTileShape---美洲砖块图🧱(正方形)",
                
                @"treegraphChart---树图",
                @"invertedTreegraphChart---倒置树图",
                @"treegraphWithBoxLayoutChart---树图(盒子布局)",
                @"calendarHeatmap---日历热力图",
                @"treemapWithLevelsData2---包含等级的矩形树图2🌲",

            ],
//            "BubbleChart | 气泡类型图表",
            @[
                @"packedbubbleChart---气泡🎈填充图",
                @"packedbubbleSplitChart---圆🎈堆积图",
                @"packedbubbleSpiralChart---渐进变化的气泡🎈图",
                @"eulerChart---欧拉图",
                @"vennChart---韦恩图",
            ],
//            "ColumnVariantChart | 柱形图(变体)类型图表",
            @[
                @"variwideChart---可变宽度的柱形图",
                @"columnpyramidChart---角锥柱形图",
                @"dumbbellChart---哑铃图",
                @"lollipopChart---棒棒糖🍭图",
                @"xrangeChart---X轴范围图||甘特图||条码图",
                @"histogramChart---直方混合散点图📊",
                @"bellcurveChart---钟形曲线混合散点图🔔",
                @"bulletChart---子弹图",
                //     case  8: return [AAColumnVariantChartComposer pictorial1Chart];
                    //        case  9: return [AAColumnVariantChartComposer pictorial2Chart];

                    @"pictorial1Chart---象形柱形图1",
                    @"pictorial2Chart---象形柱形图2",
            ],
//            "MoreProType | 更多高级类型图表",
            @[
                @"sunburstChart---旭日图",
                @"streamgraphChart---流图",
                @"vectorChart---向量图🏹",
                @"bellcurveChart---贝尔曲线图",
                @"timelineChart---时序图⌚️",
                @"itemChart---议会项目图",
                @"windbarbChart---风羽图",
                @"wordcloudChart---词云图",
                @"flameChart---火焰🔥图",
                @"itemChart2---议会项目图2",
                @"itemChart3---议会项目图3",
                @"icicleChart---冰柱图🧊",
                @"sunburstChart2---旭日图☀️",
                @"solidgaugeChart---活动图🏃🏻‍♀️",
                @"parallelCoordinatesSplineChart---平行坐标曲线图",
                @"parallelCoordinatesLineChart---平行坐标折线图📈",
                @"volinPlotChart---小提琴图🎻",
                @"variablepieChart---可变宽度的饼图🍪",
                @"semicircleSolidGaugeChart---半圆形活动图🏃🏻‍♀️",
            ],
            
            //            "RelationshipChart | 关系类型图表",
            //            case 0: return [AAHeatmapChartComposer heatmapChart];
            //            case 1: return [AAHeatmapChartComposer largeDataHeatmapChart];
            //            case 2: return [AAHeatmapChartComposer calendarHeatmap];
            @[
                @"heatmapChart---热力图🌡",
                @"largeDataHeatmapChart---大数据量热力图🌡",
                @"calendarHeatmap---日历热力图",
            ],
//            case 0: return [AATreemapChartComposer treemapWithColorAxisData];
//            case 1: return [AATreemapChartComposer treemapWithLevelsData];
//            case 2: return [AATreemapChartComposer treemapWithLevelsData2];
//            case 3: return [AATreemapChartComposer drilldownLargeDataTreemapChart];
            @[
                @"treemapWithColorAxisData---包含色彩轴的矩形树图🌲",
                @"treemapWithLevelsData---包含等级的矩形树图🌲",
                @"treemapWithLevelsData2---包含等级的矩形树图2🌲",
                @"drilldownLargeDataTreemapChart---可下钻的大数据量矩形树图🌲",
            ],
//            case 0: return [AATreegraphChartComposer treegraph];
//            case 1: return [AATreegraphChartComposer invertedTreegraph];
//            case 2: return [AATreegraphChartComposer treegraphWithBoxLayout];
             @[
                 @"treegraphChart---树图",
                 @"invertedTreegraphChart---倒置树图",
                 @"treegraphWithBoxLayoutChart---树图(盒子布局)",
             ],
            
            //            + (NSDictionary *)lineChart;
//            + (NSDictionary *)areaChart;
      //            + (NSDictionary *)columnChart;
            //            + (NSDictionary *)lineChartWithHundredsOfSeries;
            //            + (NSDictionary *)scatterChartOptions;
            //            + (NSDictionary *)areaRangeChart;
            //            + (NSDictionary *)columnRangeChart;
            //+ (NSDictionary *)bubbleChart
            //+ (NSDictionary *)heatmapChart
            //+ (NSDictionary *)stackingAreaChart;
//            + (NSDictionary *)stackingColumnChart;


            
            @[
                @"lineChart---折线图",
                @"areaChart---区域填充图",
                @"columnChart---柱形图",
                @"lineChartWithHundredsOfSeries---百个数据集的折线图",
                @"scatterChartOptions---散点图",
                @"areaRangeChart---区域范围图",
                @"columnRangeChart---柱形范围图",
                @"bubbleChart---气泡图",
                @"heatMapChart---热力图",
                @"stackingAreaChart---堆积区域填充图",
                @"stackingColumnChart---堆积柱形图",
            ],
            
            @[
                @"columnChart---柱形图",
            ],
            //+ (AAOptions *)_3DColumnWithStackingRandomData;
            //+ (AAOptions *)_3DColumnWithStackingAndGrouping;
            //            + (AAOptions *)_3DBarWithStackingRandomData;
            //            + (AAOptions *)_3DBarWithStackingAndGrouping;
            //+ (AAOptions *)_3DAreaChart;
            //+ (AAOptions *)_3DScatterChart;
            @[
                @"_3DColumnWithStackingRandomData---3D堆积随机柱形图",
                @"_3DColumnWithStackingAndGrouping---3D堆积且分组柱形图",
                @"_3DBarWithStackingRandomData---3D堆积随机条形图",
                @"_3DBarWithStackingAndGrouping---3D堆积且分组条形图",
                @"_3DAreaChart---3D区域填充图",
                @"_3DScatterChart---3D散点图",
                @"_3DPieChart---3D饼图🍪",
            ],
            @[
                @"UITableView 画廊",
                @"UICollectionView 画廊",
             
            ],
            
        ];
    }
    return _chartTypeNameArr;
}

- (NSArray *)sectionTypeArr {
    if (!_sectionTypeArr) {
        _sectionTypeArr = @[
            @"RelationshipChart | 关系类型图表",
            @"HeatOrTreeMapChart | 热力或树形类型图表",
            @"BubbleChart | 气泡类型图表",
            @"ColumnVariantChart | 柱形图(变体)类型图表",
            @"MoreProType | 更多高级类型图表",
            @"HeatmapChart | 热力图",
            @"TreemapChart | 矩形树图",
            @"TreegraphChart | 树图",
            @"BoostChart | 加速图表",
            @"DrilldownChart | 下钻图表",
            @"Options3DChart | 3D图表",
            @"Gallery | 画廊",

        ];
    }
    return _sectionTypeArr;
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
    
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    self.backgroundGradientLayer = gradientLayer;
}

- (UIView *)buildTableHeaderView {
    UIView *headerView = [[UIView alloc] init];
    headerView.translatesAutoresizingMaskIntoConstraints = NO;
    headerView.backgroundColor = [UIColor clearColor];

    UIView *cardView = [[UIView alloc] init];
    cardView.translatesAutoresizingMaskIntoConstraints = NO;
    cardView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.28];
    cardView.layer.cornerRadius = 24.0;
    cardView.layer.masksToBounds = NO;
    cardView.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.18].CGColor;
    cardView.layer.shadowOpacity = 0.12;
    cardView.layer.shadowOffset = CGSizeMake(0, 12);
    cardView.layer.shadowRadius = 24.0;
    [headerView addSubview:cardView];
    
    // Store reference for theming
    self.tableHeaderCardView = cardView;

    CAGradientLayer *cardGradient = [CAGradientLayer layer];
    cardGradient.colors = @[
        (__bridge id)AALightDarkColor(ColorWithRGB(0, 122, 255, 1), ColorWithRGB(28, 28, 30, 1)).CGColor,
        (__bridge id)AALightDarkColor(ColorWithRGB(85, 185, 255, 1), ColorWithRGB(58, 58, 60, 1)).CGColor
    ];
    cardGradient.startPoint = CGPointMake(0, 0);
    cardGradient.endPoint = CGPointMake(1, 1);
    cardGradient.cornerRadius = cardView.layer.cornerRadius;
    [cardView.layer insertSublayer:cardGradient atIndex:0];
    
    // Store reference for theming
    self.headerCardGradientLayer = cardGradient;

    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    titleLabel.numberOfLines = 0; // Allow multiple lines
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:26.0 weight:UIFontWeightBold];
    titleLabel.text = @"探索更丰富的高级图表示例";
    [cardView addSubview:titleLabel];
    
    // Store reference for theming
    self.headerTitleLabel = titleLabel;

    UILabel *subtitleLabel = [[UILabel alloc] init];
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    subtitleLabel.numberOfLines = 0; // Allow multiple lines
    subtitleLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.82];
    subtitleLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightRegular];
    subtitleLabel.text = @"精选多类图表，助你快速找到灵感。轻触任意卡片即可查看详细演示。";
    [cardView addSubview:subtitleLabel];
    
    // Store reference for theming
    self.headerSubtitleLabel = subtitleLabel;

    // Apply Auto Layout constraints
    [NSLayoutConstraint activateConstraints:@[
        [cardView.topAnchor constraintEqualToAnchor:headerView.topAnchor constant:32.0],
        [cardView.bottomAnchor constraintEqualToAnchor:headerView.bottomAnchor constant:-8.0],
        [cardView.leadingAnchor constraintEqualToAnchor:headerView.leadingAnchor constant:20.0],
        [cardView.trailingAnchor constraintEqualToAnchor:headerView.trailingAnchor constant:-20.0],

        [titleLabel.topAnchor constraintEqualToAnchor:cardView.topAnchor constant:24.0],
        [titleLabel.leadingAnchor constraintEqualToAnchor:cardView.leadingAnchor constant:24.0],
        [titleLabel.trailingAnchor constraintEqualToAnchor:cardView.trailingAnchor constant:-24.0],

        [subtitleLabel.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor constant:10.0],
        [subtitleLabel.leadingAnchor constraintEqualToAnchor:titleLabel.leadingAnchor],
        [subtitleLabel.trailingAnchor constraintEqualToAnchor:titleLabel.trailingAnchor],
        [subtitleLabel.bottomAnchor constraintEqualToAnchor:cardView.bottomAnchor constant:-24.0]
    ]];

    return headerView;
}

- (UIImage *)fallbackChevronImage {
    CGSize size = CGSizeMake(16, 16);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(4, 2)];
    [path addLineToPoint:CGPointMake(12, 8)];
    [path addLineToPoint:CGPointMake(4, 14)];
    BOOL isDarkMode = [self isDarkMode];
    UIColor *strokeColor = isDarkMode ? [UIColor colorWithWhite:0.8 alpha:0.95] : [UIColor colorWithWhite:0.25 alpha:0.9];
    [strokeColor setStroke];
    path.lineWidth = 2.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [path stroke];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Theme Support

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    if (@available(iOS 13.0, *)) {
        if ([self.traitCollection hasDifferentColorAppearanceComparedToTraitCollection:previousTraitCollection]) {
            // Only apply system theme changes if user hasn't manually overridden
            if (!self.hasManualThemeOverride) {
                [self applyTheme];
            }
        }
    }
}

- (BOOL)isDarkMode {
    // If user has manually overridden the theme, use that preference
    if (self.hasManualThemeOverride) {
        return self.manualDarkModeEnabled;
    }
    
    // Otherwise, follow system appearance
    if (@available(iOS 13.0, *)) {
        return self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark;
    }
    return NO;
}

- (void)applyTheme {
    BOOL isDarkMode = [self isDarkMode];
    
    // Update navigation bar appearance
    if (@available(iOS 13.0, *)) {
        UINavigationBarAppearance *appearance = [[UINavigationBarAppearance alloc] init];
        if (isDarkMode) {
            [appearance configureWithOpaqueBackground];
            appearance.backgroundColor = [UIColor colorWithRed:18/255.0 green:20/255.0 blue:28/255.0 alpha:1.0];
            appearance.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
        } else {
            [appearance configureWithOpaqueBackground];
            appearance.backgroundColor = [UIColor whiteColor];
            appearance.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor blackColor]};
        }
        appearance.shadowColor = [UIColor clearColor];
        self.navigationController.navigationBar.standardAppearance = appearance;
        self.navigationController.navigationBar.scrollEdgeAppearance = appearance;
    } else {
        self.navigationController.navigationBar.barTintColor = isDarkMode ? [UIColor colorWithRed:18/255.0 green:20/255.0 blue:28/255.0 alpha:1.0] : [UIColor whiteColor];
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: isDarkMode ? [UIColor whiteColor] : [UIColor blackColor]};
    }
    
    // Update background gradient
    [self updateBackgroundGradient];
    
    // Update header view if available
    if (self.tableHeaderCardView) {
        [self updateHeaderViewTheme];
    }
    
    // Update toggle button icon
    if (self.themeToggleButton) {
        self.themeToggleButton.image = [self themeToggleButtonImage];
    }
    
    // Reload visible cells to update their appearance
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.tableView reloadData];
    });
}

- (void)updateBackgroundGradient {
    if (!self.backgroundGradientLayer) return;
    
    BOOL isDarkMode = [self isDarkMode];
    
    NSArray *colors;
    if (isDarkMode) {
        // Deep, rich gradient for dark mode
        colors = @[
            (__bridge id)AABackgroundDarkStart.CGColor,
            (__bridge id)AABackgroundDarkMid.CGColor,
            (__bridge id)AABackgroundDarkEnd.CGColor
        ];
    } else {
        // Light, airy gradient for light mode
        colors = @[
            (__bridge id)AABackgroundLightStart.CGColor,
            (__bridge id)AABackgroundLightMid.CGColor,
            (__bridge id)AABackgroundLightEnd.CGColor
        ];
    }
    
    // Animate color transition
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
    
    NSArray *colors;
    if (isDarkMode) {
        // Sophisticated dark gradient
        colors = @[
            (__bridge id)ColorWithRGB(30, 32, 38, 1).CGColor,
            (__bridge id)ColorWithRGB(55, 60, 72, 1).CGColor
        ];
    } else {
        // Vibrant light gradient
        colors = @[
            (__bridge id)ColorWithRGB(0, 122, 255, 1).CGColor,
            (__bridge id)ColorWithRGB(75, 175, 255, 1).CGColor
        ];
    }
    
    // Animate gradient transition
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"colors"];
    animation.fromValue = self.headerCardGradientLayer.colors;
    animation.toValue = colors;
    animation.duration = 0.4;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.headerCardGradientLayer addAnimation:animation forKey:@"headerColorsChange"];
    
    self.headerCardGradientLayer.colors = colors;
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
        // Add subtle border for dark mode
        cardView.layer.borderWidth = 0.5;
        cardView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.12].CGColor;
    } else {
        cardView.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.25].CGColor;
        cardView.layer.shadowRadius = 16.0;
        cardView.layer.shadowOffset = CGSizeMake(0, 10);
        cardView.layer.borderWidth = 0;
        cardView.layer.borderColor = [UIColor clearColor].CGColor;
    }

    UIView *overlayView = [cardView viewWithTag:1007];
    if (overlayView) {
        overlayView.backgroundColor = [self cardOverlayBackgroundColor];
    }
}

- (void)updateBlurEffectView:(UIVisualEffectView *)blurView {
    if (!blurView) return;
    
    BOOL isDarkMode = [self isDarkMode];
    UIVisualEffect *newEffect = nil;
    
    if (@available(iOS 13.0, *)) {
        if (isDarkMode) {
            newEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemThinMaterialDark];
        } else {
            newEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleSystemThinMaterialLight];
        }
    } else {
        // Fallback for older iOS versions
        if (isDarkMode) {
            newEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        } else {
            newEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        }
    }
    
    blurView.effect = newEffect;
}

- (CGFloat)cardShadowBaseOpacity {
    BOOL isDarkMode = [self isDarkMode];
    return isDarkMode ? 0.45f : 0.20f;
}

- (UIColor *)cardOverlayBackgroundColor {
    BOOL isDarkMode = [self isDarkMode];
    if (isDarkMode) {
        return [UIColor colorWithWhite:0.12 alpha:0.72];
    }
    return [UIColor colorWithWhite:1.0 alpha:0.88];
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
    // Create theme toggle button
    UIImage *buttonImage = [self themeToggleButtonImage];
    self.themeToggleButton = [[UIBarButtonItem alloc] initWithImage:buttonImage
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(toggleThemeMode)];
    
    // Add accessibility
    self.themeToggleButton.accessibilityLabel = @"切换主题模式";
    self.themeToggleButton.accessibilityHint = @"在浅色和深色主题之间切换";
    
    // Set navigation bar button
    self.navigationItem.rightBarButtonItem = self.themeToggleButton;
}

- (UIImage *)themeToggleButtonImage {
    BOOL isDarkMode = [self isDarkMode];
    
    // Create a custom icon based on current theme
    CGSize size = CGSizeMake(24, 24);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (isDarkMode) {
        // Sun icon for switching to light mode
        UIColor *sunColor = [UIColor colorWithRed:1.0 green:0.85 blue:0.0 alpha:1.0];
        [sunColor setFill];
        [sunColor setStroke];
        
        // Draw sun circle
        CGFloat centerX = size.width / 2.0;
        CGFloat centerY = size.height / 2.0;
        CGFloat radius = 6.0;
        
        CGContextFillEllipseInRect(context, CGRectMake(centerX - radius, centerY - radius, radius * 2, radius * 2));
        
        // Draw sun rays
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
        // Moon icon for switching to dark mode
        UIColor *moonColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.6 alpha:1.0];
        [moonColor setFill];
        
        // Draw crescent moon
        CGFloat centerX = size.width / 2.0;
        CGFloat centerY = size.height / 2.0;
        CGFloat radius = 8.0;
        
        // Main circle
        CGContextAddEllipseInRect(context, CGRectMake(centerX - radius, centerY - radius, radius * 2, radius * 2));
        CGContextFillPath(context);
        
        // Subtract smaller circle to create crescent
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
    // Toggle manual override
    if (self.hasManualThemeOverride) {
        // If already overridden, toggle the preference
        self.manualDarkModeEnabled = !self.manualDarkModeEnabled;
    } else {
        // First time toggling, set opposite of current system theme
        self.hasManualThemeOverride = YES;
        if (@available(iOS 13.0, *)) {
            self.manualDarkModeEnabled = (self.traitCollection.userInterfaceStyle != UIUserInterfaceStyleDark);
        } else {
            self.manualDarkModeEnabled = YES; // Default to dark for older iOS
        }
    }
    
    // Save settings
    [self saveThemeSettings];
    
    // Update button image
    self.themeToggleButton.image = [self themeToggleButtonImage];
    
    // Apply new theme with animation
    [UIView transitionWithView:self.view
                      duration:0.35
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [self applyTheme];
                    }
                    completion:nil];
    
    // Show brief feedback
    [self showThemeToggleFeedback];
}

- (void)showThemeToggleFeedback {
    BOOL isDark = [self isDarkMode];
    NSString *message = isDark ? @"🌙 已切换到深色模式" : @"☀️ 已切换到浅色模式";
    
    // Create stylish feedback toast
    UIView *toastContainer = [[UIView alloc] init];
    toastContainer.backgroundColor = [UIColor clearColor];
    toastContainer.alpha = 0.0;
    
    // Add blur effect
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
    
    // Layout
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
    
    // Add subtle shadow
    toastContainer.layer.shadowColor = [UIColor blackColor].CGColor;
    toastContainer.layer.shadowOpacity = isDark ? 0.5 : 0.15;
    toastContainer.layer.shadowOffset = CGSizeMake(0, 8);
    toastContainer.layer.shadowRadius = 16.0;
    
    [self.view addSubview:toastContainer];
    
    // Elegant entrance animation
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
        // Auto dismiss after delay
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

