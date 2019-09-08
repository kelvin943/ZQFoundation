//
//  BaseViewController.m
//  MJRefresh
//
//  Created by macro on 2019/9/6.
//

#import "BaseViewController.h"

@interface BaseViewController ()
//点击收键盘的手势
@property(nonatomic,strong) UITapGestureRecognizer *tap;

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //注册键盘通知
    [self registerKeyboardNotification];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
   

#pragma mark - Keyboard Notification

- (UITapGestureRecognizer *)tap{
    if (_tap == nil) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selfViewTapped:)];
        _tap.cancelsTouchesInView = YES;
    }
    return _tap;
}
- (void)selfViewTapped:(UITapGestureRecognizer *)tap{
    if (tap.view == self.view) {
        [self dismissKeyboard];
    }
}

- (void)dismissKeyboard{
    [self.view endEditing:YES];
}
- (void)registerKeyboardNotification {
    if ([self needAddTapGestureDismissKeyborad]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
}

- (void)keyboardWillShow:(NSNotification *)notification{
    [self.view addGestureRecognizer:self.tap];
}

- (void)keyboardWillHide:(NSNotification *)notification{
    if (_tap) {
        [self.view removeGestureRecognizer:self.tap];
    }
}

- (void)unregisterNotification {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



#pragma mark - ZQNavigatorProtocol Methods
- (instancetype)initWithQuery:(NSDictionary *)query {
    if (self = [super init]) {
        
    }
    return self;
}
#pragma mark - BaseViewControllerProtocol Methods
- (BOOL)disableInteractiveGesture{
    return  NO;
}
- (BOOL)needAddTapGestureDismissKeyborad {
    return NO;
}
@end
