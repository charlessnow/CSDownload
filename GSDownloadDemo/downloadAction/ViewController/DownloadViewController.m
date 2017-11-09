//
//  DownloadViewController.m
//  GSDownloadDemo
//
//  Created by wisnuc-imac on 2017/11/8.
//  Copyright © 2017年 wisnuc-imac. All rights reserved.
//

#import "DownloadViewController.h"
#import "LocalDownloadTableViewCell.h"
#import "LocalDownloadingTableViewCell.h"
#import "DownloadHandler.h"

@interface DownloadViewController ()<UITableViewDelegate,UITableViewDataSource,DownloadHandlerDelegate>
{
    GSDownloaderClient* _client;
    int _downdloadCount;
}
@property (weak, nonatomic) IBOutlet UITableView *mianTableView;
@property (nonatomic,strong) NSMutableArray *downloadingArray;

@property (nonatomic,strong) NSMutableArray *downloadedArray;

@end

@implementation DownloadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"下载管理";
    _client  = [GSDownloaderClient sharedDownloaderClient];
    [DownloadHandler shareManager].delegate = self;
    [self loadData];
    _mianTableView.delegate = self;
    _mianTableView.dataSource = self;
    _mianTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)loadData{
    self.downloadingArray = [NSMutableArray arrayWithArray:_client.downloadingTasks];
    self.downloadedArray = [NSMutableArray arrayWithArray:_client.downloadedTasks];
}

- (void)updateDataWithDownloadTask:(GSDownloadTask *)downloadTask{
    [self loadData];
    [self.mianTableView reloadData];
}

#pragma UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        LocalDownloadingTableViewCell * cell;
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LocalDownloadingTableViewCell class])];
        if (nil == cell) {
            cell= [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LocalDownloadingTableViewCell class]) owner:nil options:nil] lastObject];
        }
        GSDownloadTask *downloadTask = _downloadingArray[indexPath.row];
        GSDownloadFileModel* downloadFileModel = [downloadTask getDownloadFileModel];
        cell.fileNameLabel.text = downloadFileModel.downloadFileName;
        return cell;
    }else
    {
    LocalDownloadTableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([LocalDownloadTableViewCell class])];
    if (nil == cell) {
        cell= [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([LocalDownloadTableViewCell class]) owner:nil options:nil] lastObject];
    }
        GSDownloadTask *task =  _downloadedArray[indexPath.row];
        GSDownloadFileModel *model = [task getDownloadFileModel];
        cell.fileNameLabel.text = model.downloadFileName;
        cell.downloadTimeLabel.text = model.downloadFinishTime;
        cell.fileSizeLabel.text = [self calculateUnit:[model.downloadFileSize unsignedLongLongValue] ];
    return cell;
  }
}


- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
     if (section == 0){
        return self.downloadingArray.count;
    }else{
        return self.downloadedArray.count;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
   if(section == 0){
        return @"正在下载";
    }
    else{
        return @"已下载";
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}

-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    //    view.tintColor = [UIColor whiteColor];
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    //    header.contentView.backgroundColor=MainColor;
    //    header.textLabel.textAlignment=NSTextAlignmentCenter;
    [header.textLabel setTextColor:[UIColor darkTextColor]];
    
    
}
#pragma UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (NSString *)calculateUnit:(unsigned long long)contentLength
{
    unsigned long long size =contentLength;
    NSString *sizeText = nil;
    if (contentLength >= pow(10, 9)) { // size >= 1GB
        sizeText = [NSString stringWithFormat:@"%.2fG", size / pow(10, 9)];
    } else if (size >= pow(10, 6)) { // 1GB > size >= 1MB
        sizeText = [NSString stringWithFormat:@"%.2fM", size / pow(10, 6)];
    } else if (size >= pow(10, 3)) { // 1MB > size >= 1KB
        sizeText = [NSString stringWithFormat:@"%.2fK", size / pow(10, 3)];
    } else { // 1KB > size
        sizeText = [NSString stringWithFormat:@"%zdB", size];
    }
    return sizeText;
}


- (NSMutableArray *)downloadedArray{
    if(!_downloadedArray){
        _downloadedArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _downloadedArray;
}

- (NSMutableArray *)downloadingArray{
    if(!_downloadingArray){
        _downloadingArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _downloadingArray;
}

@end
