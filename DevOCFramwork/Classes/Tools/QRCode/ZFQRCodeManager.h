//
//  ZFQRCodeManager.h
//  DevOCFramwork
//
//  Created by 张志方 on 2018/9/5.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZFQRCodeManager : NSObject
/**
 设置过滤器
 
 @param source 生成二维码的源字符串
 @return CIImage
 */
+(CIImage *) createQRCodeImage:(NSString *)source;
/**
 调整二维码
 
 @param image 二维码图片
 @param size 图片的宽高
 @return image
 */
+(UIImage *) resizeQRCodeImage:(CIImage *)image withSize:(CGFloat)size;
/**
 设置特别颜色的二维码图片
 
 @param image 二维码图片
 @param red 红
 @param greem 绿
 @param blue 蓝
 @return image
 */
+(UIImage *) specialColorImage:(UIImage *)image withRed:(CGFloat)red green:(CGFloat)greem blue:(CGFloat)blue;
/**
 添加图标到二维码中
 
 @param image 二维码图片
 @param icon 图标图片
 @param iconSize 图标大小
 @return image
 */
+(UIImage *) addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withIconSize:(CGSize)iconSize;
/**
 添加图标到二维码中
 
 @param image 二维码图片
 @param icon 图标图片
 @param scale 比例
 @return image
 */
+(UIImage *) addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withScale:(CGFloat)scale;

@end
