//
//  DKRateViewController.h
//  Browser
//
//  Created by Дмитрий Калашников on 23/06/15.
//  Copyright (c) 2015 OOO Sputnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DKRateView.h"

@interface DKRateViewController : UIViewController
@property(nonatomic, copy) void (^promote)(CGFloat);   
- (void)prepareRaiting;
- (void)setMessageTitle:(NSString *)messageStr andRateStr:(NSString *)rateStr;

@end
