//
//  GSDeviceUtil.h
//  GSCoreCommon
//
//  Created by Chaoqian Wu on 13-11-20.
//  Copyright (c) 2013年 4399 Network CO.ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSDeviceUtil : NSObject

/**
 *  获取系统iOS主版本号
 *
 *  @return iOS主版本号
 */
+ (NSUInteger)getDeviceSystemMajorVersion;

/**
 *  获取系统iOS版本号
 *
 *  @return iOS版本号
 */
+ (NSString*)getDeviceSystemVersionString;

/**
 *  获取设备机型
 *
 *  @return 机型
 */
+ (NSString*)getDeviceModel;

/**
 *  获取屏幕分辨率
 *
 *  @return 屏幕分辨率
 */
+ (NSString*)getDeviceScreenResolution;

/**
 *  获取设备名称
 *
 *  @return 设备名称
 */
+ (NSString*)getDeviceName;

/**
 *  根据Keychain文件,获取设备UUID
 *
 *  @return
 */
+ (NSString*)getDeviceUUID;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com