//
//  DKRate.m
//  Browser
//
//  Created by Дмитрий Калашников on 15/06/15.
//  Copyright (c) 2015 OOO Sputnik. All rights reserved.
//

#import "DKRate.h"
#import "CXAlertView.h"
#import "DKRateView.h"
#import "Chivy.h"
#import "StarRatingView.h"

@interface DKRate (){
    DKRateViewController *_rateCtrl;
}
@end

@implementation DKRate
+ (instancetype)sharedInstance
{
    static DKRate *sharedInstance = nil;
    if (sharedInstance == nil)
    {
        sharedInstance = [(DKRate *)[self alloc] init];
    }
    return sharedInstance;
}

- (id)init{
    self = [super init];
    if (self) {
        [iRate sharedInstance].eventsUntilPrompt = 3;
        [iRate sharedInstance].delegate = self;
        [iRate sharedInstance].daysUntilPrompt = 0;
        [iRate sharedInstance].usesUntilPrompt = 20;
        [iRate sharedInstance].promptForNewVersionIfUserRated = YES;
        self.alertTitle = @"Rate app";
        self.alertMessage = @"Please help our app and rate it";
        self.cancelBtnTitle = @"Not now";
        self.rateBtnTitle = @"Rate";
        DKRate *selfCaptured = self;
        [iRate sharedInstance].previewMode = YES;
        _enoughStars = 3.0f;
        [self setPromoteIfEnoughStars:^(CGFloat stars) {
            [[iRate sharedInstance] openRatingsPageInAppStore];
        }];
        [self setPromoteIfLessStars:^(CGFloat stars) {
            [DKRate openWebBrowser:@"https://github.com/wade0n/DKRate"];
        }];
        
        
    }
    return self;
}
-(void)setLaunchCount:(CGFloat)launchCount{
    [iRate sharedInstance].eventsUntilPrompt = launchCount;
}
- (void)increaseLaunchs{
    [[iRate sharedInstance] logEvent:NO];
    _launchCount = [iRate sharedInstance].eventsUntilPrompt;
}

- (void)launchApp{
    [self increaseLaunchs];
}
#pragma mark - iRate delegate
- (BOOL)iRateShouldPromptForRating{
    if (![[iRate sharedInstance] ratedThisVersion]) {
        [self showAlert];
        
    }
    return NO;
}
- (void)showAlert{
    _rateCtrl = [[DKRateViewController alloc] initWithNibName:@"MessageStarsBtn" bundle:nil];
       UIView *middleView = _rateCtrl.view;
       //[middleView performSelector:@selector(prepareRaiting) withObject:self];
    [_rateCtrl prepareRaiting];
    DKRate *selfCaptured = self;
    CXAlertView *alertView = [[CXAlertView alloc] initWithTitle:self.rateBtnTitle
                                                    contentView:middleView cancelButtonTitle:nil];
    [_rateCtrl setMessageTitle:_alertMessage andRateStr:_alertTitle];
    [_rateCtrl setPromote:^(CGFloat starsNum) {
        if (starsNum > _enoughStars) {
            if (selfCaptured.promoteIfEnoughStars) {
                selfCaptured.promoteIfEnoughStars(starsNum);
            }
            [[iRate sharedInstance] setRatedThisVersion:YES];
        }else if (starsNum <= _enoughStars){
            if (selfCaptured.promoteIfLessStars) {
                selfCaptured.promoteIfLessStars(starsNum);
            }
        }
        [alertView dismiss];
    }];

    alertView.showBlurBackground = NO;

    alertView.willShowHandler = ^(CXAlertView *alertView) {
        NSLog(@"%@, willShowHandler", alertView);
    };
    alertView.didShowHandler = ^(CXAlertView *alertView) {
        NSLog(@"%@, didShowHandler", alertView);
    };
    alertView.willDismissHandler = ^(CXAlertView *alertView) {
        NSLog(@"%@, willDismissHandler", alertView);
    };
    alertView.didDismissHandler = ^(CXAlertView *alertView) {
        NSLog(@"%@, didDismissHandler", alertView);
    };
    
    //[alertView showBlurBackground];
    
    [alertView showButtonLine];
    alertView.customButtonColor = [UIColor blackColor];
    alertView.cancelButtonColor =  [UIColor blackColor];
    alertView.buttonColor = [UIColor blackColor];
    [alertView setTitleFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:17.5f]];
    [alertView addButtonWithTitle:self.cancelBtnTitle type:CXAlertViewButtonTypeCustom handler:^(CXAlertView *alertView, CXAlertButtonItem *button) {
        [alertView dismiss];
        [selfCaptured cancelPromo];
    }];
    alertView.showBlurBackground = NO;
    //[middleView prepareRaiting];
    [alertView show];

}
- (void)cancelPromo{
    [iRate sharedInstance].eventCount = 0;
    [iRate sharedInstance].eventsUntilPrompt = 10;
    [iRate sharedInstance].usesCount = 0;
}
#pragma mark openUrl
+ (void)openWebBrowser:(NSString *)urlToWeb
{
    NSURL *urlToOpen = [CHWebBrowserViewController URLWithString:urlToWeb];
    CHWebBrowserViewController *webBrowserVC = [CHWebBrowserViewController webBrowserControllerWithDefaultNibAndHomeUrl:urlToOpen];
    webBrowserVC.cAttributes.titleScrollingSpeed = 10.0f;
    webBrowserVC.cAttributes.animationDurationPerOnePixel = 0.0008f; // faster animation on hiding bars
    webBrowserVC.cAttributes.titleTextAlignment = NSTextAlignmentLeft;
    webBrowserVC.cAttributes.isProgressBarEnabled = YES;
    webBrowserVC.cAttributes.isHidingBarsOnScrollingEnabled = NO;
    webBrowserVC.cAttributes.isReadabilityButtonHidden = YES;
    webBrowserVC.cAttributes.shouldAutorotate = NO;
    webBrowserVC.cAttributes.supportedInterfaceOrientations = UIInterfaceOrientationMaskLandscape;
    
    /*
     let's use google chrome URI scheme which provides callback url.
     we should specify only 'x-success' parameter using webBrowserViewController property
     the 'x-source' would be taken from 'CFBundleName' in InfoPlist.strings
     */
    NSURL *callbackURL = [NSURL URLWithString:@"returned-from-chrome"];
    webBrowserVC.chromeActivityCallbackUrl = callbackURL;
    
    [webBrowserVC setOnDismissCallback:^(CHWebBrowserViewController *webBrowser) {
        NSLog(@"dismiss callback trigerred");
    }];
    
    [CHWebBrowserViewController openWebBrowserController:webBrowserVC
                                          modallyWithUrl:[CHWebBrowserViewController URLWithString:urlToWeb]
                                                animated:YES
                                       showDismissButton:NO
                                              completion:^{
                                                  NSLog(@"Modal animation completed");
                                              }];
    
    
    float delayInSeconds = 5.0f;
    NSLog(@"Dismiss button will appear in %f seconds. Please wait.", delayInSeconds);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        webBrowserVC.shouldShowDismissButton = YES;
    });
}
+ (void)openWebBrowser:(NSString *)urlToWeb withTintColor:(UIColor *)tintColor withTitle:(NSString *)titleStr andTextColor:(UIColor *)textColor{
    NSURL *urlToOpen = [CHWebBrowserViewController URLWithString:urlToWeb];
    CHWebBrowserViewController *webBrowserVC = [CHWebBrowserViewController webBrowserControllerWithDefaultNibAndHomeUrl:urlToOpen];
    webBrowserVC.cAttributes.titleScrollingSpeed = 10.0f;
    webBrowserVC.cAttributes.animationDurationPerOnePixel = 0.0008f; // faster animation on hiding bars
    webBrowserVC.cAttributes.titleTextAlignment = NSTextAlignmentLeft;
    webBrowserVC.cAttributes.isProgressBarEnabled = YES;
    webBrowserVC.cAttributes.isHidingBarsOnScrollingEnabled = NO;
    webBrowserVC.cAttributes.isReadabilityButtonHidden = YES;
    webBrowserVC.cAttributes.shouldAutorotate = NO;
    webBrowserVC.cAttributes.supportedInterfaceOrientations = UIInterfaceOrientationMaskLandscape;
    
    /*
     let's use google chrome URI scheme which provides callback url.
     we should specify only 'x-success' parameter using webBrowserViewController property
     the 'x-source' would be taken from 'CFBundleName' in InfoPlist.strings
     */
    NSURL *callbackURL = [NSURL URLWithString:@"returned-from-chrome"];
    webBrowserVC.chromeActivityCallbackUrl = callbackURL;
    webBrowserVC.title = titleStr;
    webBrowserVC.cAttributes.toolbarTintColor = tintColor;
    webBrowserVC.cAttributes.titleTextColor = textColor;
    
    [webBrowserVC setOnDismissCallback:^(CHWebBrowserViewController *webBrowser) {
        NSLog(@"dismiss callback trigerred");
    }];
    
    [CHWebBrowserViewController openWebBrowserController:webBrowserVC
                                          modallyWithUrl:[CHWebBrowserViewController URLWithString:urlToWeb]
                                                animated:YES
                                       showDismissButton:NO
                                              completion:^{
                                                  NSLog(@"Modal animation completed");
                                              }];
    
    
    float delayInSeconds = 5.0f;
    NSLog(@"Dismiss button will appear in %f seconds. Please wait.", delayInSeconds);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        webBrowserVC.shouldShowDismissButton = YES;
    });

}
@end
