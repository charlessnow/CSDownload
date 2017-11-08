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

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (strong, nonatomic) 

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    TableViewCell *cell;
    cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableViewCell class])];
    if (nil == cell) {
        cell= [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([TableViewCell class]) owner:nil options:nil] lastObject];
    }
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    <#code#>
}



@end
