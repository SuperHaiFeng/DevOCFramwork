//
//  PopUpManager.h
//  PopUpManager
//
//  Created by LC on 2019/1/17.
//  Copyright © 2019 CommonStructure. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseContainer.h"
#import "BaseWindow.h"

@interface WindowManager : NSObject

+ (instancetype)sharedManager;

- (void)bringUpWindow:(BaseWindow *)window;
- (void)releaseWindow:(BaseWindow *)window;
- (void)releaseWindow:(BaseWindow *)window withDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
- (void)releaseContainer:(BaseContainer *)container;

@end
