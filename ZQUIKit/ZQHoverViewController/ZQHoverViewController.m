//
//  ZQHoverViewController.m
//  ZQFoundation
//
//  Created by 张泉(Macro) on 2019/10/30.
//

#import "ZQHoverViewController.h"

@interface ZQHoverViewController ()

@end

@implementation ZQHoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view.
}



#pragma mark - lazy load
 
- (ZQHoverScrollView*)hoverScrollView {
    if (!_hoverScrollView) {
        _hoverScrollView = [[ZQHoverScrollView alloc] initWithFrame:self.view.bounds];
        _hoverScrollView.backgroundColor = self.view.backgroundColor;
    }
    return _hoverScrollView;
}

@end
