//
//  UIImage+Extention.m
//  DevOCFramwork
//
//  Created by 志方 on 2018/2/28.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "UIImage+Extention.h"

@implementation UIImage (Extention)

static void addRoundedRectToPath(CGContextRef contextRef,CGRect rect, float widthOfRadius, float heightOfRadius){
    float fw, fh;
    if (widthOfRadius == 0 || heightOfRadius == 0) {
        CGContextAddRect(contextRef, rect);
        return;
    }
    
    CGContextSaveGState(contextRef);
    CGContextTranslateCTM(contextRef, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(contextRef, widthOfRadius, heightOfRadius);
    fw = CGRectGetWidth(rect) / widthOfRadius;
    fh = CGRectGetHeight(rect) / heightOfRadius;
    
    CGContextMoveToPoint(contextRef, fw, fh/2);
    CGContextAddArcToPoint(contextRef, fw, fh, fw/2, fh, 1);
    CGContextAddArcToPoint(contextRef, 0, fh, 0, fh/2, 1);
    CGContextAddArcToPoint(contextRef, 0, 0, fw/1, 0, 1);
    CGContextAddArcToPoint(contextRef, fw, 0, fw, fh/2, 1);
    
    CGContextClosePath(contextRef);
    CGContextRestoreGState(contextRef);
}

-(UIImage *) zf_avatarImage: (CGSize) size backColor: (UIColor *) backColor lineColor: (UIColor *) lineColor{
    CGSize size1 = size;
    
    CGRect rect = CGRectMake(0, 0, size1.width, size1.height);
    
    UIGraphicsBeginImageContextWithOptions(size1, YES, 0);
    
    [backColor setFill];
    UIRectFill(rect);
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
    [path addClip];
    
    [self drawInRect:rect];
    
    UIBezierPath *ovalpath = [UIBezierPath bezierPathWithOvalInRect:rect];
    ovalpath.lineWidth = 2;
    [lineColor setStroke];
    [ovalpath stroke];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
    
}

+(UIImage *) createRoundedRectImage:(UIImage *)image withSize:(CGSize)size withRadius:(NSInteger)radius{
    int w = size.width;
    int h = size.height;
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(NULL, w, h, 8, 4 * w, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    CGRect rect = CGRectMake(0, 0, w, h);
    
    CGContextBeginPath(contextRef);
    addRoundedRectToPath(contextRef, rect, radius, radius);
    CGContextClosePath(contextRef);
    CGContextClip(contextRef);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, w, h), image.CGImage);
    CGImageRef imageMaskRef = CGBitmapContextCreateImage(contextRef);
    
    UIImage *img = [UIImage imageWithCGImage:imageMaskRef];
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpaceRef);
    CGImageRelease(imageMaskRef);
    return img;
}

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


@end
