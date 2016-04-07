//
//  ViewController.m
//  Encryption
//
//  Created by Cwenqing on 15/4/22.
//  Copyright (c) 2015年 cwenqing. All rights reserved.
//

#import "ViewController.h"
#import "NSString+MD5.h"
#import "NSData+AES.h"
#import "Base64.h"
@interface ViewController ()
@property(nonatomic, strong)UITextView *inputTV;
@property(nonatomic, strong)UITextView *outputTV;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _inputTV = [[UITextView alloc]init];
    _inputTV.bounds = CGRectMake(0, 0, 300, 100);
    _inputTV.center = CGPointMake(MainScreenFrame.size.width/2, 150);
    _inputTV.layer.cornerRadius = 5;
    _inputTV.layer.borderWidth = 1;
    _inputTV.text = @"测试";
    _inputTV.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    [self.view addSubview:_inputTV];

    NSArray *segementAry = [NSArray arrayWithObjects:@"MD5", @"AES", @"Base64", nil];
    UISegmentedControl *segment = [[UISegmentedControl alloc]initWithItems:segementAry];
    segment.bounds = CGRectMake(0, 0, 300, 40);
    segment.center = CGPointMake(MainScreenFrame.size.width/2, 250);
    [segment addTarget:self action:@selector(encrypt:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:segment];

    _outputTV = [[UITextView alloc]init];
    _outputTV.bounds = CGRectMake(0, 0, 300, 100);
    _outputTV.center = CGPointMake(MainScreenFrame.size.width/2, 350);
    _outputTV.layer.cornerRadius = 5;
    _outputTV.layer.borderWidth = 1;
    _outputTV.layer.borderColor = [[UIColor lightGrayColor]CGColor];
    [self.view addSubview:_outputTV];

}

-(void)encrypt:(UISegmentedControl *)sender{
    NSString *result;
    switch (sender.selectedSegmentIndex) {
        case 0:
            //MD5加密 ***MD5没有解密****
            result = [_inputTV.text md5Encrypt];
            break;
        case 1:{
            //AES加密
            NSData *encryptData = [[_inputTV.text dataUsingEncoding:NSUTF8StringEncoding]AES256EncryptWithKey:@"%x"];
            result = [NSString stringWithFormat:@"%@",encryptData];
            //AES解密
            NSData *decryptData = [encryptData AES256DecryptWithKey:@"%x"];
            NSLog(@"%@",[[NSString alloc]initWithData:decryptData encoding:NSUTF8StringEncoding]);
        }
            break;
        case 2:{
            //Base64加密
            result = [Base64 base64StringFromText:_inputTV.text];
            //Base64解密
            NSLog(@"%@",[Base64 textFromBase64String:result]);
        }
            break;
        default:
            break;
    }
    _outputTV.text = result;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
