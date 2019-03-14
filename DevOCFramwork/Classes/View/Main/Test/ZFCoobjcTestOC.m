//
//  ZFCoobjcTestOC.m
//  DevOCFramwork
//
//  Created by 张志方 on 2019/2/28.
//  Copyright © 2019年 志方. All rights reserved.
//

#import "ZFCoobjcTestOC.h"
#import "coobjc.h"

@interface ZFCoobjcTestOC ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation ZFCoobjcTestOC

- (void)viewDidLoad {
    [super viewDidLoad];
    //创建协程
    co_launch(^{
        //使用await等待异步方法执行完成
        NSData *data = await(downloadDataFromUrl(@""));
        UIImage *image = await(imageFromData(data));
        self.imageView.image = image;
    });

    
}


NS_INLINE UIImage* imageFromData(NSData *data){
    
    return nil;
}

NSData* downloadDataFromUrl(NSString *url){
    
    return nil;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
