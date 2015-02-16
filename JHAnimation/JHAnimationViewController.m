//
//  JHAnimationViewController.m
//  JHAnimation
//
//  Created by Johnny Heusser  on 2/16/15.
//  Copyright (c) 2015 SoundsFromTheCouch. All rights reserved.
//

#import "JHAnimationViewController.h"

@interface JHAnimationViewController ()

@property (nonatomic, strong) UIButton *reloadButton;
@property (nonatomic, strong) UIImage *logo;
@property (nonatomic) NSInteger numberOfSlats;

@property (nonatomic) float screenWidth;
@property (nonatomic) float screenHeight;
@property (nonatomic) float logoWidth;
@property (nonatomic) float logoHeight;
@property (nonatomic) float logoScaler;
@property (nonatomic) float widthOfSlat;

@property (nonatomic, strong) UIImageView *logoView;

@end

@implementation JHAnimationViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUpAnimation];
}

- (void)setUpAnimation {

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    
    self.screenWidth = screenRect.size.width;
    self.screenHeight = screenRect.size.height;
    self.logoScaler = 2.00;
    self.logoWidth = self.screenWidth / self.logoScaler;
    self.logoHeight = self.screenHeight / self.logoScaler;
    self.numberOfSlats = 250;
    self.widthOfSlat = self.screenWidth / (float)self.numberOfSlats;
    
    self.logo = [UIImage imageNamed:@"nike.png"];
    
    for (int i = 0; i < self.numberOfSlats; i++) {
        int heightAboveFinalPosition = -1 * (arc4random() % 1000) - 500;
        
        CGRect slatRect = CGRectMake(i*self.widthOfSlat, heightAboveFinalPosition, self.widthOfSlat, self.screenHeight);
        UIView *newView = [[UIView alloc] initWithFrame:slatRect];
        
        newView.tag = i;
        newView.clipsToBounds = YES;
        
        self.logoView = [[UIImageView alloc] initWithImage:self.logo];
        self.logoView.contentMode = UIViewContentModeScaleAspectFit;
        
        CGRect imgViewRect = CGRectMake(self.screenWidth/2.0f - self.logoWidth/2.0f - i*self.widthOfSlat,
                                        (self.screenHeight/2.0f - self.logoHeight/2.0f),
                                        self.logoWidth,
                                        self.logoHeight);
        self.logoView.frame = imgViewRect;
        [newView addSubview:self.logoView];
        
        [self.view addSubview:newView];
    }
    __weak typeof(self) weakSelf = self;
    
    [UIView animateKeyframesWithDuration:2.0 delay:1.0 options:UIViewKeyframeAnimationOptionCalculationModeCubic | UIViewKeyframeAnimationOptionRepeat animations:^{
    
        for (int i = 0; i < weakSelf.numberOfSlats; i++) {
            UIView *slat = [weakSelf.view viewWithTag:i];
            slat.frame = CGRectMake(i*weakSelf.widthOfSlat, 0, weakSelf.widthOfSlat, weakSelf.screenHeight);
        }
    }completion:nil];
}


@end
