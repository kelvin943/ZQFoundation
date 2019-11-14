//
//  tableVC.m
//  ZQFoundation_Example
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/10/23.
//  Copyright © 2019 macro. All rights reserved.
//

#import "tableVC.h"

@interface tableVC ()

@end

@implementation tableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableViewAdaptor.pullRefreshEnable = YES;
    self.tableViewAdaptor.loadMoreEnable = YES;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self construstData];
}
- (void)refreshReload:(ZQTableViewRefreshType)pullType {
    [self.tableViewAdaptor.mjHeader endRefreshing];
    [self.tableViewAdaptor.mjFooter endRefreshing];
    self.tableViewAdaptor.loadMoreEnable = NO;
}

- (void)tableView:(UITableView *)tableView
didSelectObject:(id<CellModelBasicProtocol>)object
    atIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)construstData {
    NSMutableArray * items = @[].mutableCopy;
    {
       ZQCustomDefaultCellItem * item = [ZQCustomDefaultCellItem cellWithTitleStr:@"adsfas" subTitle:@"1231"];
       item.cellHeight = @(100);
       [items addObject:item];
    }
    {
       ZQCustomDefaultCellItem * item = [ZQCustomDefaultCellItem cellWithTitleStr:@"adsfas" subTitle:@"1231"];
       item.cellHeight = @(100);
        item.bgColor = [UIColor randomColor];
       [items addObject:item];
    }
    {
       ZQCustomDefaultCellItem * item = [ZQCustomDefaultCellItem cellWithTitleStr:@"adsfas" subTitle:@"1231"];
       item.cellHeight = @(100);
        item.bgColor = [UIColor randomColor];
       [items addObject:item];
    }
    {
       ZQCustomDefaultCellItem * item = [ZQCustomDefaultCellItem cellWithTitleStr:@"adsfas" subTitle:@"1231"];
       item.cellHeight = @(100);
        item.bgColor = [UIColor randomColor];
       [items addObject:item];
    }
    {
       ZQCustomDefaultCellItem * item = [ZQCustomDefaultCellItem cellWithTitleStr:@"adsfas" subTitle:@"1231"];
       item.cellHeight = @(100);
        item.bgColor = [UIColor randomColor];
       [items addObject:item];
    }
    {
       ZQCustomDefaultCellItem * item = [ZQCustomDefaultCellItem cellWithTitleStr:@"adsfas" subTitle:@"1231"];
       item.cellHeight = @(100);
        item.bgColor = [UIColor randomColor];
       [items addObject:item];
    }
    {
       ZQCustomDefaultCellItem * item = [ZQCustomDefaultCellItem cellWithTitleStr:@"adsfas" subTitle:@"1231"];
       item.cellHeight = @(100);
        item.bgColor = [UIColor randomColor];
       [items addObject:item];
    }
    {
       ZQCustomDefaultCellItem * item = [ZQCustomDefaultCellItem cellWithTitleStr:@"adsfas" subTitle:@"1231"];
       item.cellHeight = @(100);
        item.bgColor = [UIColor randomColor];
       [items addObject:item];
    }
    {
       ZQCustomDefaultCellItem * item = [ZQCustomDefaultCellItem cellWithTitleStr:@"adsfas" subTitle:@"1231"];
       item.cellHeight = @(100);
        item.bgColor = [UIColor randomColor];
       [items addObject:item];
    }
    {
       ZQCustomDefaultCellItem * item = [ZQCustomDefaultCellItem cellWithTitleStr:@"adsfas" subTitle:@"1231"];
       item.cellHeight = @(100);
        item.bgColor = [UIColor randomColor];
       [items addObject:item];
    }
    {
       ZQCustomDefaultCellItem * item = [ZQCustomDefaultCellItem cellWithTitleStr:@"adsfas" subTitle:@"1231"];
       item.cellHeight = @(100);
        item.bgColor = [UIColor randomColor];
       [items addObject:item];
    }
    {
       ZQCustomDefaultCellItem * item = [ZQCustomDefaultCellItem cellWithTitleStr:@"adsfas" subTitle:@"1231"];
       item.cellHeight = @(100);
        item.bgColor = [UIColor randomColor];
       [items addObject:item];
    }
    {
       ZQCustomDefaultCellItem * item = [ZQCustomDefaultCellItem cellWithTitleStr:@"adsfas" subTitle:@"1231"];
       item.cellHeight = @(100);
       [items addObject:item];
    }
    
    self.tableViewAdaptor.items = items;
    [self.tableView reloadData];
    
}

@end
