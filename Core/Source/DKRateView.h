//
//  DKRateView.h
//  Browser
//
//  Created by Дмитрий Калашников on 23/06/15.
//  Copyright (c) 2015 OOO Sputnik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StarRatingView.h"

@interface DKRateView : UIView{
    IBOutlet UIView *rateContainer;
}
@property(nonatomic, strong) StarRatingView *raitingView;

-(void)prepareRaiting;
@end
