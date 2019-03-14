//
//  PopUpManager.m
//  PopUpManager
//
//  Created by LC on 2019/1/17.
//  Copyright © 2019 CommonStructure. All rights reserved.
//

#import "WindowManager.h"
#import <UIKit/UIKit.h>

static WindowManager *sharedManager = nil;

@interface WindowManager()

@property (strong,nonatomic) UIView *bgView;
@property (strong,nonatomic) NSMutableDictionary<NSString *,BaseContainer *> *containers;

@end

@implementation WindowManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[WindowManager alloc] init];
    });
    return sharedManager;
}

//MARK: - 弹出window
- (void)bringUpWindow:(BaseWindow *)window {
    NSInteger level = window.priority/1000;
    [self bringUpWindow:window withContainerLevel:level];
}

- (void)bringUpWindow:(BaseWindow *)window withContainerLevel:(NSInteger)level {
    NSString *levelKey = [NSString stringWithFormat:@"%zd",level];
    BaseContainer *container = self.containers[levelKey];
    if (!container) {
        container = [[BaseContainer alloc] init];
        container.priority = levelKey.floatValue;
        self.containers[levelKey] = container;
    }
    [self bringUpContainer:container];
    [container bringUpWindow:window];
}

- (void)bringUpContainer:(BaseContainer *)container {
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if (!self.bgView.superview) {
        [window addSubview:self.bgView];
        [window bringSubviewToFront:self.bgView];
    }
    [self.bgView addSubview:container.bgView];
    container.bgView.layer.zPosition = container.priority;
}

//MARK: - 移除window
- (void)releaseWindow:(BaseWindow *)window withDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion {
    BaseContainer *targetContainer = [self containerForWindow:window];
    if (targetContainer) {
        [targetContainer releaseWindow:window withDuration:duration animations:animations completion:completion];
    }
}

- (void)releaseWindow:(BaseWindow *)window {
    BaseContainer *targetContainer = [self containerForWindow:window];
    if (targetContainer) {
        [targetContainer releaseWindow:window];
    }
}

- (BaseContainer *)containerForWindow:(BaseWindow *)window {
    BaseContainer *targetContainer = nil;
    if (self.containers.count>0) {
        for (NSString *levelKey in self.containers) {
            BaseContainer *container = self.containers[levelKey];
            NSArray *windows = [container valueForKey:@"windows"];
            if ([windows containsObject:window]) {
                targetContainer = container;
                break;
            }
        }
    }
    return targetContainer;
}

//MARK: - 移除container
- (void)releaseContainer:(BaseContainer *)container {
    if (container.bgView.superview) {
        [container.bgView removeFromSuperview];
    }
    [self containerReleased];
}

//MARK: - 不持有container时释放bg
- (void)containerReleased {
    if (_bgView) {
        if (_bgView.subviews==nil||_bgView.subviews.count==0) {
            [self releaseBackground];
        }
    }
}

- (void)releaseBackground {
    [_bgView removeFromSuperview];
    _bgView = nil;
}

//MARK: - getter
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    }
    return _bgView;
}

- (NSMutableDictionary *)containers {
    if (!_containers) {
        _containers = [NSMutableDictionary dictionary];
    }
    return _containers;
}

@end
