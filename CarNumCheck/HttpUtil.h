//
//  HttpUtil.h
//  HTTPRequest
//
//  Created by Realank on 16/1/6.
//  Copyright © 2016年 iMooc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

typedef void (^KKSucceedBlock)( id json, NSData *data, NSString *string );
typedef void (^KKFailedBlock)( NSError *error, NSString *message );

@interface HttpUtil : NSObject

+ (AFHTTPRequestOperation *)send_request:(NSString *)request post:(BOOL)post params:(id)params completed:(KKSucceedBlock)succeed failed:(KKFailedBlock)failed;

@end
