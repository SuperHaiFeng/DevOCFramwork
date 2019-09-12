//
//  ZMImageTool.m
//  charming-ios
//
//  Created by 张志方 on 2018/9/12.
//  Copyright © 2018年 apeKiller. All rights reserved.
//

#import "ZMImageTool.h"

@implementation ZMImageTool

+(UIImage *) mergeImageWithBackImage:(UIImage *)backImage backRect:(CGRect)backRect withQRCode:(UIImage *)QRCode codeRect:(CGRect)codeRect {
    UIGraphicsBeginImageContext(backImage.size);
    [backImage drawInRect:backRect];
    [QRCode drawInRect:codeRect];
    CGImageRef mergeRef = CGImageCreateWithImageInRect(UIGraphicsGetImageFromCurrentImageContext().CGImage, CGRectMake(0, 0, backImage.size.width, backImage.size.height));
    UIGraphicsEndImageContext();
    UIImage *image = [UIImage imageWithCGImage:mergeRef];
    CGImageRelease(mergeRef);
    return image;
}

+(UIImage *) zipScaleWithImage:(UIImage *) sourceImage{
    //进行图像尺寸的压缩
    CGSize imageSize = sourceImage.size;//取出要压缩的image尺寸
    CGFloat width = imageSize.width;    //图片宽度
    CGFloat height = imageSize.height;  //图片高度
    //1.宽高大于1920(宽高比不按照2来算，按照1来算)
    if (width>1920||height>1920) {
        if (width>height) {
            CGFloat scale = height/width;
            width = 1920;
            height = width*scale;
        }else{
            CGFloat scale = width/height;
            height = 1920;
            width = height*scale;
        }
    }
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [sourceImage drawInRect:CGRectMake(0,0,width,height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //进行图像的画面质量压缩
    NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
    if (data.length>100*1024) {
        if (data.length>1024*1024) {//1M以及以上
            data = UIImageJPEGRepresentation(newImage, 0.6);
        }else if (data.length>512*1024) {//0.5M-1M
            data = UIImageJPEGRepresentation(newImage, 0.8);
        }else if (data.length>200*1024) {
            //0.25M-0.5M
            data = UIImageJPEGRepresentation(newImage, 0.9);
        }
    }
    return [UIImage imageWithData:data];
}

@end
