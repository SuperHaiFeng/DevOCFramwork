//
//  PopUpContainer.h
//  PopUpManager
//
//  Created by LC on 2019/1/17.
//  Copyright © 2019 CommonStructure. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseWindow.h"

NS_ASSUME_NONNULL_BEGIN

@interface BaseContainer : NSObject

@property (assign,nonatomic) NSInteger priority;
@property (strong,nonatomic) UIView *bgView;


- (void)bringUpWindow:(BaseWindow *)window;
- (void)releaseWindow:(BaseWindow *)window;
- (void)releaseWindow:(BaseWindow *)window withDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;

@end

NS_ASSUME_NONNULL_END
