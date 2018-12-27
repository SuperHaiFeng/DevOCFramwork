//
//  UITextView+ZFAddition.m
//  DevOCFramwork
//
//  Created by 张志方 on 2018/8/29.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "UITextView+ZFAddition.h"

@implementation UITextView (ZFAddition)

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
//    if (action == @selector(paste:) || action == @selector(select:))//禁止粘贴
//        return NO;
//    if (action == @selector(select:))// 禁止选择
//        return NO;
//    if (action == @selector(selectAll:))// 禁止全选
//        return NO;
//    if (action == @selector(makeTextWritingDirectionRightToLeft:) ||
//        action == @selector(makeTextWritingDirectionLeftToRight:) ||
//        action == @selector(cut:) || action == @selector(copy:) || action == @selector(paste:) || action == @selector(select:) || action == @selector(selectAll:) || action == @selector(delete:)) {
//        return NO;
//    }
//    if (action == @selector(makeTextWritingDirectionLeftToRight:)) {
//        return NO;
//    }
//    return [super canPerformAction:action withSender:sender];
    [self resignFirstResponder];
    UIMenuController *menuController = [UIMenuController sharedMenuController];
    if (menuController)
    {
        [UIMenuController sharedMenuController].menuVisible = NO;
    }
    return NO;
}

-(BOOL)canPasteItemProviders:(NSArray<NSItemProvider *> *)itemProviders {
    return NO;
}
@end
