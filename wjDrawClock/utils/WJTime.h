//
//  WJTime.h
//  TheMoment
//
//  Created by wangjun on 16/7/12.
//  Copyright (c) 2016年 wangjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WJTime : NSObject

// 将时间转为时间戳
- (NSString *)getTimeStampWithTime:(NSDate *)date;
+ (NSString *)wjTimeGetTimeStampWithTime:(NSDate *)date;


// 将时间戳转为时间
- (NSString *)getTimeWithTimeStamp:(NSString *)timeStamp;
+ (NSString *)wjTimeGetTimeWithTimeStamp:(NSString *)timeStamp;


// 将时间戳转为秒
- (int)getSecondsWithTimeStamp:(NSString *)timeStamp;
+ (int)wjTimeSecondsWithTimeStamp:(NSString *)timeStamp;

// 将时间戳转为分
- (int)getMinuteWithTimeStamp:(NSString *)timeStamp;
+ (int)wjTimeMinuteWithTimeStamp:(NSString *)timeStamp;


// 将时间戳转为小时
- (int)getHourWithTimeStamp:(NSString *)timeStamp;
+ (int)wjTimeHourWithTimeStamp:(NSString *)timeStamp;

@end
