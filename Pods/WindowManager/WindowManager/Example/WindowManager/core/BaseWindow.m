//
//  BasePopUpWindow.m
//  PopUpManager
//
//  Created by LC on 2019/1/17.
//  Copyright © 2019 CommonStructure. All rights reserved.
//

#import "BaseWindow.h"

@interface BaseWindow ()

@end

@implementation BaseWindow

- (instancetype)init {
    self = [super init];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self setupWindow];
    return self;
}

- (void)setupWindow {
    
}

- (void)didDisplayedOnFront:(BOOL)firstTime {
    
}

- (void)didSendedToBack {
    
}


@end

