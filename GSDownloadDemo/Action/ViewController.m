//
//  ViewController.m
//  GSDownloadDemo
//
//  Created by wisnuc-imac on 2017/11/7.
//  Copyright © 2017年 wisnuc-imac. All rights reserved.
//

#import "ViewController.h"
#import "ACDownloadFileModel.h"
#import "TableViewCell.h"
#import "DataModel.h"
#import "DownloadHandler.h"
#import "DownloadViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,DownloadHandlerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) NSMutableArray *dataSouceArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"文件夹";
    [self setTableViewDelegate];
    [self loadData];
    [DownloadHandler shareManager].delegate = self;
}

- (void)setTableViewDelegate{
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
}

- (void)loadData{
    DataModel *dataModel = [DataModel new];
    dataModel.URLstring = @"https://dldir1.qq.com/qqfile/QQforMac/QQ_V6.1.1.dmg";
    dataModel.fileName = @"QQ for Mac";
    [self.dataSouceArray addObject:dataModel];
    
    DataModel *dataModel2 = [DataModel new];
    dataModel2.URLstring = @"http://d1.music.126.net/dmusic/NeteaseMusic_1.5.7_580_web.dmg";
    dataModel2.fileName = @"NeteaseMusic for Mac";
    [self.dataSouceArray addObject:dataModel2];
}

- (IBAction)nextButtonClick:(UIButton *)sender {
    DownloadViewController *downloadVC = [[DownloadViewController alloc]init];
    [self.navigationController pushViewController:downloadVC animated:YES];
}

- (IBAction)allDownloadButtonClick:(UIButton *)sender {
    for (DataModel *model in _dataSouceArray) {
        
        [[DownloadHandler shareManager] downloadFileWithFileModel:model];
        
    }
}

- (void)downloadButtenClick:(UIButton *)sender{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"请选择" preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"下载" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
            NSIndexPath * path = [self.mainTableView indexPathForCell:cell];
            DataModel *dataModel = [_dataSouceArray objectAtIndex:path.row];
            [[DownloadHandler shareManager] downloadFileWithFileModel:dataModel];
    }]];
    [self presentViewController:alertController animated:YES completion:nil];
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    TableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableViewCell class])];
    if (nil == cell) {
        cell= [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TableViewCell class]) owner:nil options:nil] lastObject];
    }
    DataModel *dataModel = _dataSouceArray[indexPath.row];
    cell.fileNameLabel.text = dataModel.fileName;
    [cell.downloadButton addTarget:self action:@selector(downloadButtenClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSouceArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 64;
}

- (NSMutableArray *)dataSouceArray{
    if (!_dataSouceArray) {
        _dataSouceArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataSouceArray;
}

- (void)updateDataWithDownloadTask:(GSDownloadTask *)downloadTask{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        NSUInteger row = [[aPercent objectAtIndex:2] integerValue];
//        NSIndexPath *path=[NSIndexPath indexPathForRow:row inSection:0];
//        TableViewCell *cell = (TableViewCell *)[_mainTableView cellForRowAtIndexPath:path];
//        dispatch_async(dispatch_get_main_queue(), ^{
//         if (downloadTask.downloadStatus == GSDownloadStatusSuccess) {
//              }else if (downloadTask.downloadStatus == GSDownloadStatusFailure){
//            }
//        });
//    });
}

@end
