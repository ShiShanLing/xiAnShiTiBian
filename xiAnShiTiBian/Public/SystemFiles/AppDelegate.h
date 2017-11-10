//
//  AppDelegate.h
//  EntityConvenient
//
//  Created by 石山岭 on 2016/11/18.
//  Copyright © 2016年 石山岭. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//百度地图
#import <BaiduMapAPI_Map/BMKMapComponent.h>

#import "WXApi.h"//微信
@interface AppDelegate : UIResponder <UIApplicationDelegate, BMKGeneralDelegate, WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

