//
//  UITableView+ZQAdd.h
//  ZQFoundation
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/9/25.
//  零行代码为 tableview 添加空数据加载占位图

#import <UIKit/UIKit.h>

//@interface UITableView_ZQEmptyData: NSObject
//
//@end

@interface UITableView (ZQEmptyData)
@property (nonatomic, assign) BOOL firstReload;        //是否第一次加载
@property (nonatomic, assign) BOOL isShowEmpty;        //reload 时是否展示空数据占位图
@property (nonatomic,   copy) void(^reloadBlock)(void);//空白页点击事件
@end


@interface UICollectionView (ZQEmptyData)

@property (nonatomic, assign) BOOL firstReload;
@property (nonatomic, assign) BOOL isShowEmpty;        //reload 时是否展示空数据占位图
@property (nonatomic,   copy) void(^reloadBlock)(void);

@end
