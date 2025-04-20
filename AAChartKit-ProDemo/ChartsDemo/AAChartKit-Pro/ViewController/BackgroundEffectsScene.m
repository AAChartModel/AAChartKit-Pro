#import "BackgroundEffectsScene.h"
#import <SpriteKit/SpriteKit.h>

// 重新定义常量
#define NUM_SEARCHLIGHTS 4 // 修改为 4
#define OVERLAP_ANGLE_THRESHOLD (M_PI / 12.0) // 光束角度小于这个阈值视为重叠 (可调整)
#define FLASH_DURATION 0.5 // 碰撞闪烁的总持续时间

@interface BackgroundEffectsScene()

// 重新添加探照灯属性
@property (nonatomic, strong) NSMutableArray<SKShapeNode *> *searchlightNodes;
@property (nonatomic, strong) SKEffectNode *effectNode; // 用于模糊和混合
@property (nonatomic, strong) NSArray<SKColor *> *lightColors; // 预设颜色
@property (nonatomic, strong) NSMutableArray<NSNumber *> *isFlashing; // 跟踪每个光束是否在闪烁
@property (nonatomic, strong) SKAction *collisionFlashAction; // 碰撞时的闪烁动作

@end

@implementation BackgroundEffectsScene

- (void)didMoveToView:(SKView *)view {
    [super didMoveToView:view];

    // 恢复深色背景
    self.backgroundColor = [SKColor colorWithRed:0.01 green:0.01 blue:0.05 alpha:1.0];

    // 恢复初始化颜色数组
    self.lightColors = @[
        [SKColor colorWithRed:0.8 green:0.2 blue:0.2 alpha:0.7], // Red-ish
        [SKColor colorWithRed:0.2 green:0.8 blue:0.2 alpha:0.7], // Green-ish
        [SKColor colorWithRed:0.2 green:0.4 blue:0.9 alpha:0.7], // Blue-ish
        [SKColor colorWithRed:0.8 green:0.8 blue:0.2 alpha:0.7], // Yellow-ish
        [SKColor colorWithRed:0.8 green:0.3 blue:0.8 alpha:0.7], // Magenta-ish
        [SKColor colorWithRed:0.2 green:0.8 blue:0.8 alpha:0.7]  // Cyan-ish
    ];

    // 恢复初始化闪烁状态跟踪数组 (容量改为 NUM_SEARCHLIGHTS)
    self.isFlashing = [NSMutableArray arrayWithCapacity:NUM_SEARCHLIGHTS];
    for (int i = 0; i < NUM_SEARCHLIGHTS; ++i) {
        [self.isFlashing addObject:@(NO)];
    }

    // 恢复调用探照灯设置方法
    [self setupEffectNode];
    [self setupSearchlights];
    [self createCollisionFlashAction];
    [self startSearchlightAnimation];
}

// 恢复：设置效果节点 (模糊和混合)
- (void)setupEffectNode {
    self.effectNode = [SKEffectNode node];
    self.effectNode.filter = [CIFilter filterWithName:@"CIGaussianBlur"
                                   withInputParameters:@{@"inputRadius": @15.0}];
    self.effectNode.shouldEnableEffects = YES;
    self.effectNode.blendMode = SKBlendModeAdd;
    self.effectNode.zPosition = 1;
    [self addChild:self.effectNode];
}

// 恢复：设置固定数量的探照灯 - 修改为支持多个角落
- (void)setupSearchlights {
    self.searchlightNodes = [NSMutableArray array];
    CGFloat beamLength = self.size.height * 1.8;
    CGFloat beamWidth = 150.0;

    for (int i = 0; i < NUM_SEARCHLIGHTS; ++i) {
        SKShapeNode *lightNode = [SKShapeNode node];
        CGPoint origin;
        CGFloat initialAngleMin, initialAngleMax;

        // 根据索引确定光源位置和初始角度范围
        if (i < NUM_SEARCHLIGHTS / 2) { // 左下角光源 (0, 1)
            origin = CGPointMake(0, 0);
            initialAngleMin = M_PI / 8.0; // 指向右上
            initialAngleMax = 3 * M_PI / 8.0;
        } else { // 右下角光源 (2, 3)
            origin = CGPointMake(self.size.width, 0);
            initialAngleMin = 5 * M_PI / 8.0; // 指向左上
            initialAngleMax = 7 * M_PI / 8.0;
        }

        lightNode.position = origin;

        // 创建三角形路径代表光束
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 0, 0);
        CGPathAddLineToPoint(path, NULL, beamLength, -beamWidth / 2.0);
        CGPathAddLineToPoint(path, NULL, beamLength, beamWidth / 2.0);
        CGPathCloseSubpath(path);
        lightNode.path = path;
        CFRelease(path);

        lightNode.fillColor = self.lightColors[arc4random_uniform((uint32_t)self.lightColors.count)];
        lightNode.strokeColor = [SKColor clearColor];

        // 设置初始旋转角度
        CGFloat initialAngle = initialAngleMin + (arc4random_uniform(100) / 100.0) * (initialAngleMax - initialAngleMin);
        lightNode.zRotation = initialAngle;

        [self.effectNode addChild:lightNode];
        [self.searchlightNodes addObject:lightNode];
    }
}

// 恢复：创建碰撞闪烁动作
- (void)createCollisionFlashAction {
    SKAction *flashToWhite = [SKAction colorizeWithColor:[SKColor colorWithWhite:1.0 alpha:0.9] colorBlendFactor:1.0 duration:FLASH_DURATION / 2.0];
    flashToWhite.timingMode = SKActionTimingEaseOut;
    SKAction *revertColor = [flashToWhite reversedAction];
    revertColor.timingMode = SKActionTimingEaseIn;
    self.collisionFlashAction = [SKAction sequence:@[flashToWhite, revertColor]];
}

// 恢复：启动固定数量探照灯的动画 - 修改目标角度
- (void)startSearchlightAnimation {
    for (int i = 0; i < self.searchlightNodes.count; ++i) {
         SKShapeNode *lightNode = self.searchlightNodes[i];
         __weak SKShapeNode *weakLightNode = lightNode;
         __weak BackgroundEffectsScene *weakSelf = self;
         BOOL isLeftOrigin = (i < NUM_SEARCHLIGHTS / 2);

         [lightNode removeAllActions];

        SKAction * (^createAnimationBlock)(void) = ^{
            SKShapeNode *strongLightNode = weakLightNode;
            BackgroundEffectsScene *strongSelf = weakSelf;
            if (!strongLightNode || !strongSelf) return [SKAction waitForDuration:0.1];

            // 旋转动作
            CGFloat currentAngle = strongLightNode.zRotation;
            CGFloat targetAngleMin, targetAngleMax;

            if (isLeftOrigin) { // 左下角光源 -> 指向右上
                targetAngleMin = M_PI / 8.0;
                targetAngleMax = 7.0 * M_PI / 16.0;
            } else { // 右下角光源 -> 指向左上
                targetAngleMin = 9.0 * M_PI / 16.0;
                targetAngleMax = 7.0 * M_PI / 8.0;
            }

            CGFloat targetAngle = targetAngleMin + (arc4random_uniform(100) / 100.0) * (targetAngleMax - targetAngleMin);

            if (fabs(targetAngle - currentAngle) < M_PI / 16.0) {
                 targetAngle += (targetAngleMax - targetAngleMin) / 4.0 * (arc4random_uniform(2) ? 1 : -1);
                 targetAngle = MAX(targetAngleMin, MIN(targetAngleMax, targetAngle));
            }
            SKAction *rotate = [SKAction rotateToAngle:targetAngle duration:(arc4random_uniform(20) + 30) / 10.0];
            rotate.timingMode = SKActionTimingEaseInEaseOut;

            // 颜色动作
            SKColor *nextColor = strongSelf.lightColors[arc4random_uniform((uint32_t)strongSelf.lightColors.count)];
            while ([nextColor isEqual:strongLightNode.fillColor] && strongSelf.lightColors.count > 1) {
                 nextColor = strongSelf.lightColors[arc4random_uniform((uint32_t)strongSelf.lightColors.count)];
            }
            SKAction *changeColor = [SKAction colorizeWithColor:nextColor colorBlendFactor:1.0 duration:1.5];

            // 组合动作
            CGFloat maxDuration = MAX(rotate.duration, changeColor.duration + 0.5);
            SKAction *group = [SKAction group:@[rotate, changeColor]];
            SKAction *wait = [SKAction waitForDuration:maxDuration + (arc4random_uniform(10)/10.0)];

            return [SKAction sequence:@[group, wait]];
        };

        SKAction *repeatBlock = [SKAction repeatActionForever:[SKAction sequence:@[
            [SKAction runBlock:^{
                SKShapeNode *strongLightNode = weakLightNode;
                if (strongLightNode) {
                    SKAction *singleAnimation = createAnimationBlock();
                    [strongLightNode runAction:singleAnimation withKey:@"singleCycle"];
                }
            }],
            [SKAction waitForDuration:6.0 withRange:2.0]
        ]]];

        [lightNode runAction:repeatBlock withKey:@"mainLoop"];
    }
}

#pragma mark - Update Loop for Animation / Collision Check

// 恢复 Update 循环 - 修改为检查所有对
- (void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];

    // 检查光束之间的角度差异
    for (int i = 0; i < self.searchlightNodes.count; ++i) {
        for (int j = i + 1; j < self.searchlightNodes.count; ++j) {
            if (i >= self.searchlightNodes.count || j >= self.searchlightNodes.count ||
                i >= self.isFlashing.count || j >= self.isFlashing.count) {
                continue;
            }

            SKShapeNode *light1 = self.searchlightNodes[i];
            SKShapeNode *light2 = self.searchlightNodes[j];
            BOOL flashing1 = [self.isFlashing[i] boolValue];
            BOOL flashing2 = [self.isFlashing[j] boolValue];

            CGFloat angleDifference = fabs(light1.zRotation - light2.zRotation);
            if (angleDifference > M_PI) {
                angleDifference = 2 * M_PI - angleDifference;
            }

            if (angleDifference < OVERLAP_ANGLE_THRESHOLD) {
                if (!flashing1) {
                    self.isFlashing[i] = @(YES);
                    [light1 runAction:self.collisionFlashAction completion:^{
                        if (i < self.isFlashing.count) self.isFlashing[i] = @(NO);
                    }];
                }
                if (!flashing2) {
                    self.isFlashing[j] = @(YES);
                    [light2 runAction:self.collisionFlashAction completion:^{
                         if (j < self.isFlashing.count) self.isFlashing[j] = @(NO);
                    }];
                }
            }
        }
    }
}

// 当场景尺寸变化时调整精灵节点尺寸
- (void)didChangeSize:(CGSize)oldSize {
    [super didChangeSize:oldSize];
}

@end
