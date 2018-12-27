//
//  ZFAttrTextVC.m
//  DevOCFramwork
//
//  Created by 张志方 on 2018/8/29.
//  Copyright © 2018年 志方. All rights reserved.
//

#import "ZFAttrTextVC.h"
#import "UITextView+ZFAddition.h"

@interface ZFAttrTextVC ()<UITextViewDelegate>{
    UITextView *textView;
}

@end

@implementation ZFAttrTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createView];
    
}



-(void) createView {
    textView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
    NSString *htmlString = @"<p>普通正常普通正常普<a href=‘http://dev.lantouzi.com/user/bianxianjihua/order’ target=’_blank‘>链接链接链接</a>通正常普通正常普通正常普通正<a href=‘http://dev.lantouzi.com/user/bianxianjihua/order’ target=’_blank‘>链接链接链接</a>常普通正常普通正常普通正常普通正常<span style=‘whitespace:normal;’>普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常</span><span style=‘white-space:normal;’>普通正常普通正常普通正常<a href=‘http://dev.lantouzi.com/user/bianxianjihua/order’ target=’_blank‘>链接链接链接</a>普通正常普通正常普通正常普通正常普通正常</span><span style=‘white-space:normal;’>普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常</span><span style=‘white-space:normal;’>普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常</span><span style=’white-space:normal;‘>普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常</span></p><p><span style=’white-space:normal;‘><br /></span></p><p><span style=’white-space:normal;‘><span style=’white-space:normal;‘>普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常</span><span style=’white-space:normal;‘>普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常</span><span style=’white-space:normal;‘><a href=‘http://dev.lantouzi.com/user/bianxianjihua/order’ target=’_blank‘>链接链接链接</a>普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常普通正常</span><br /></span></p>";
    textView.linkTextAttributes = @{NSForegroundColorAttributeName:[UIColor redColor]};
    NSMutableAttributedString * attrStr = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(0, attrStr.length)];
    NSMutableParagraphStyle *contentStyle = [[NSMutableParagraphStyle alloc] init];
    contentStyle.lineSpacing = 8;
    [attrStr addAttribute:NSParagraphStyleAttributeName value:contentStyle range:NSMakeRange(0, attrStr.length)];
    textView.textContainer.lineFragmentPadding = 0.0;
    textView.textContainerInset = UIEdgeInsetsMake(1, 30, 0, 30);
    for (int i = 0; i < attrStr.length; i++) {
        NSRange _linkRange = NSMakeRange(0, 0);
        NSDictionary<NSString *, id> *a = [attrStr attributesAtIndex:i effectiveRange:&(_linkRange)];
        for (id aaa in [a allValues]) {
            if ([aaa isKindOfClass:[NSURL class]]) {
                [attrStr addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleNone) range:_linkRange];
            }
        }
    }
    
    
    textView.editable = NO;
    textView.selectedRange = NSMakeRange(0, 0);
    textView.attributedText = attrStr;
    textView.dataDetectorTypes = UIDataDetectorTypeLink;
    textView.delegate = self;
    
    
    [self.view addSubview:textView];
}

-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSLog(@"-====%@====%ld=",URL.path,characterRange.location);
    
    return NO;
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
