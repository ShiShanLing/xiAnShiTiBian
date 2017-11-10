//
//  CKHttpCommunicate.m
//  MumMum
//  Created by shlity on 16/6/16.
//  Copyright © 2016年 Moresing Inc. All rights reserved.
//

#import "CKHttpCommunicate.h"

#import "AFHTTPSessionManager.h"

#define TIME_NETOUT     20.0f

@implementation CKHttpCommunicate
{
    AFHTTPSessionManager *_HTTPManager;
}

- (id)init
{
    if (self = [super init])
    {
        _HTTPManager = [AFHTTPSessionManager manager];
        _HTTPManager.requestSerializer.HTTPShouldHandleCookies = YES;
        
        _HTTPManager.requestSerializer  = [AFHTTPRequestSerializer serializer];
        _HTTPManager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        
        [_HTTPManager.requestSerializer setTimeoutInterval:TIME_NETOUT];
        
        //把版本号信息传导请求头中
        [_HTTPManager.requestSerializer setValue:[NSString stringWithFormat:@"iOS-%@",[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]] forHTTPHeaderField:@"MM-Version"];
        
        [_HTTPManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept" ];
        _HTTPManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json",@"text/html", @"text/plain",nil];
        
        
    }
    return self;
}

+ (id)sharedInstance {
    static CKHttpCommunicate * HTTPCommunicate;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        HTTPCommunicate = [[CKHttpCommunicate alloc] init];
    });
    return HTTPCommunicate;
}

+ (void)createRequest:(NSString *)taskID
            WithParam:(NSDictionary*)param
          withExParam:(NSDictionary*)Exparam
           withMethod:(HTTPRequestMethod)method
              success:(void (^)(id result))success
              uploadFileProgress:(void(^)(NSProgress *uploadProgress))uploadFileProgress
              failure:(void (^)(NSError* erro))failure {
    
           [[CKHttpCommunicate sharedInstance] createUnloginedRequest:taskID WithParam:param withExParam:Exparam withMethod:method success:success failure:failure uploadFileProgress:uploadFileProgress];
}

- (void)createUnloginedRequest:(NSString *)taskID WithParam:(NSDictionary *)param withExParam:(NSDictionary*)Exparam withMethod:(HTTPRequestMethod)method success:(void(^)(id result))success failure:(void(^)(NSError *erro))failure uploadFileProgress:(void(^)(NSProgress *uploadProgress))uploadFileProgress
{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    /******************************************************************/
    
    
    NSString *URLString = taskID;
    

    /******************************************************************/
    NSMutableURLRequest *request = [_HTTPManager.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:URLString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //图片上传
        if (Exparam) {
            for (NSString *key in [Exparam allKeys]) {
                [formData appendPartWithFileData:[Exparam objectForKey:key] name:key fileName:[NSString stringWithFormat:@"%@.png",key] mimeType:@"image/jpeg"];
            }
        }
        
    } error:nil];
    
    NSURLSessionDataTask *dataTask = [_HTTPManager dataTaskWithRequest:request uploadProgress:^(NSProgress * _Nonnull uploadProgress) {
 

        if (uploadProgress) { //上传进度
            uploadFileProgress (uploadProgress);
        }
    } downloadProgress:^(NSProgress * _Nonnull downloadProgress) {
        NSLog(@"<<<>>><<><>%@", downloadProgress);
        [self showAlert:@"成功"];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        
        if (error) {
            
            
            
            if (error.code == -1009) {
                [self showAlert:@"网络已断开"];
            }else if (error.code == -1005){
                [self showAlert:@"网络连接已中断"];
            }else if(error.code == -1001){
                [self showAlert:@"请求超时"];
            }else if (error.code == -1003){
                [self showAlert:@"未能找到使用指定主机名的服务器"];
            }else{
                [self showAlert:[NSString stringWithFormat:@"code:%ld %@",error.code,error.localizedDescription]];
                NSLog(@"%@90909090909090", error);
            }
            
            if (failure != nil)
            {
                failure(error);
            }
            
        } else {
           // [self showAlert:@"成功123"];
            if (success != nil)
            {
                           }
        }
    }];
    [dataTask resume];
}
//系统提示的弹出窗
- (void)timerFireMethod:(NSTimer*)theTimer {//弹出框
    UIAlertView *promptAlert = (UIAlertView*)[theTimer userInfo];
    [promptAlert dismissWithClickedButtonIndex:0 animated:NO];
    promptAlert =NULL;
}
- (void)showAlert:(NSString *) _message{//时间
    UIAlertView *promptAlert = [[UIAlertView alloc] initWithTitle:@"提示:" message:_message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    
    [NSTimer scheduledTimerWithTimeInterval:10.0f
                                     target:self
                                   selector:@selector(timerFireMethod:)
                                   userInfo:promptAlert
                                    repeats:YES];
    [promptAlert show];
}


@end
