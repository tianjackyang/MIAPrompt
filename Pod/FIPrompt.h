//
//  FIPrompt.h
//  e-friends
//
//  Created by janven on 16/3/3.
//  Copyright © 2016年 上海帜讯信息技术股份有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"

@interface FIPrompt : NSObject
+ (FIPrompt *)sharePromptInstance;

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
              size:(CGSize)size;
@end
