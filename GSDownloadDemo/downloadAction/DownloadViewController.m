//
//  DownloadViewController.m
//  GSDownloadDemo
//
//  Created by wisnuc-imac on 2017/11/8.
//  Copyright © 2017年 wisnuc-imac. All rights reserved.
//

#import "DownloadViewController.h"

@interface DownloadViewController ()
{
    GSDownloaderClient* _client;
    int _downdloadCount;
}

@end

@implementation DownloadViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    _client = [GSDownloaderClient sharedDownloaderClient];
    _client.maxDownload = 1;
    _client.maxWaiting = 1;
    _client.maxPaused = 1;
    _client.maxFailureRetryChance = 10;
    
    _downdloadCount = 0;
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)startButtonClick:(UIButton *)sender {
    
    [self addDownload];
    
}
- (IBAction)stopButtonClick:(UIButton *)sender {
    GSDownloadTask* downloadTask = [[_client downloadTasks] objectAtIndex:0];
    [self pauseDownloadWithTask:downloadTask];
    
}
- (IBAction)removeButtonClick:(UIButton *)sender {
    GSDownloadTask* downloadTask = [[_client downloadTasks] objectAtIndex:0];
    GSDownloadFileModel *downloadFilModel = [downloadTask getDownloadFileModel];
    NSString *tempPath = [downloadFilModel getDownloadTempSavePath];
    NSString *savePath = [downloadFilModel getDownloadFileSavePath];
    [GSFileUtil deleteFileAtPath:tempPath];
    [GSFileUtil deleteFileAtPath:savePath];
}

- (IBAction)continueButton:(UIButton *)sender {
    [_client startAllDownloadTask];
}

- (void)addDownload
{
    NSLog(@"添加下载...");
    
    _downdloadCount++;
    
    NSString* fromUrl = @"https://dldir1.qq.com/qqfile/QQforMac/QQ_V6.1.1.dmg";
    
    NSString* tmpFileName = [NSString stringWithFormat:@"image-%d.tmp",_downdloadCount];
    NSString* saveFileName= [NSString stringWithFormat:@"image-%d.jpg",_downdloadCount];
    
    NSString* savePath = [GSFileUtil getPathInDocumentsDirBy:@"Downloads/" createIfNotExist:YES];
    NSString* saveFile = [savePath stringByAppendingPathComponent:saveFileName];
    
    NSLog(@"成功下载路径为:%@",savePath);
    NSLog(@"成功文件为:%@",saveFile);
    
    NSString* tempPath = [GSFileUtil getPathInDocumentsDirBy:@"Downloads/Tmp" createIfNotExist:YES];
    NSString* tempFile = [tempPath stringByAppendingPathComponent:tmpFileName];
    
    NSLog(@"临时下载路径为:%@",tempPath);
    NSLog(@"临时文件为:%@",tempFile);
    
    GSDownloadFileModel* downloadFileModel = [[GSDownloadFileModel alloc] init];
    [downloadFileModel setDownloadFileName:@"全民酷跑"];
    [downloadFileModel setDownloadFileAvatorURL:@"http://f1.img4399.com/mi~136383~124x124?1392195212"];
    [downloadFileModel setDownloadTaskURL:fromUrl];
    [downloadFileModel setDownloadFileSavePath:saveFile];
    [downloadFileModel setDownloadTempSavePath:tempFile];
    [downloadFileModel setDownloadFileVersion:@"2.0"];
    [downloadFileModel setDownloadFilePlistURL:@""];
    
    GSDownloadTask* downloadTask = [[GSDownloadTask alloc] init];
    [downloadTask setDownloadTaskId:[NSString stringWithFormat:@"%d", _downdloadCount]];
    [downloadTask setDownloadFileModel:downloadFileModel];
    [downloadTask setDownloadUIBinder:self];
    
    [_client addDownloadTask:downloadTask];
    
    //[self startDownloadWithTask:downloadTask];
    
    //    [_downloadTaskTableView reloadData];
    
    [self startDownloadWithTask:downloadTask];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MTDDownloadTableViewCellDelegate
- (void)downloadActionAtIndex:(int)index
{
    GSDownloadTask* downloadTask = [[_client downloadTasks] objectAtIndex:index];
    
    switch ([downloadTask getDownloadStatus]) {
        case GSDownloadStatusTaskNotCreated:
            [self startDownloadWithTask:downloadTask];
            break;
            
        case GSDownloadStatusDownloading:
            [self pauseDownloadWithTask:downloadTask];
            break;
            
        case GSDownloadStatusPaused:
            [self continueDownloadWithTask:downloadTask];
            break;
        default:
            break;
    }
    
}
- (void)updateUIWithTask:(id<GSSingleDownloadTaskProtocol>)downloadTask{
    
    switch ([(GSDownloadTask *)downloadTask getDownloadStatus]) {
            
        case GSDownloadStatusTaskNotCreated:
            
            break;
        case GSDownloadStatusWaitingForStart:
            
            break;
        case GSDownloadStatusDownloading:
            
            break;
        case GSDownloadStatusPaused:
            
            break;
        case GSDownloadStatusWaitingForResume:
            
            break;
        case GSDownloadStatusCanceled:
            
            break;
        case GSDownloadStatusSuccess:
        {
            [self displayImageWithTask:downloadTask];
        }
            break;
        case GSDownloadStatusFailure:
            
            break;
    }
}

- (void)displayImageWithTask:(GSDownloadTask*)downloadTask{
    GSDownloadFileModel *downloadFilModel = [downloadTask getDownloadFileModel];
    NSString *savePath = [downloadFilModel getDownloadFileSavePath];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:savePath]) {
        NSLog(@"%@",[NSThread currentThread]);
        //        dispatch_async(dispatch_get_main_queue(), ^{
        NSData *datas = [NSData dataWithContentsOfFile:savePath];
        NSLog(@"%@",datas);
        if(datas)
        {
            //如果沙盒里面有数据，加载沙盒数据到表格，同时更新图片集合的字典
            //            UIImage *currImage = [UIImage imageWithData:datas];
            //            _imageView.image =currImage;
        }
        //        NSLog(@"%@",image);
        
        //        });
    }else{
        NSLog(@"文件不存在");
    }
}

- (void)pauseDownloadWithTask:(GSDownloadTask*)downloadTask
{
    [_client pauseOneDownloadTaskWith:downloadTask];
}

- (void)continueDownloadWithTask:(GSDownloadTask*)downloadTask
{
    [_client continueOneDownloadTaskWith:downloadTask];
}

@end
