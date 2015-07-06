//
//  DKRate.h
//  Browser
//
//  Created by Дмитрий Калашников on 15/06/15.
//  Copyright (c) 2015 OOO Sputnik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "iRate.h"
#import "DKRateViewController.h"

@interface DKRate : NSObject <iRateDelegate>{

}
@property(nonatomic) CGFloat launchCount;
@property(nonatomic) CGFloat usesCount;
@property(nonatomic) CGFloat enoughStars;
@property(nonatomic, strong) NSString *alertTitle;
@property(nonatomic, strong) NSString *alertMessage;
@property(nonatomic, strong) NSString *rateBtnTitle;
@property(nonatomic, strong) NSString *cancelBtnTitle;
+ (instancetype)sharedInstance;
- (void)launchApp;
@property(nonatomic, copy) void (^promoteIfEnoughStars)(CGFloat);
@property(nonatomic, copy) void (^promoteIfLessStars)(CGFloat);
@end
