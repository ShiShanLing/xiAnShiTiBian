//
//  CKHttpCommunicate.h
//  MumMum
//
//  Created by shlity on 16/6/16.
//  Copyright © 2016年 Moresing Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSInteger , HTTPRequestMethod)
{
    POST = 0,
    GET,
    PUT,
    DELETE
};

@interface CKHttpCommunicate : NSObject

+ (id)sharedInstance;





/**
 *  上传文件功能，如图片等
 *
 *  @param taskID             服务器提供的接口，用一个枚举来管理
 *  @param param              传的参数
 *  @param Exparam            文件流，将要上传的文件转成NSData中，然后一起传给服务器
 *  @param method             GET,POST,DELETE,PUT方法
 *  @param success            请求完成
 *  @param uploadFileProgress 请求图片的进度条，百分比
 *  @param failure            请求失败
 */
+ (void)createRequest:(NSString *)taskID
            WithParam:(NSDictionary*)param
          withExParam:(NSDictionary*)Exparam
           withMethod:(HTTPRequestMethod)method
              success:(void (^)(id result))success
              uploadFileProgress:(void(^)(NSProgress *uploadProgress))uploadFileProgress
              failure:(void (^)(NSError* erro))failure;


@end
