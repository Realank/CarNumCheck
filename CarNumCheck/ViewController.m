//
//  ViewController.m
//  CarNumCheck
//
//  Created by Realank on 16/1/20.
//  Copyright © 2016年 realank. All rights reserved.
//

#import "ViewController.h"
#import "HttpUtil.h"
#import "DetailViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *provinceTF;
@property (weak, nonatomic) IBOutlet UITextField *carNumTF;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)checkNumberWithProvince:(NSString*)prov andNumber:(NSString*)number {
    NSArray *key = @[@"txtVehicleNo",@"lei",@"provice"];
    NSArray *value = @[number,@"小型汽车",prov];
    NSDictionary *params = [NSDictionary dictionaryWithObjects:value forKeys:key];
    [HttpUtil send_request:@"http://www.tjits.cn/wfcx/vehiclelist____aacccccccccc.asp" post:YES params:params completed:^(id json, NSData *data, NSString *string) {
        DetailViewController *vc = [[DetailViewController alloc]init];
        vc.htmlContent = string;
        [self.navigationController pushViewController:vc animated:YES];
        
    } failed:^(NSError *error, NSString *message) {
        
    }];
}
- (IBAction)checkNunber:(id)sender {
    [self checkNumberWithProvince:self.provinceTF.text andNumber:self.carNumTF.text];
    [self.view endEditing:YES];
}

@end
