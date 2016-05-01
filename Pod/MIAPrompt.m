//
//

#import "MIAPrompt.h"

static MBProgressHUDManager* shareHUDInstance = nil;

@implementation MBProgressHUDManager

@synthesize HUD;
@synthesize baseView;

+ (MBProgressHUDManager*)shareHudManager:(UIView*)view {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareHUDInstance = [[MBProgressHUDManager alloc] init];
    });
    
    [shareHUDInstance setBaseView:view];
    return shareHUDInstance;
}


- (id)initWithView:(UIView *)view
{
    self = [super init];
    if (self)
    {
        self.baseView = view;
    }
    return self;
}

- (void)createHUD
{
    if (!self.HUD)
    {
        self.HUD = [[MBProgressHUD alloc] initWithView:self.baseView];
        self.HUD.mode = MBProgressHUDModeText;
        self.HUD.delegate = self;
        [self.baseView addSubview:self.HUD];
    }
}

//Show Text

- (void)showMessage:(NSString *)message
{
    [self showMessage:message duration:-1];
}

- (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    [self showMessage:message duration:duration complection:nil];
}

- (void)showMessage:(NSString *)message duration:(NSTimeInterval)duration complection:(void (^)())completion
{
    [self showMessage:message mode:MBProgressHUDModeText duration:duration complection:completion whileExecutingBlock:nil onQueue:nil showWhileExecuting:nil onTarget:nil withObject:nil];
}

//Show UIActivityIndicatorView

- (void)showIndeterminateWithMessage:(NSString *)message
{
    [self showIndeterminateWithMessage:message duration:-1];
}

- (void)showIndeterminateWithMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    [self showIndeterminateWithMessage:message duration:duration complection:nil];
}

- (void)showIndeterminateWithMessage:(NSString *)message duration:(NSTimeInterval)duration complection:(void (^)())completion
{
    [self showMessage:message mode:MBProgressHUDModeIndeterminate duration:duration complection:completion whileExecutingBlock:nil onQueue:nil showWhileExecuting:nil onTarget:nil withObject:nil];
}

//Show Success

- (void)showSuccessWithMessage:(NSString *)message
{
    [self showSuccessWithMessage:message duration:1];
}

- (void)showSuccessWithMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    [self showSuccessWithMessage:message duration:duration complection:nil];
}

- (void)showSuccessWithMessage:(NSString *)message duration:(NSTimeInterval)duration complection:(void (^)())completion
{
    UIImageView *customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark"]];
    [self showMessage:message customView:customView duration:duration complection:completion];
}

//Show Error

- (void)showErrorWithMessage:(NSString *)message
{
    [self showSuccessWithMessage:message duration:1];
}

- (void)showErrorWithMessage:(NSString *)message duration:(NSTimeInterval)duration
{
    [self showErrorWithMessage:message duration:duration complection:nil];
}

- (void)showErrorWithMessage:(NSString *)message duration:(NSTimeInterval)duration complection:(void (^)())completion
{
    UIImageView *customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Error.png"]];
    [self showMessage:message customView:customView duration:duration complection:completion];
}

//Show CustomView

- (void)showMessage:(NSString *)message customView:(UIView *)customView
{
    [self showMessage:message customView:customView duration:-1 complection:nil];
}

- (void)showMessage:(NSString *)message customView:(UIView *)customView duration:(NSTimeInterval)duration
{
    [self showMessage:message customView:customView duration:duration complection:nil];
}

- (void)showMessage:(NSString *)message customView:(UIView *)customView duration:(NSTimeInterval)duration complection:(MBProgressHUDCompletionBlock)completion
{
    [self createHUD];
    self.HUD.customView = customView;
    [self showMessage:message mode:MBProgressHUDModeCustomView duration:duration complection:completion whileExecutingBlock:nil onQueue:nil showWhileExecuting:nil onTarget:nil withObject:nil];
}

//Show mode

- (void)showMessage:(NSString *)message mode:(MBProgressHUDMode)mode
{
    [self showMessage:message mode:mode duration:-1 complection:nil whileExecutingBlock:nil onQueue:nil showWhileExecuting:nil onTarget:nil withObject:nil];
}

- (void)showMessage:(NSString *)message mode:(MBProgressHUDMode)mode duration:(NSTimeInterval)duration
{
    [self showMessage:message mode:mode duration:duration complection:nil whileExecutingBlock:nil onQueue:nil showWhileExecuting:nil onTarget:nil withObject:nil];
}

- (void)showMessage:(NSString *)message mode:(MBProgressHUDMode)mode duration:(NSTimeInterval)duration complection:(void (^)())completion whileExecutingBlock:(dispatch_block_t)block onQueue:(dispatch_queue_t)queue showWhileExecuting:(SEL)method onTarget:(id)target withObject:(id)object
{
    [self createHUD];
    self.HUD.mode = mode;
    self.HUD.labelText = message;
    
    if (duration >= 0) {
        [self.HUD show:YES];
        [self.HUD hide:YES afterDelay:duration];
    }
    else {
        if (target == nil && block != nil && completion != nil) {
            [self.HUD showAnimated:YES whileExecutingBlock:^{
                //
                block();
            } onQueue:queue completionBlock:^{
                //
                completion();
            }];
        }
        else if (method != nil && target != nil)
        {
            [self.HUD showWhileExecuting:method onTarget:target withObject:object animated:YES];
        }
        else {
            [self.HUD show:YES];
        }
    }
}

//Show Progress

- (void)showProgress:(float)progress
{
    if (self.HUD) self.HUD.progress = progress;
}

//hide

- (void)hide
{
    if (self.HUD) [self.HUD hide:YES];
}

#pragma mark -
#pragma mark MBProgressHUDDelegate methods

- (void)hudWasHidden:(MBProgressHUD *)hud
{
    self.HUD.delegate = nil;
	[self.HUD removeFromSuperview];
	self.HUD = nil;
    
    if (self.completionBlock) {
        self.completionBlock();
    }
}

@end