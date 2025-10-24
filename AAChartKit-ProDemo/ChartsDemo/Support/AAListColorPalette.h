#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

#define ColorWithRGB(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

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

static inline UIColor *AALightDarkColor(UIColor *lightColor, UIColor * _Nullable darkColor) {
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

NS_ASSUME_NONNULL_END
