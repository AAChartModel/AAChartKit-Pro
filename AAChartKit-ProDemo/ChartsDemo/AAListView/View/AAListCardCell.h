#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface AAListCardCell : UITableViewCell

@property (nonatomic, strong, readonly) UIView *cardContainerView;

+ (NSString *)reuseIdentifier;
+ (CGFloat)cardShadowBaseOpacityForDarkMode:(BOOL)isDarkMode;

- (void)configureWithPrimaryTitle:(NSString *)primaryTitle
                    secondaryTitle:(NSString *)secondaryTitle
                          badgeText:(NSString *)badgeText
                          darkMode:(BOOL)isDarkMode
                        accentColor:(UIColor *)accentColor;

- (void)applyThemeWithDarkMode:(BOOL)isDarkMode accentColor:(UIColor *)accentColor;

@end

NS_ASSUME_NONNULL_END
