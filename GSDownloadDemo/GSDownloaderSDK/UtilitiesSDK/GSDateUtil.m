//
//  GSDateUtil.m
//  GSDownloadDemo
//
//  Created by wisnuc-imac on 2017/11/8.
//  Copyright © 2017年 wisnuc-imac. All rights reserved.
//

#import "GSDateUtil.h"

@implementation GSDateUtil

+ (NSString*)stringWithDate:(NSDate*)date withFormat:(NSString*)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:format];
    NSString *strDate = [dateFormatter stringFromDate:date];
    return strDate;
}

@end
