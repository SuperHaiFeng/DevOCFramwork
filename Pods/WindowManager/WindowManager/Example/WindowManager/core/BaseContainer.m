//
//  PopUpContainer.m
//  PopUpManager
//
//  Created by LC on 2019/1/17.
//  Copyright © 2019 CommonStructure. All rights reserved.
//

#import "BaseContainer.h"
#import "WindowManager.h"

@interface BaseContainer()

@property (assign,nonatomic) BOOL windowDismissing;
@property (strong,nonatomic) NSArray<BaseWindow *> *windows;
@property (strong,nonatomic) BaseWindow *currentWindow;
@property (strong,nonatomic) NSMutableDictionary<NSString *,NSNumber *> *displayRecord;

@end

@implementation BaseContainer

- (void)bringUpWindow:(BaseWindow *)window {
    NSString *key = [NSString stringWithFormat:@"%p",window];
    self.displayRecord[key] = @(NO);
    if (self.currentWindow&&!self.windowDismissing) {
        if (window.priority>self.currentWindow.priority) {
            [self.currentWindow removeFromSuperview];
            [self.currentWindow didSendedToBack];
            self.currentWindow = nil;
        }
    }
    NSArray *arr = nil;
    if (self.windows&&self.windows.count>0) {
        NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.windows];
        [mArr addObject:window];
        arr = [self bubbleSort:[mArr copy]];
    }else {
        arr = @[window];
    }
    self.windows = arr;
    if (self.windows&&self.windows.count>0) {
        if (!self.windowDismissing) {
            self.currentWindow = self.windows.firstObject;
            [self.bgView addSubview:self.currentWindow];
            [self.currentWindow didDisplayedOnFront:!self.displayRecord[key].boolValue];
            self.displayRecord[key] = @(YES);
        }
    }
}

- (NSArray *)bubbleSort:(NSArray *)arr {
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:arr];
    if (mArr.count<2) {
        return [mArr copy];
    }
    [mArr sortUsingComparator:^NSComparisonResult(BaseWindow*  _Nonnull obj1, BaseWindow*  _Nonnull obj2) {
        NSComparisonResult result = NSOrderedSame;
        if (obj1.priority < obj2.priority) {
            result = NSOrderedDescending;
        }
        return result;
    }];
    return [mArr copy];
}

//MARK: - 移除window
- (void)releaseWindow:(BaseWindow *)window withDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion {
    self.windowDismissing = YES;
    [UIView animateWithDuration:duration animations:^{
        if (animations) {
            animations();
        }
    } completion:^(BOOL finished) {
        self.windowDismissing = NO;
        if (completion) {
            completion(finished);
        }
        [self releaseWindow:window];
    }];
}

- (void)releaseWindow:(BaseWindow *)window {
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:self.windows];
    if (window.superview) {
        [window removeFromSuperview];
        NSString *key = [NSString stringWithFormat:@"%p",window];
        [self.displayRecord removeObjectForKey:key];
    }
    [mArr removeObject:window];
    if (mArr.count>0) {
        self.windows = [self bubbleSort:[mArr copy]];
        self.currentWindow = self.windows.firstObject;
        NSString *key = [NSString stringWithFormat:@"%p",self.currentWindow];
        [self.bgView addSubview:self.currentWindow];
        [self.currentWindow didDisplayedOnFront:!self.displayRecord[key].boolValue];
        self.displayRecord[key] = @(YES);
    }else {
        self.windows = nil;
        [[WindowManager sharedManager] releaseContainer:self];
        _bgView = nil;
    }
}

- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    }
    return _bgView;
}

- (NSMutableDictionary<NSString *,NSNumber *> *)displayRecord {
    if (!_displayRecord) {
        _displayRecord = [NSMutableDictionary dictionary];
    }
    return _displayRecord;
}

@end
