//
//  BaseModel.h
//  MJRefresh
//
//  Created by macro on 2019/9/6.
//

#import <Foundation/Foundation.h>
#import "YYModel.h"

@protocol  CellModelBasicProtocol <NSObject>
@property (nonatomic, assign) Class cellClass;
@property (nonatomic, assign) NSInteger cellType;
@property (nonatomic, strong) NSNumber* cellHeight;
@property (nonatomic,   weak) id  cellTarget;
@end

@interface BaseModel : NSObject <CellModelBasicProtocol,NSCopying, NSCoding, YYModel>
@property (nonatomic, copy) NSDictionary *userInfo;
@end

@interface BaseListModel : BaseModel
//数据数组
@property (nonatomic, retain) NSMutableArray* items;
//当前页码
@property (nonatomic, retain) NSNumber* page;
//当前页面数据数量
@property (nonatomic, retain) NSNumber* rows;
//是否有更多
@property (nonatomic, assign) BOOL hasMore;
//总数量
@property (nonatomic, assign) NSInteger totals;
@end
