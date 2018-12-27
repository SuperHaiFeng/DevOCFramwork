//
//  UIImage+Extention.h
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extention)

-(UIImage *) zf_avatarImage: (CGSize) size backColor: (UIColor *) backColor lineColor: (UIColor *) lineColor;

+(UIImage *) createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius;

+(UIImage *) mergeImageWithBackImage:(UIImage *)backImage backRect:(CGRect)backRect withQRCode:(UIImage *)QRCode codeRect:(CGRect)codeRect;

@end
