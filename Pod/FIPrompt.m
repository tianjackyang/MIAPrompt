//
//  FIPrompt.m
//  e-friends
//
//  Created by janven on 16/3/3.
//  Copyright © 2016年 上海帜讯信息技术股份有限公司. All rights reserved.
//

#import "FIPrompt.h"


static FIPrompt *sharePrompt = nil;

@interface FIPrompt ()
@property (nonatomic, assign) BOOL canceled;
@end

@implementation FIPrompt

+ (FIPrompt *)sharePromptInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharePrompt = [[self alloc] init];
    });
    return sharePrompt;
}

- (void)showPrompt:(UIView*)view
             title:(NSString*)title
       detailtitle:(NSString*)detailtitle
              mode:(MBProgressHUDMode)mode
      anmationtype:(MBProgressHUDAnimation)anmationtype
          anmation:(BOOL)animation
           opacity:(float)opacity
             color:(UIColor*)color
            square:(BOOL)square
     dimbackground:(BOOL)dimbackground
            remove:(BOOL)remove
        customview:(UIView*)customview
          progress:(float)progress
              size:(CGSize)size
{
    MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:view animated:animation];
    hub.mode = mode;
    hub.labelText = title;
    hub.detailsLabelText = detailtitle;
    hub.animationType = anmationtype;
}

@end
