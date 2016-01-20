//
//  DetailViewController.m
//  CarNumCheck
//
//  Created by Realank on 16/1/20.
//  Copyright © 2016年 realank. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查询结果";
    [self.webView loadHTMLString:self.htmlContent baseURL:[NSURL URLWithString:@"http://www.tjits.cn/"]];
}


@end
