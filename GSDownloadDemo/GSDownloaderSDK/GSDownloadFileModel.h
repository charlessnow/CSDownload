//
//  GSDownloadFileModel.h
//  GSDownloaderSDKDemo
//
//  Created by Chaoqian Wu on 14-3-6.
//  Copyright (c) 2014年 4399 Network CO.ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSDownloadFileModel : NSObject

@property(nonatomic, strong, getter = getDownloadFileName) NSString* downloadFileName;

@property(nonatomic, strong, getter = getDownloadFileAvatorURL) NSString* downloadFileAvatorURL;

@property(nonatomic, strong, getter = getDownloadFinishTime) NSString* downloadFinishTime;

@property(nonatomic, strong, getter = getDownloadFileSize) NSNumber* downloadFileSize;

@property(nonatomic, strong, getter = getDownloadedFileSize) NSNumber* downloadedFileSize;

@property(nonatomic, strong, getter = getDownloadFileVersion) NSString* downloadFileVersion;

@property(nonatomic, strong, getter = getDownloadTaskURL) NSString* downloadTaskURL;

@property(nonatomic, strong, getter = getDownloadFileSavePath) NSString* downloadFileSavePath;

@property(nonatomic, strong, getter = getDownloadTempSavePath) NSString* downloadTempSavePath;

@property(nonatomic, strong, getter = getDownloadFilePlistURL) NSString* downloadFilePlistURL;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com