//
//  GSCommonUtil.h
//  GSCoreCommon
//
//  Created by Chaoqian Wu on 13-12-23.
//  Copyright (c) 2013年 4399 Network CO.ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GSCommonUtil : NSObject

+ (void)clearWebViewBackground:(UIWebView*)webView;

+ (NSString*)getAppVersion;

+ (NSString*)getBundleID;

+ (NSString*)getAppDisplayName;

+ (NSString*)getCurrentLanguage;

+ (NSString*)getCurrentLocale;

+ (BOOL)isAppFirstLaunch;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com