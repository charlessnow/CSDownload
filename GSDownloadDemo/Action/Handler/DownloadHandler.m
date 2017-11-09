//
//  DownloadHandler.m
//  GSDownloadDemo
//
//  Created by wisnuc-imac on 2017/11/9.
//  Copyright © 2017年 wisnuc-imac. All rights reserved.
//

#import "DownloadHandler.h"
@interface DownloadHandler()<GSDownloadUIBindProtocol>
{
    GSDownloaderClient* _client;
    int _downdloadCount;
}
@end


@implementation DownloadHandler
+ (DownloadHandler*)shareManager
{
    static dispatch_once_t p = 0;
    __strong static id _sharedObject = nil;

    dispatch_once(&p, ^{
        _sharedObject = [[DownloadHandler alloc] init];
    });
    
    return _sharedObject;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _client = [GSDownloaderClient sharedDownloaderClient];
        _client.maxDownload = 6;
        _client.maxWaiting = 6;
        _client.maxPaused = 6;
        _client.maxFailureRetryChance = 6;
        
        _downdloadCount = 0;
    }
    return self;
}

- (void)downloadFileWithFileModel:(DataModel *)dataModel{
    _downdloadCount++;
    
    NSString* fromUrl = dataModel.URLstring;
    
    NSString* suffixName = [fromUrl lastPathComponent];
    NSString* tmpFileName = [NSString stringWithFormat:@"file-%d.tmp",_downdloadCount];
    NSString* saveFileName= [NSString stringWithFormat:@"%@",suffixName];
    
    NSString* savePath = [GSFileUtil getPathInDocumentsDirBy:@"Downloads/" createIfNotExist:YES];
    NSString* saveFile = [savePath stringByAppendingPathComponent:saveFileName];
    NSFileManager *manager = [NSFileManager defaultManager];
    
    if ([manager fileExistsAtPath:saveFile]) {
       [SVProgressHUD showInfoWithStatus:@"该文件已下载"];
        return;
    }

    NSLog(@"成功下载路径为:%@",savePath);
    NSLog(@"成功文件为:%@",saveFile);
    
    NSString* tempPath = [GSFileUtil getPathInDocumentsDirBy:@"Downloads/Tmp" createIfNotExist:YES];
    NSString* tempFile = [tempPath stringByAppendingPathComponent:tmpFileName];
    
    NSLog(@"临时下载路径为:%@",tempPath);
    NSLog(@"临时文件为:%@",tempFile);
    
//     NSString* fileName = [suffixName stringByDeletingPathExtension];
    
    GSDownloadFileModel* downloadFileModel = [[GSDownloadFileModel alloc] init];
    [downloadFileModel setDownloadFileName:[NSString stringWithFormat:@"%@",suffixName]];
    [downloadFileModel setDownloadFileAvatorURL:@""];
    [downloadFileModel setDownloadTaskURL:fromUrl];
    [downloadFileModel setDownloadFileSavePath:saveFile];
    [downloadFileModel setDownloadTempSavePath:tempFile];
    [downloadFileModel setDownloadFileVersion:@""];
    [downloadFileModel setDownloadFilePlistURL:@""];
    
    GSDownloadTask* downloadTask = [[GSDownloadTask alloc] init];
    [downloadTask setDownloadTaskId:[NSString stringWithFormat:@"%d", _downdloadCount]];
    [downloadTask setDownloadFileModel:downloadFileModel];
    [downloadTask setDownloadUIBinder:self];
    
    [_client addDownloadTask:downloadTask];
    [self startDownloadWithTask:downloadTask];
}

- (void)addDownload
{
    NSLog(@"添加下载...");
    
    
}

- (void)startDownloadWithTask:(GSDownloadTask*)downloadTask
{
    [_client downloadDataAsyncWithTask:downloadTask
                                 begin:^{
                                     NSLog(@"准备开始下载...");
                                 }
                              progress:^(long long totalBytesRead, long long totalBytesExpectedToRead, float progress) {
                                  
                                  downloadTask.totalBytesRead = totalBytesRead;
                                  downloadTask.totalBytesExpectedToRead = totalBytesExpectedToRead;
                                  downloadTask.progress = progress;
                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      //                                      _displayProgress.progress = progress;
                                      //                                      _displayProgressLabel.text = [NSString stringWithFormat: @"%lld/%lld",totalBytesRead,totalBytesExpectedToRead];
                                  });
                                  
                              }
                              complete:^(NSError *error) {
                                  
                                  if (error)
                                  {
                                      NSLog(@"下载失败,%@",error);
                                      downloadTask.downloadStatus = GSDownloadStatusFailure;
                                      [self updateUIWithTask:downloadTask];
                                  }
                                  else
                                  {
                                      NSLog(@"下载成功");
                                      downloadTask.downloadStatus = GSDownloadStatusSuccess;
                                      [self updateUIWithTask:downloadTask];
                                  }
                                  
                              }];
}

- (void)updateUIWithTask:(id<GSSingleDownloadTaskProtocol>)downloadTask{
        GSDownloadTask *task = downloadTask;
        if ([_delegate respondsToSelector:@selector(updateDataWithDownloadTask:)]) { // 如果协议响应了sendValue:方法
            [_delegate updateDataWithDownloadTask:task]; // 通知执行协议方法
    }
   
}



@end
