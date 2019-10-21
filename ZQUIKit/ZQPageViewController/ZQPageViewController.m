//
//  ZQPageViewController.m
//  ZQFoundation
//
//  Created by 张泉(平安好房技术中心智慧城市房产云研发团队前端研发组) on 2019/10/18.
//

#import "ZQPageViewController.h"

@implementation ZQPageCollectionCell

+ (NSString *)reuseIdentifier {
    return NSStringFromClass([self class]);
}

- (void)addChildViewIfNeeded {
    if (![self containsViewOfController:self.viewController]) {
        [self.contentView addSubview:self.viewController.view];
        self.viewController.view.frame = self.contentView.bounds;
    }
}

- (BOOL)containsViewOfController:(__kindof UIViewController *)controller {
    if (self.contentView == controller.view.superview) {
        return YES;
    }
    return NO;
}

@end



@interface ZQPageViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;

@end

@implementation ZQPageViewController


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat top = self.pageContetnInset.top;
    CGFloat bottom = self.pageContetnInset.bottom;
    CGFloat left = self.pageContetnInset.left;
    CGFloat right = self.pageContetnInset.right;
    self.collectionViewFlowLayout.itemSize = CGSizeMake(self.view.bounds.size.width - left - right, self.view.bounds.size.height - top - bottom);
    self.collectionView.frame = CGRectMake(left, top, self.view.bounds.size.width - left - right, self.view.bounds.size.height - top - bottom);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.pageContetnInset = UIEdgeInsetsZero;
    [self.view addSubview:self.collectionView];
    // Do any additional setup after loading the view.
}


- (void)reladPages {
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource / UICollectionViewDelegate
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    /// 假设说只有两个控制器左右滑动
    return self.childViewControllers.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = [ZQPageCollectionCell reuseIdentifier];
    ZQPageCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.viewController = self.childViewControllers[indexPath.row];
    [cell addChildViewIfNeeded];
    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.delegate && [self.delegate respondsToSelector:@selector(pageViewController:didScrolledXPercetage:)]) {
        [self.delegate pageViewController:self didScrolledXPercetage:(scrollView.contentOffset.x / self.view.bounds.size.width)];
    }
}

#pragma mark - lazy load

- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        _collectionViewFlowLayout = [UICollectionViewFlowLayout new];
        _collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionViewFlowLayout.itemSize = self.view.bounds.size;
        _collectionViewFlowLayout.minimumLineSpacing = 0;
        _collectionViewFlowLayout.minimumInteritemSpacing = 0;
    }
    
    return _collectionViewFlowLayout;
}


-(UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.collectionViewFlowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.scrollsToTop = NO;
        _collectionView.bounces = NO;
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
       [_collectionView registerClass:[ZQPageCollectionCell class] forCellWithReuseIdentifier:[ZQPageCollectionCell reuseIdentifier]];
       if (self.navigationController) {
           [_collectionView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
       }
    }
    
    return _collectionView;
}

@end
