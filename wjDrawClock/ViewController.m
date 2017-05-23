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
    
    // 定时器刷新方式一:
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f repeats:YES block:^(NSTimer * _Nonnull timer) {
//        [self catchTime];
        [self catchTimeDict];
    }];
    [self.timer fire];
    
    // 定时器刷新方式二: 有点辣眼睛
//    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(catchTime)];
//    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)dealloc {
    [self.timer invalidate];
}


// 获取时间
- (void)catchTime {
    NSString *timeStamp = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    // 方法一
    self.wjClockView.seconds = [WJTime wjTimeSecondsWithTimeStamp:timeStamp];
    self.wjClockView.minute = [WJTime wjTimeMinuteWithTimeStamp:timeStamp];
    self.wjClockView.hour = [WJTime wjTimeHourWithTimeStamp:timeStamp] - 12;
    self.wjTimeLable.text = [NSString stringWithFormat:@"%02d:%02d:%02d", self.wjClockView.hour + 12, self.wjClockView.minute, self.wjClockView.seconds];
}


- (void)catchTimeDict {
    NSString *timeStamp = [NSString stringWithFormat:@"%f", [[NSDate date] timeIntervalSince1970]];
    // 方法二
    NSDictionary *timeDict = [WJTime wjTimeGetTimeDictWithTimeStamp:timeStamp];
    NSNumber *seconds = timeDict[@"seconds"];
    NSNumber *minute = timeDict[@"minute"];
    NSNumber *hour = timeDict[@"hour"];
    self.wjClockView.seconds = seconds.intValue;
    self.wjClockView.minute = minute.intValue;
    self.wjClockView.hour = hour.intValue - 12;
    self.wjTimeLable.text = [NSString stringWithFormat:@"%02d:%02d:%02d", self.wjClockView.hour + 12, self.wjClockView.minute, self.wjClockView.seconds];
}


@end
