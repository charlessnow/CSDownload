//
//  GSDownloadTask.m
//  GSDownloaderSDK
//
//  Created by Chaoqian Wu on 14-3-11.
//  Copyright (c) 2014年 4399 Network CO.ltd. All rights reserved.
//

#import "GSDownloadTask.h"
#import "NSObject+KVOBlock.h"

@implementation GSDownloadTask
{
    NSURLSessionDataTask *_downloadDataTask;
    
    int _failureCount;
    
    id _downloadStatusKVO;
}

- (id)init
{
    self = [super init];
    if (self) {
        _downloadStatus = GSDownloadStatusTaskNotCreated;
        [self initDownloadStatusObserver];
    }
    
    return self;
}

- (void)initDownloadStatusObserver
{
    _downloadStatusKVO = [self addKVOBlockForKeyPath:@"downloadStatus" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld handler:^(NSString *keyPath, id object, NSDictionary *change) {
        
        //GSDownloadStatus oldStatusValue = [[change objectForKey:NSKeyValueChangeOldKey] integerValue];
        
        
        GSDownloadTask* task = object;
        [task.getDownloadUIBinder updateUIWithTask:task];
    }];
    
}


- (BOOL)isEqualToDownloadTask:(GSDownloadTask*)downloadTask
{
    if ([[self getDownloadTaskId]compare:[downloadTask getDownloadTaskId]] == 0) {
        return YES;
    }
    return NO;
}

#pragma mark - GSSingleDownloadTaskProtocol

- (void)setDownloadDataTask:(NSURLSessionDataTask *)downloadDataTask{
    _downloadDataTask = downloadDataTask;
}


- (void)startDownloadTask:(void (^)())bindDoSomething
{
    [_downloadDataTask resume];
    NSLog(@"%@",_downloadDataTask);
    if (bindDoSomething)
    {
        bindDoSomething();
    }
}

- (void)pauseDownloadTask:(void (^)())bindDoSomething
{
    [_downloadDataTask suspend];
    
    if (bindDoSomething)
    {
        bindDoSomething();
    }
}

- (void)continueDownloadTask:(void (^)())bindDoSomething
{
    if (_downloadDataTask.state == NSURLSessionTaskStateSuspended) {
        [_downloadDataTask resume];
    }
    
    if (bindDoSomething)
    {
        bindDoSomething();
    }
}

- (void)cancelDownloadTask:(void (^)())bindDoSomething
{
    [_downloadDataTask cancel];
    
    if (bindDoSomething)
    {
        bindDoSomething();
    }
}

- (int)increaseFailureCount
{
    _failureCount++;
    
    return _failureCount;
}

#pragma mark - dealloc
- (void)dealloc
{
    NSLog(@"%@ dealloc",[self class]);
    
    [self removeKVOBlockForToken:_downloadStatusKVO];
}

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com
