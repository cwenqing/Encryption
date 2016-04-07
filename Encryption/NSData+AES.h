//
//  NSData+AES.h
//  Encryption
//
//  Created by Cwenqing on 15/4/22.
//  Copyright (c) 2015年 cwenqing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES)
- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
@end
