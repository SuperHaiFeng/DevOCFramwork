//
//  ZMImageTool.h
//  charming-ios
//
//  Created by 张志方 on 2018/9/12.
//  Copyright © 2018年 apeKiller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZMImageTool : NSObject

/**
 图片合成

 @param backImage 背景图片
 @param backRect 背景图rect
 @param QRCode 二维码图片
 @param codeRect 二维码图片位置
 @return 返回合成后的图片
 */
+(UIImage *) mergeImageWithBackImage:(UIImage *)backImage backRect:(CGRect)backRect withQRCode:(UIImage *)QRCode codeRect:(CGRect)codeRect;

/**
 压缩图片

 @param sourceImage 压缩原图
 @return 返回压缩完成后的图
 */
+(UIImage *) zipScaleWithImage:(UIImage *) sourceImage;

@end
