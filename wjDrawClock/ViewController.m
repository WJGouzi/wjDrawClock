//
//  ViewController.m
//  wjDrawClock
//
//  Created by gouzi on 2017/5/22.
//  Copyright © 2017年 wj. All rights reserved.
//

#import "ViewController.h"
#import "wjClockView.h"
#import "WJTime.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet wjClockView *wjClockView;

@property (weak, nonatomic) IBOutlet UILabel *wjTimeLable;

/** timer*/
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self catchTime];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
        [self catchTime];
    }];
    [self.timer fire];
}

- (void)dealloc {
    [self.timer invalidate];
}

// 获取时间
- (void)catchTime {
    NSString *timeStamp = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    self.wjClockView.seconds = [WJTime wjTimeSecondsWithTimeStamp:timeStamp];
    self.wjClockView.minute = [WJTime wjTimeMinuteWithTimeStamp:timeStamp];
    self.wjClockView.hour = [WJTime wjTimeHourWithTimeStamp:timeStamp] - 12;
    self.wjTimeLable.text = [NSString stringWithFormat:@"%02d:%02d:%02d", self.wjClockView.hour + 12, self.wjClockView.minute, self.wjClockView.seconds];
    
}




@end
