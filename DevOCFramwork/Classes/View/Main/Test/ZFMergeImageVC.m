//
//  ZFMergeImageVC.m
//  DevOCFramwork
//
//  Created by 张志方 on 2018/9/4.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFMergeImageVC.h"
#import "ZFQRCodeManager.h"
#import "UIImage+Extention.h"

@interface ZFMergeImageVC ()

@property (nonatomic, strong) UIImageView *backImageView;

@end

@implementation ZFMergeImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    [self.view addSubview:self.backImageView];
    self.backImageView.contentMode = UIViewContentModeScaleToFill;
    self.backImageView.backgroundColor = [UIColor grayColor];
    self.backImageView.image = [self mergeImage];
    
    NSMutableArray *arr = [NSMutableArray array];
    dispatch_semaphore_t semaphore0 = dispatch_semaphore_create(0);//创建信号量,它的值为0
    dispatch_semaphore_t semaphore1 = dispatch_semaphore_create(0);//让3个线程顺序执行,所以为0
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("queue",DISPATCH_QUEUE_CONCURRENT);
    //thread3
    //希望它是最后执行的,让它依赖thread2
    if (YES) {
        dispatch_group_enter(group);
        dispatch_group_async(group, queue, ^{
            //DISPATCH_TIME_FOREVER表示一直等着,直到semaphore为0执行.如果写15的话,就代表我只等15纳秒,15纳秒后,不管信号量是否为0,我都执行下面的代码.
            dispatch_semaphore_wait(semaphore1, DISPATCH_TIME_FOREVER);//阻塞当前线程一直到semaphore1为0
            dispatch_semaphore_wait(semaphore0, DISPATCH_TIME_FOREVER);
            NSLog(@"最弱的,最后执行的--- > %@",arr);
            sleep(1);
            dispatch_group_leave(group);
        });
        //thread2
        //等待thread1执行完毕后,执行thread2.(thread2依赖thread1)
        //    dispatch_group_enter(group);
        //    dispatch_group_async(group, queue, ^{
        //        //wait信号量-1(少一个可用资源)
        ////        dispatch_wait(semaphore0, DISPATCH_TIME_FOREVER);
        //
        //        NSLog(@"依赖别人的资源 --> %@",arr);
        //        sleep(1);
        //        dispatch_semaphore_signal(semaphore1);
        //        dispatch_group_leave(group);
        //    });
        [self overDispatch:group queue:queue semaphoer:semaphore1 success:^(NSString *strin) {
            NSLog(@"返回的数据==%@",strin);
        }];
        //thread1
        //这里有arr的赋值操作,需要最先执行,否则其他地方打印都为空
        dispatch_group_enter(group);
        dispatch_group_async(group, queue, ^{
            for(int i = 0; i < 3; i ++)
            {
                [arr addObject:[NSNumber numberWithInt:i]];
            }
            //signal相当于信号量+1(多一个可用资源)
            
            NSLog(@"被依赖的资源 ---> %@",arr);
            sleep(3);
            dispatch_semaphore_signal(semaphore0);
            dispatch_group_leave(group);
        });
    }
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"所有线程执行完毕");
    });
}

-(void) overDispatch:(dispatch_group_t)group queue:(dispatch_queue_t)queue semaphoer:(dispatch_semaphore_t)semaphoer success:(void(^)(NSString * strin))success{
    __block NSString *str;
    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        //wait信号量-1(少一个可用资源)
        //        dispatch_wait(semaphore0, DISPATCH_TIME_FOREVER);
        
        NSLog(@"依赖别人的资源 --> ");
        sleep(1);
        str = @"风飒风";
        success(str);
        dispatch_semaphore_signal(semaphoer);
        dispatch_group_leave(group);
    });
}

-(UIImage *) mergeImage {
    UIImage *backImage = [UIImage imageNamed:@"backImage"];
    
    NSString *source = @"https://github.com/KenmuHuang";
    CIImage *imgQR = [ZFQRCodeManager createQRCodeImage:source];
    UIImage *imgAdaptiveQRCode = [ZFQRCodeManager resizeQRCodeImage:imgQR withSize:self.backImageView.frame.size.width];
//    UIImage *imageIcon = [UIImage createRoundedRectImage:[UIImage imageNamed:@"R"] withSize:CGSizeMake(40, 40) withRadius:10];
//    imgAdaptiveQRCode = [ZFQRCodeManager addIconToQRCodeImage:imgAdaptiveQRCode withIcon:imageIcon withIconSize:imageIcon.size];
    
    UIImage *image = [UIImage mergeImageWithBackImage:backImage backRect:CGRectMake(0, 0, backImage.size.width, backImage.size.height) withQRCode:imgAdaptiveQRCode codeRect:CGRectMake(backImage.size.width/2-imgAdaptiveQRCode.size.width/2, backImage.size.height/2-imgAdaptiveQRCode.size.height/2, imgAdaptiveQRCode.size.width, imgAdaptiveQRCode.size.height)];
    return imgAdaptiveQRCode;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
