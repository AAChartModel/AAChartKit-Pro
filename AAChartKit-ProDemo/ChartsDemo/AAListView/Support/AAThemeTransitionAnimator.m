//
//  AAThemeTransitionAnimator.m
//  AAChartKit-ProDemo
//
//  ObjC port of the Swift ThemeTransitionAnimator from the AAChartKit-Swift-Pro companion app.
//

#import "AAThemeTransitionAnimator.h"
#import "AAThemeTransitionOrbView.h"

// ---------------------------------------------------------------------------
#pragma mark - Hex color helper

static UIColor *AAHexColor(NSInteger hex, CGFloat alpha) {
    CGFloat r = ((hex & 0xFF0000) >> 16) / 255.0;
    CGFloat g = ((hex & 0x00FF00) >>  8) / 255.0;
    CGFloat b =  (hex & 0x0000FF)        / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

// ---------------------------------------------------------------------------
#pragma mark - Palette

typedef struct {
    // Stored as __unsafe_unretained since structs can't own ObjC objects;
    // but we only hold them for the stack frame lifetime of animateToIsDark:…
    __unsafe_unretained UIColor *background;
    __unsafe_unretained NSArray<UIColor *> *primaryOrbColors;
    __unsafe_unretained NSArray<UIColor *> *secondaryOrbColors;
    __unsafe_unretained UIColor *glowColor;
    __unsafe_unretained UIColor *badgeFillColor;
} AAThemeTransitionPalette;

static NSString *AAThemeSymbolName(BOOL isDark) {
    return isDark ? @"moon.stars.fill" : @"sun.max.fill";
}

static UIBlurEffectStyle AAThemeBlurStyle(BOOL isDark) API_AVAILABLE(ios(13.0)) {
    return isDark ? UIBlurEffectStyleSystemUltraThinMaterialDark
                  : UIBlurEffectStyleSystemUltraThinMaterialLight;
}

// ---------------------------------------------------------------------------
#pragma mark - AAThemeTransitionAnimator

@implementation AAThemeTransitionAnimator

+ (void)animateToIsDark:(BOOL)isDark
               onWindow:(UIWindow *)window
             fromOrigin:(CGPoint)origin
             applyBlock:(void (^)(void))applyBlock {

    // ── Accessibility: reduced motion ──────────────────────────────────────
    if (UIAccessibilityIsReduceMotionEnabled()) {
        [UIView transitionWithView:window
                          duration:0.28
                           options:UIViewAnimationOptionTransitionCrossDissolve
                                   | UIViewAnimationOptionAllowAnimatedContent
                        animations:^{ if (applyBlock) applyBlock(); }
                        completion:nil];
        return;
    }

    // SF Symbols are iOS 13+. Fall back to cross-dissolve on earlier OS.
    if (@available(iOS 13.0, *)) {
        [self _runOrbAnimationToIsDark:isDark
                              onWindow:window
                            fromOrigin:origin
                            applyBlock:applyBlock];
    } else {
        [UIView transitionWithView:window
                          duration:0.35
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{ if (applyBlock) applyBlock(); }
                        completion:nil];
    }
}

// ---------------------------------------------------------------------------
#pragma mark - Private

+ (void)_runOrbAnimationToIsDark:(BOOL)isDark
                        onWindow:(UIWindow *)window
                      fromOrigin:(CGPoint)origin
                      applyBlock:(void (^)(void))applyBlock
API_AVAILABLE(ios(13.0)) {

    // ── Palette ─────────────────────────────────────────────────────────────
    UIColor *backgroundColor;
    NSArray<UIColor *> *primaryOrbColors;
    NSArray<UIColor *> *secondaryOrbColors;
    UIColor *glowColor;
    UIColor *badgeFillColor;

    if (isDark) {
        backgroundColor     = AAHexColor(0x020617, 1.0);
        primaryOrbColors    = @[ [AAHexColor(0x38BDF8, 1) colorWithAlphaComponent:0.96],
                                 [AAHexColor(0x312E81, 1) colorWithAlphaComponent:0.72],
                                 [AAHexColor(0x020617, 1) colorWithAlphaComponent:0.02] ];
        secondaryOrbColors  = @[ [AAHexColor(0x818CF8, 1) colorWithAlphaComponent:0.70],
                                 [AAHexColor(0x1D4ED8, 1) colorWithAlphaComponent:0.28],
                                 [AAHexColor(0x020617, 1) colorWithAlphaComponent:0.01] ];
        glowColor           = [AAHexColor(0x60A5FA, 1) colorWithAlphaComponent:0.36];
        badgeFillColor      = [AAHexColor(0x0F172A, 1) colorWithAlphaComponent:0.35];
    } else {
        backgroundColor     = AAHexColor(0xFFF7ED, 1.0);
        primaryOrbColors    = @[ [AAHexColor(0xFDE68A, 1) colorWithAlphaComponent:0.98],
                                 [AAHexColor(0xFB923C, 1) colorWithAlphaComponent:0.74],
                                 [AAHexColor(0xFFF7ED, 1) colorWithAlphaComponent:0.02] ];
        secondaryOrbColors  = @[ [AAHexColor(0xFDBA74, 1) colorWithAlphaComponent:0.66],
                                 [AAHexColor(0xF97316, 1) colorWithAlphaComponent:0.24],
                                 [AAHexColor(0xFFF7ED, 1) colorWithAlphaComponent:0.01] ];
        glowColor           = [AAHexColor(0xFDBA74, 1) colorWithAlphaComponent:0.32];
        badgeFillColor      = [[UIColor whiteColor] colorWithAlphaComponent:0.22];
    }

    // ── Overlay & snapshot ─────────────────────────────────────────────────
    UIView *overlay = [[UIView alloc] initWithFrame:window.bounds];
    overlay.userInteractionEnabled = NO;
    overlay.backgroundColor = UIColor.clearColor;

    UIView *snapshotView = [window snapshotViewAfterScreenUpdates:NO] ?: [[UIView alloc] initWithFrame:overlay.bounds];
    snapshotView.frame = overlay.bounds;
    [overlay addSubview:snapshotView];

    UIView *tintView = [[UIView alloc] initWithFrame:overlay.bounds];
    tintView.backgroundColor = backgroundColor;
    tintView.alpha = 0;
    [overlay addSubview:tintView];

    // ── Primary orb ─────────────────────────────────────────────────────────
    AAThemeTransitionOrbView *primaryOrb = [[AAThemeTransitionOrbView alloc]
                                            initWithFrame:CGRectMake(0, 0, 124, 124)];
    primaryOrb.center = origin;
    [primaryOrb configureWithColors:primaryOrbColors];
    primaryOrb.transform = CGAffineTransformMakeScale(0.18, 0.18);
    primaryOrb.alpha = 0.95;
    [overlay addSubview:primaryOrb];

    // ── Secondary orb ───────────────────────────────────────────────────────
    AAThemeTransitionOrbView *secondaryOrb = [[AAThemeTransitionOrbView alloc]
                                              initWithFrame:CGRectMake(0, 0, 88, 88)];
    secondaryOrb.center = origin;
    [secondaryOrb configureWithColors:secondaryOrbColors];
    secondaryOrb.transform = CGAffineTransformMakeScale(0.12, 0.12);
    secondaryOrb.alpha = 0.52;
    [overlay addSubview:secondaryOrb];

    // ── Glow view ───────────────────────────────────────────────────────────
    UIView *glowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 72, 72)];
    glowView.center = origin;
    glowView.backgroundColor = glowColor;
    glowView.layer.cornerRadius = 36;
    glowView.alpha = 0;
    [overlay addSubview:glowView];

    // ── Badge (blur + icon) ─────────────────────────────────────────────────
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:AAThemeBlurStyle(isDark)];
    UIVisualEffectView *badgeView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    badgeView.frame = CGRectMake(0, 0, 58, 58);
    badgeView.center = origin;
    badgeView.clipsToBounds = YES;
    badgeView.layer.cornerRadius = 29;
    badgeView.layer.borderWidth = 1;
    badgeView.layer.borderColor = [[UIColor whiteColor] colorWithAlphaComponent:0.22].CGColor;
    badgeView.contentView.backgroundColor = badgeFillColor;
    badgeView.alpha = 0;
    badgeView.transform = CGAffineTransformMakeScale(0.55, 0.55);

    UIImage *symbolConfig = [UIImage systemImageNamed:AAThemeSymbolName(isDark)
                                    withConfiguration:[UIImageSymbolConfiguration configurationWithPointSize:22
                                                                                                      weight:UIImageSymbolWeightSemibold]];
    UIImageView *symbolView = [[UIImageView alloc] initWithImage:symbolConfig];
    symbolView.tintColor = UIColor.whiteColor;
    symbolView.contentMode = UIViewContentModeScaleAspectFit;
    symbolView.frame = CGRectMake(0, 0, 24, 24);
    symbolView.center = CGPointMake(29, 29);
    [badgeView.contentView addSubview:symbolView];
    [overlay addSubview:badgeView];

    [window addSubview:overlay];

    // ── Scale targets ─────────────────────────────────────────────────────
    CGFloat maxDim = MAX(overlay.bounds.size.width, overlay.bounds.size.height);
    CGFloat primaryScale   = (maxDim / 124.0) * 3.2;
    CGFloat secondaryScale = (maxDim / 88.0)  * 2.6;

    // ── Kick off theme change at 0.16 s ────────────────────────────────────
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.16 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
        if (applyBlock) applyBlock();
    });

    // ── Keyframe animation (0.92 s) ────────────────────────────────────────
    [UIView animateKeyframesWithDuration:0.92
                                   delay:0
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                                         | UIViewKeyframeAnimationOptionBeginFromCurrentState
                              animations:^{

        // 0 – 0.22: tint flash, glow + badge appear
        [UIView addKeyframeWithRelativeStartTime:0.00 relativeDuration:0.22 animations:^{
            tintView.alpha     = isDark ? 0.18 : 0.24;
            glowView.alpha     = 0.48;
            glowView.transform = CGAffineTransformMakeScale(1.7, 1.7);
            badgeView.alpha    = 1;
            badgeView.transform = CGAffineTransformMakeScale(1.08, 1.08);
        }];

        // 0.03 – 0.63: orbs expand and fade out
        [UIView addKeyframeWithRelativeStartTime:0.03 relativeDuration:0.60 animations:^{
            primaryOrb.transform   = CGAffineTransformMakeScale(primaryScale,   primaryScale);
            primaryOrb.alpha       = 0;
            secondaryOrb.transform = CGAffineTransformMakeScale(secondaryScale, secondaryScale);
            secondaryOrb.alpha     = 0;
        }];

        // 0.14 – 0.52: snapshot dissolves away
        [UIView addKeyframeWithRelativeStartTime:0.14 relativeDuration:0.38 animations:^{
            snapshotView.alpha = 0;
        }];

        // 0.18 – 0.46: badge floats up and fades, glow fades
        [UIView addKeyframeWithRelativeStartTime:0.18 relativeDuration:0.28 animations:^{
            badgeView.transform = CGAffineTransformConcat(
                CGAffineTransformMakeTranslation(0, -16),
                CGAffineTransformMakeScale(0.9, 0.9)
            );
            badgeView.alpha    = 0;
            glowView.alpha     = 0;
        }];

        // 0.46 – 0.70: tint dissolves away
        [UIView addKeyframeWithRelativeStartTime:0.46 relativeDuration:0.24 animations:^{
            tintView.alpha = 0;
        }];

    } completion:^(BOOL finished) {
        [overlay removeFromSuperview];
    }];
}

@end
