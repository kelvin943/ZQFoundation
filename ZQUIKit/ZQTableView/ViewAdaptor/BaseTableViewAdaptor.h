//
//  BaseTableViewAdaptor.h
//  MJRefresh
//
//  Created by macro on 2019/9/6.
//

#import <Foundation/Foundation.h>
#import "MJRefresh.h"
#import "BaseModel.h"

typedef NS_ENUM(NSInteger, ZQTableViewRefreshType){
    ZQTableViewRefreshTypePullDown = 1,       //下拉
    ZQTableViewRefreshTypePullUp ,            //上拉
};



NS_ASSUME_NONNULL_BEGIN

@protocol BaseTableViewAdaptorDelegate <UITableViewDelegate,UIScrollViewDelegate>

@optional
//选中 cell 后调用
- (void)tableView:(UITableView *)tableView
  didSelectObject:(id<CellModelBasicProtocol>)object
      atIndexPath:(NSIndexPath *)indexPath;

//对cell设置数据源之后调用
- (void)tableView:(UITableView *)tableView
     didSetObject:(id<CellModelBasicProtocol>)object
             cell:(UITableViewCell *)cell;

// 下拉刷新回调
- (void)refreshReload:(ZQTableViewRefreshType)pullType;


//是否可以编辑cell
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
//设置tablview编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;
//处理编辑事件
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
//设置左滑删除标题
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface BaseTableViewAdaptor : NSObject <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MJRefreshNormalHeader *mjHeader;//mj下拉刷新控件
@property (nonatomic, strong) MJRefreshBackNormalFooter *mjFooter;//mj上拉加载
@property (nonatomic,   weak) id<BaseTableViewAdaptorDelegate> delegate;
@property (nonatomic,   weak) UITableView *tableView;

//数据源
@property (nonatomic, strong) NSMutableArray *items;
//是否开启下拉刷新
@property (nonatomic, assign) BOOL pullRefreshEnable;
//是否开启上拉加载
@property (nonatomic, assign) BOOL loadMoreEnable;

@end

NS_ASSUME_NONNULL_END
