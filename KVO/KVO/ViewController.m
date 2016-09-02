//
//  ViewController.m
//  KVO
//
//  Created by 何军 on 9/3/16.
//  Copyright © 2016 何军. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

/**
 * 当前时间
 */
@property (nonatomic, copy) NSString *currrentTime;

/**
 * 时间label
 */
@property (nonatomic, weak) UILabel *timeLabel;
/**
 * 获取当前时间button
 */
@property (nonatomic, weak) UIButton *timeButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *timeLabel = [UILabel new];
    timeLabel.frame = CGRectMake(0, 100, self.view.bounds.size.width, 50);
    timeLabel.textAlignment = NSTextAlignmentCenter;
    timeLabel.text = @"点击按钮获取当前时间";
    timeLabel.backgroundColor = [UIColor grayColor];
    [self.view addSubview:timeLabel];
    self.timeLabel = timeLabel;
    
    UIButton *timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [timeButton setTitle:@"get current time" forState:UIControlStateNormal];
    [timeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    timeButton.backgroundColor = [UIColor grayColor];
    [timeButton addTarget:self action:@selector(getCurrentTime) forControlEvents:UIControlEventTouchUpInside];
    timeButton.frame = CGRectMake(0, CGRectGetMaxY(self.timeLabel.frame) + 50, self.view.bounds.size.width, 50);
    [self.view addSubview:timeButton];
    self.timeButton = timeButton;
    
    [self addObserver:self forKeyPath:@"currrentTime" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"currrentTime" context:nil];
}

#pragma mark - handle click action
- (void)getCurrentTime {
    self.currrentTime = [NSString stringWithFormat:@"%@", [NSDate date]];
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"currrentTime"] && object == self) {
        
        NSString *currentTime = change[@"new"];
        self.timeLabel.text = currentTime;
    }
}

@end
