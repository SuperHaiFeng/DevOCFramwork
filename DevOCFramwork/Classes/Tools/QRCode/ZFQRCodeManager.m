//
//  ZFQRCodeManager.m
//  DevOCFramwork
//
//  Created by 张志方 on 2018/9/5.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFQRCodeManager.h"

@implementation ZFQRCodeManager

//私有方法，释放data
void providerReleaseData (void *info, const void *data, size_t size) {
    free((void *)data);
}


/**
 设置过滤器

 @param source 生成二维码的源字符串
 @return CIImage
 */
+(CIImage *) createQRCodeImage:(NSString *)source{
    NSData *data = [source dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];//CIQRCodeGenerator是固定的
    [filter setValue:data forKey:@"inputMessage"];
    [filter setValue:@"M" forKey:@"inputCorrectionLevel"];//设置纠错登记越高，即识别越容易，值可设置为L(Low)|M(Medium)|Q|H(High）
    CGFloat versin = ((filter.outputImage.extent.size.width - 21)/4.0 + 1);
    NSLog(@"=====%f",versin);
    CGFloat leftMargin = CGRectIntegral(filter.outputImage.extent).size.width * 3 / ((versin - 1) * 4 + 21);
    NSLog(@"----_%f",leftMargin);
    return filter.outputImage;
}


/**
 调整二维码

 @param image 二维码图片
 @param size 图片的宽高
 @return image
 */
+(UIImage *) resizeQRCodeImage:(CIImage *)image withSize:(CGFloat)size{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceGray();
    
    CGContextRef contextRef = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpaceRef, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(contextRef, kCGInterpolationNone);
    CGContextScaleCTM(contextRef, scale, scale);
    CGContextDrawImage(contextRef, extent, imageRef);
    
    CGImageRef imageRedResized = CGBitmapContextCreateImage(contextRef);
    
    CGContextRelease(contextRef);
    CGImageRelease(imageRef);
    return [UIImage imageWithCGImage:imageRedResized];
}

/**
 设置特别颜色的二维码图片

 @param image 二维码图片
 @param red 红
 @param greem 绿
 @param blue 蓝
 @return image
 */
+(UIImage *) specialColorImage:(UIImage *)image withRed:(CGFloat)red green:(CGFloat)greem blue:(CGFloat)blue{
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t *rgbImageBuf = (uint32_t *)malloc(bytesPerRow*imageHeight);
    
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef contextRef = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpaceRef, kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(contextRef, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    int pixelNUm = imageWidth * imageHeight;
    uint32_t *pCurPtr = rgbImageBuf;
    for (int i = 0 ; i < pixelNUm; i++, pCurPtr++) {
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900) {
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[3] = red;
            ptr[2] = greem;
            ptr[1] = blue;
        }else {
            uint8_t *ptr = (uint8_t *)pCurPtr;
            ptr[0] = 0;
        }
    }
    
    CGDataProviderRef dataProviderRef = CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow*imageHeight, providerReleaseData);
    
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight, 8, 32, bytesPerRow, colorSpaceRef, kCGImageAlphaLast|kCGBitmapByteOrder32Little, dataProviderRef, NULL, true, kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProviderRef);
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    
    //release
    CGImageRelease(imageRef);
    CGContextRelease(contextRef);
    CGColorSpaceRelease(colorSpaceRef);
    
    return img;
}

/**
 添加图标到二维码中

 @param image 二维码图片
 @param icon 图标图片
 @param iconSize 图标大小
 @return image
 */
+(UIImage *) addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withIconSize:(CGSize)iconSize{
    UIGraphicsBeginImageContext(image.size);
    //通过两张图片进行位置和大小的绘制，实现两张图片的合并，此原理方法可用于多张图片的合并
    CGFloat widthOfImage = image.size.width;
    CGFloat heightOfImage = image.size.height;
    CGFloat widthOfIcon = icon.size.width;
    CGFloat heightOfIcon = icon.size.height;
    [image drawInRect:CGRectMake(0, 0, widthOfImage, heightOfImage)];
    [icon drawInRect:CGRectMake((widthOfImage-widthOfIcon)/2, (heightOfImage-heightOfIcon)/2, widthOfIcon, heightOfIcon)];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}


/**
 添加图标到二维码中

 @param image 二维码图片
 @param icon 图标图片
 @param scale scale
 @return image
 */
+(UIImage *) addIconToQRCodeImage:(UIImage *)image withIcon:(UIImage *)icon withScale:(CGFloat)scale{
    UIGraphicsBeginImageContext(image.size);
    
    CGFloat widthOfImage = image.size.width;
    CGFloat heightOfImage = image.size.height;
    CGFloat widthOfIcon = widthOfImage/scale;
    CGFloat heightOfIcon = heightOfImage/scale;
    
    [image drawInRect:CGRectMake(0, 0, widthOfImage, heightOfImage)];
    [icon drawInRect:CGRectMake((widthOfImage-widthOfIcon)/2, (heightOfImage-heightOfIcon)/2, widthOfIcon, heightOfIcon)];
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


@end
