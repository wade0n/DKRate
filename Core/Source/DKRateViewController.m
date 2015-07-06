//
//  DKRateViewController.m
//  Browser
//
//  Created by Дмитрий Калашников on 23/06/15.
//  Copyright (c) 2015 OOO Sputnik. All rights reserved.
//

#import "DKRateViewController.h"
#import "DKStarRaitingView.h"

@interface DKRateViewController (){
    IBOutlet UIView *rateContainer;
    
    DKStarRaitingView *_ratingView;
  
}
@property (strong, nonatomic) IBOutlet UIButton *rateBtn;
@property (strong, nonatomic) IBOutlet UILabel *messageLbl;
- (IBAction)rateApp:(id)sender;
@end

@implementation DKRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (void)prepareRaiting{
    _ratingView = [[DKStarRaitingView alloc] initWithFrame:CGRectMake((rateContainer.frame.size.width-250)/2, 0, 250, rateContainer.frame.size.height) rateEnabled:YES];
    [_ratingView displayRating:4.0f];    // rate range:[0,5]
    _ratingView.starWidth = 50.0f;
    _ratingView.fullImage = @"Star_selected";
    _ratingView.emptyImage = @"Star";
    [_ratingView setRateEnabled:YES];
    _ratingView.backgroundColor = [UIColor clearColor];
    [rateContainer addSubview:_ratingView];
    [_ratingView displayRating:4.0f];
    //[rateBtn addTarget:self action:@selector(rateApp:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setMessageTitle:(NSString *)messageStr andRateStr:(NSString *)rateStr{
    if (messageStr) {
        [_messageLbl setText:messageStr];
    }
    if (rateStr) {
        [_rateBtn setTitle:rateStr forState:UIControlStateNormal];
    }
}
#pragma mark IBActions
- (IBAction)rateApp:(id)sender{
    
    if (self.promote) {
        self.promote([_ratingView getCurrentRating]);
    }
}
@end
