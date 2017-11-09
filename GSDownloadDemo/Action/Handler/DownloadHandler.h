//
//  DownloadHandler.h
//  GSDownloadDemo
//
//  Created by wisnuc-imac on 2017/11/9.
//  Copyright © 2017年 wisnuc-imac. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol DownloadHandlerDelegate <NSObject>
@required//必须实现的代理方法

- (void)updateDataWithDownloadTask:(GSDownloadTask *)downloadTask;

@optional//不必须实现的代理方法

@end
@interface DownloadHandler : NSObject

@property(weak,nonatomic)id<DownloadHandlerDelegate> delegate;
+ (DownloadHandler*)shareManager;

- (void)downloadFileWithFileModel:(DataModel *)dataModel;
@end
