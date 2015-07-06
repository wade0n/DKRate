
//
//  DKRateView.m
//  Browser
//
//  Created by Дмитрий Калашников on 23/06/15.
//  Copyright (c) 2015 OOO Sputnik. All rights reserved.
//

#import "DKRateView.h"

@implementation DKRateView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)prepareRaiting{
    StarRatingView *ratingView = [[StarRatingView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    [ratingView displayRating:4.0f];    // rate range:[0,5]
    
    ratingView.rateEnabled = YES;
    ratingView.starWidth = 38.0f;
    
    // set star image
    ratingView.fullImage = @"Star_selected";
    //ratingView.halfImage = @"ic_starwhitehalf.png";
    ratingView.emptyImage = @"Star";
    [rateContainer addSubview:ratingView];
}
@end
