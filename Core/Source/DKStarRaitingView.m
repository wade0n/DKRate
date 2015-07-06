//
//  DKStarRaitingView.m
//  RateExample
//
//  Created by Дмитрий Калашников on 06/07/15.
//  Copyright (c) 2015 Дмитрий Калашников. All rights reserved.
//

#import "DKStarRaitingView.h"
@interface DKStarRaitingView(){
    CGFloat _curRaiting;
}
@end

@implementation DKStarRaitingView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (CGFloat)getCurrentRating{
    return _curRaiting;
}

- (void)displayRating:(float)rating
{
    _curRaiting = rating;
    [super displayRating:rating];
}

@end
