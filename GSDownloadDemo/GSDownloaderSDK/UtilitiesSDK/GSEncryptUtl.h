//
//  GSEncryptUtl.h
//  GSCoreCommon
//
//  Created by  imac_hjq on 14-1-22.
//  Copyright (c) 2014年 4399 Network CO.ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface GSEncryptUtl : NSObject
/**
 *  加密解密字符串
 *
 *  @param sTextIn          字符串
 *  @param sKey             key
 *  @param encryptOrDecrypt 加密or解密
 *
 *  @return reslut
 */
+ (NSString *)doCipher:(NSString *)sTextIn key:(NSString *)sKey
			   context:(CCOperation)encryptOrDecrypt;

+ (NSString *)encodeBase64WithString:(NSString *)strData;

+ (NSData *)decodeBase64WithString:(NSString *)strBase64;

+ (NSString *)encodeBase64WithData:(NSData *)objData;

@end
// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com