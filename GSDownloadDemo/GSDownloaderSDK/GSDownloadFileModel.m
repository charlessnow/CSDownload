//
//  GSDownloadFileModel.m
//  GSDownloaderSDKDemo
//
//  Created by Chaoqian Wu on 14-3-6.
//  Copyright (c) 2014年 4399 Network CO.ltd. All rights reserved.
//

#import "GSDownloadFileModel.h"

@implementation GSDownloadFileModel

- (id)init
{
    self = [super init];
    if (self) {
        _downloadFileName       = @"";
        _downloadFileAvatorURL  = @"";
        _downloadFinishTime     = @"";
        _downloadFileSize       = [NSNumber numberWithLongLong:0];
        _downloadFileVersion    = @"";
        _downloadTaskURL        = @"";
        _downloadFileSavePath   = @"";
        _downloadTempSavePath   = @"";
        _downloadFilePlistURL   = @"";
    }
    
    return self;
}
@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com