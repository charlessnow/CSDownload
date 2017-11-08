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


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) NSMutableArray *dataSouceArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    DataModel *dataModel = [DataModel new];
    dataModel.URLstring = @"https://dldir1.qq.com/qqfile/QQforMac/QQ_V6.1.1.dmg";
    dataModel.fileName = @"QQ for Mac";
    [self.dataSouceArray addObject:dataModel];
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

@end
