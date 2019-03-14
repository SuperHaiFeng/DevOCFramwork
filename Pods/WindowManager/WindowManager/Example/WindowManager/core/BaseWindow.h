//
//  BasePopUpWindow.h
//  PopUpManager
//
//  Created by LC on 2019/1/17.
//  Copyright © 2019 CommonStructure. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BaseWindow : UIView

//控制window的优先级以及container的优先级
//个十百位为window优先级，其他为container优先级
//1010,container优先级为1,window优先级为10
@property (assign,nonatomic) NSInteger priority;

- (instancetype)init;
- (void)setupWindow;
- (void)didDisplayedOnFront:(BOOL)firstTime;
- (void)didSendedToBack;

@end

NS_ASSUME_NONNULL_END
