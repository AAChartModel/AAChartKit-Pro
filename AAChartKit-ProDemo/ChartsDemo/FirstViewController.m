//
//  FirstViewController.m
//  AAChartKit
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

#define ColorWithRGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
#define AAGrayColor            [UIColor colorWithRed:245/255.0 green:246/255.0 blue:247/255.0 alpha:1.0]
#define AABlueColor            ColorWithRGB(63, 153,231,1)

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

@implementation FirstViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self applyTheme];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AAChartKit-Pro";
    self.view.backgroundColor = [UIColor whiteColor];

    [self loadThemeSettings];
    [self setupThemeToggleButton];
    [self setupBackgroundGradient];
    [self configTheTableView];
    [self applyTheme];
}

- (void)configTheTableView {
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
    tableView.contentInset = UIEdgeInsetsMake(24, 0, 40, 0);
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 64;
    tableView.tableFooterView = [UIView new];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    backgroundView.backgroundColor = [UIColor clearColor];
    tableView.backgroundView = backgroundView;
    
    [self.view addSubview:tableView];
    [self.view addConstraints:[self configureTheConstraintArrayWithItem:tableView toItem:self.view]];

    tableView.tableHeaderView = [self buildTableHeaderView];
    self.tableView = tableView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    if (self.backgroundGradientLayer) {
        self.backgroundGradientLayer.frame = self.view.bounds;
    }
    if (self.tableView.tableHeaderView) {
        UIView *headerView = self.tableView.tableHeaderView;
        CGFloat requiredWidth = CGRectGetWidth(self.view.bounds);
        if (fabs(headerView.frame.size.width - requiredWidth) > 0.5) {
            CGRect frame = headerView.frame;
            frame.size.width = requiredWidth;
            headerView.frame = frame;
            self.tableView.tableHeaderView = headerView;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.chartTypeNameArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 76;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 58;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *containerView = [[UIView alloc] init];
    containerView.backgroundColor = [UIColor clearColor];

    BOOL isDarkMode = [self isDarkMode];

    UIView *backdropView = [[UIView alloc] init];
    backdropView.translatesAutoresizingMaskIntoConstraints = NO;
    backdropView.layer.cornerRadius = 16.0;
    backdropView.layer.masksToBounds = NO;

    if (isDarkMode) {
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)ColorWithRGB(44, 46, 68, 1).CGColor,
                                 (__bridge id)ColorWithRGB(58, 66, 96, 1).CGColor,
                                 (__bridge id)ColorWithRGB(38, 50, 96, 1).CGColor];
        gradientLayer.startPoint = CGPointMake(0.0, 0.0);
        gradientLayer.endPoint = CGPointMake(1.0, 1.0);
        gradientLayer.frame = backdropView.bounds;
        gradientLayer.cornerRadius = backdropView.layer.cornerRadius;
        gradientLayer.masksToBounds = YES;
        gradientLayer.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;
        [backdropView.layer insertSublayer:gradientLayer atIndex:0];

        backdropView.layer.shadowColor = [UIColor blackColor].CGColor;
        backdropView.layer.shadowOpacity = 0.45;
        backdropView.layer.shadowOffset = CGSizeMake(0, 10);
        backdropView.layer.shadowRadius = 22.0;
        backdropView.layer.borderWidth = 0.6;
        backdropView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.12].CGColor;
    } else {
        // Create a gentle pastel gradient for light mode
        UIColor *gradientTopColor = ColorWithRGB(248, 251, 255, 1);
        UIColor *gradientBottomColor = ColorWithRGB(232, 239, 255, 1);
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        gradientLayer.colors = @[(__bridge id)gradientTopColor.CGColor,
                                 (__bridge id)gradientBottomColor.CGColor];
        gradientLayer.startPoint = CGPointMake(0.0, 0.0);
        gradientLayer.endPoint = CGPointMake(1.0, 1.0);
        gradientLayer.frame = backdropView.bounds;
        gradientLayer.cornerRadius = backdropView.layer.cornerRadius;
        gradientLayer.masksToBounds = YES;
        gradientLayer.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;
        [backdropView.layer insertSublayer:gradientLayer atIndex:0];

        backdropView.layer.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:0.12].CGColor;
        backdropView.layer.shadowOpacity = 0.18;
        backdropView.layer.shadowOffset = CGSizeMake(0, 6);
        backdropView.layer.shadowRadius = 14.0;
        backdropView.layer.borderWidth = 1.0;
        backdropView.layer.borderColor = ColorWithRGB(220, 231, 255, 1).CGColor;
        backdropView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.85];
    }
    [containerView addSubview:backdropView];

    UIView *accentView = [[UIView alloc] init];
    accentView.translatesAutoresizingMaskIntoConstraints = NO;
    // Enhanced accent colors with better visibility
    UIColor *lightAccent = ColorWithRGB(88, 116, 255, 1);
    UIColor *darkAccent = ColorWithRGB(120, 140, 255, 1);
    accentView.backgroundColor = isDarkMode ? darkAccent : lightAccent;
    accentView.layer.cornerRadius = 3.0;
    // Add glow effect for dark mode
    if (isDarkMode) {
        accentView.layer.shadowColor = darkAccent.CGColor;
        accentView.layer.shadowOpacity = 0.6;
        accentView.layer.shadowOffset = CGSizeMake(0, 0);
        accentView.layer.shadowRadius = 4.0;
    } else {
        accentView.layer.shadowColor = lightAccent.CGColor;
        accentView.layer.shadowOpacity = 0.28;
        accentView.layer.shadowOffset = CGSizeMake(0, 3);
        accentView.layer.shadowRadius = 6.0;
    }
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
        cardView = [[UIView alloc] init];
        cardView.tag = 1001;
        cardView.translatesAutoresizingMaskIntoConstraints = NO;
        cardView.backgroundColor = [UIColor clearColor];
        cardView.layer.cornerRadius = 18.0;
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
        badgeLabel.font = [UIFont systemFontOfSize:13.0 weight:UIFontWeightSemibold];
        // Simple and reliable badge styling
        badgeLabel.textColor = [UIColor whiteColor];
         isDarkMode = [self isDarkMode];
        if (isDarkMode) {
            badgeLabel.backgroundColor = ColorWithRGB(110, 130, 255, 1);
        } else {
            badgeLabel.backgroundColor = ColorWithRGB(93, 112, 255, 1);
        }
        badgeLabel.layer.cornerRadius = 15.0;
        badgeLabel.layer.masksToBounds = NO;
        
        // Add subtle glow for dark mode
        if (isDarkMode) {
            badgeLabel.layer.shadowColor = ColorWithRGB(110, 130, 255, 1).CGColor;
            badgeLabel.layer.shadowOpacity = 0.4;
            badgeLabel.layer.shadowOffset = CGSizeMake(0, 0);
            badgeLabel.layer.shadowRadius = 6.0;
        } else {
            badgeLabel.layer.shadowOpacity = 0.0;
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
    [UIView animateWithDuration:0.18 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        cardView.transform = CGAffineTransformMakeScale(0.97, 0.97);
        cardView.layer.shadowOpacity = MAX(baseOpacity * 0.55, 0.08f);
    } completion:nil];
}

- (void)tableView:(UITableView *)tableView didUnhighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIView *cardView = [cell.contentView viewWithTag:1001];
    if (!cardView) { return; }
    CGFloat baseOpacity = [self cardShadowBaseOpacity];
    [UIView animateWithDuration:0.22 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        cardView.transform = CGAffineTransformIdentity;
        cardView.layer.shadowOpacity = baseOpacity;
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
    gradientLayer.colors = @[(__bridge id)ColorWithRGB(238, 243, 255, 1).CGColor,
                             (__bridge id)ColorWithRGB(222, 238, 255, 1).CGColor,
                             (__bridge id)ColorWithRGB(247, 233, 255, 1).CGColor];
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(1.0, 1.0);
    gradientLayer.locations = @[@0.0, @0.5, @1.0];
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    self.backgroundGradientLayer = gradientLayer;
}

- (UIView *)buildTableHeaderView {
    CGFloat width = CGRectGetWidth(self.view.bounds);
    CGFloat headerHeight = 160.0;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, headerHeight)];
    headerView.backgroundColor = [UIColor clearColor];

    UIView *cardView = [[UIView alloc] initWithFrame:CGRectInset(headerView.bounds, 20.0, 32.0)];
    cardView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
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
    cardGradient.colors = @[(__bridge id)ColorWithRGB(109, 129, 255, 1).CGColor,
                            (__bridge id)ColorWithRGB(172, 132, 255, 1).CGColor];
    cardGradient.startPoint = CGPointMake(0, 0);
    cardGradient.endPoint = CGPointMake(1, 1);
    cardGradient.frame = cardView.bounds;
    cardGradient.cornerRadius = cardView.layer.cornerRadius;
    cardGradient.autoresizingMask = kCALayerWidthSizable | kCALayerHeightSizable;
    [cardView.layer insertSublayer:cardGradient atIndex:0];
    
    // Store reference for theming
    self.headerCardGradientLayer = cardGradient;

    CGRect cardBounds = cardView.bounds;
    CGFloat horizontalPadding = 24.0;
    CGFloat verticalPadding = 24.0;
    CGRect titleFrame = CGRectMake(horizontalPadding,
                                   verticalPadding,
                                   cardBounds.size.width - horizontalPadding * 2,
                                   32.0);

    UILabel *titleLabel = [[UILabel alloc] initWithFrame:titleFrame];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
    titleLabel.numberOfLines = 2;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:26.0 weight:UIFontWeightBold];
    titleLabel.text = @"探索更丰富的高级图表示例";
    [cardView addSubview:titleLabel];
    
    // Store reference for theming
    self.headerTitleLabel = titleLabel;

    CGFloat subtitleTop = CGRectGetMaxY(titleFrame) + 10.0;
    CGRect subtitleFrame = CGRectMake(horizontalPadding,
                                      subtitleTop,
                                      cardBounds.size.width - horizontalPadding * 2,
                                      cardBounds.size.height - subtitleTop - verticalPadding);

    UILabel *subtitleLabel = [[UILabel alloc] initWithFrame:subtitleFrame];
    subtitleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    subtitleLabel.numberOfLines = 2;
    subtitleLabel.textColor = [[UIColor whiteColor] colorWithAlphaComponent:0.82];
    subtitleLabel.font = [UIFont systemFontOfSize:15.0 weight:UIFontWeightRegular];
    subtitleLabel.text = @"精选多类图表，助你快速找到灵感。轻触任意卡片即可查看详细演示。";
    [cardView addSubview:subtitleLabel];
    
    // Store reference for theming
    self.headerSubtitleLabel = subtitleLabel;

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
    if (isDarkMode) {
        self.backgroundGradientLayer.colors = @[
            (__bridge id)[UIColor colorWithRed:18/255.0 green:20/255.0 blue:28/255.0 alpha:1.0].CGColor,
            (__bridge id)[UIColor colorWithRed:28/255.0 green:32/255.0 blue:45/255.0 alpha:1.0].CGColor,
            (__bridge id)[UIColor colorWithRed:35/255.0 green:25/255.0 blue:45/255.0 alpha:1.0].CGColor
        ];
    } else {
        self.backgroundGradientLayer.colors = @[
            (__bridge id)ColorWithRGB(238, 243, 255, 1).CGColor,
            (__bridge id)ColorWithRGB(222, 238, 255, 1).CGColor,
            (__bridge id)ColorWithRGB(247, 233, 255, 1).CGColor
        ];
    }
}

- (void)updateHeaderViewTheme {
    if (!self.headerCardGradientLayer) return;
    
    BOOL isDarkMode = [self isDarkMode];
    if (isDarkMode) {
        self.headerCardGradientLayer.colors = @[
            (__bridge id)ColorWithRGB(75, 85, 155, 1).CGColor,
            (__bridge id)ColorWithRGB(125, 95, 185, 1).CGColor
        ];
    } else {
        self.headerCardGradientLayer.colors = @[
            (__bridge id)ColorWithRGB(109, 129, 255, 1).CGColor,
            (__bridge id)ColorWithRGB(172, 132, 255, 1).CGColor
        ];
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
    NSString *message = [self isDarkMode] ? @"🌙 已切换到深色模式" : @"☀️ 已切换到浅色模式";
    
    // Create temporary feedback label
    UILabel *feedbackLabel = [[UILabel alloc] init];
    feedbackLabel.text = message;
    feedbackLabel.textColor = [UIColor whiteColor];
    feedbackLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.8];
    feedbackLabel.font = [UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium];
    feedbackLabel.textAlignment = NSTextAlignmentCenter;
    feedbackLabel.layer.cornerRadius = 20.0;
    feedbackLabel.layer.masksToBounds = YES;
    feedbackLabel.alpha = 0.0;
    
    // Size and position
    [feedbackLabel sizeToFit];
    CGRect frame = feedbackLabel.frame;
    frame.size.width += 32.0; // Add padding
    frame.size.height = 40.0;
    feedbackLabel.frame = frame;
    feedbackLabel.center = CGPointMake(self.view.center.x, self.view.center.y - 100);
    
    [self.view addSubview:feedbackLabel];
    
    // Animate feedback
    [UIView animateWithDuration:0.3 animations:^{
        feedbackLabel.alpha = 1.0;
        feedbackLabel.transform = CGAffineTransformMakeScale(1.1, 1.1);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            feedbackLabel.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished2) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [UIView animateWithDuration:0.3 animations:^{
                    feedbackLabel.alpha = 0.0;
                } completion:^(BOOL finished3) {
                    [feedbackLabel removeFromSuperview];
                }];
            });
        }];
    }];
}

@end

