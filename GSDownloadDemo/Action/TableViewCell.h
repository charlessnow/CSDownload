//
//  TableViewCell.h
//  GSDownloadDemo
//
//  Created by wisnuc-imac on 2017/11/8.
//  Copyright © 2017年 wisnuc-imac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fileNameLabel;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;

@end
