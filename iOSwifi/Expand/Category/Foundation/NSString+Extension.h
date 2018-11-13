//
//  NSString+Extension.h
//  iOSwifi
//
//  Created by Stone on 2018/11/10.
//  Copyright © 2018 Stone. All rights reserved.
//

@interface NSString (Extension)

#pragma mark - MD5
#pragma mark -

/**
 字符串MD5加密
 
 @return 加密后的字符串
 */
- (NSString *)st_stringFromMD5;

/**
 字符串转16进制
 
 @return 转16进制后的字符串
 */
- (NSString *)st_md5HexDigest;

/**
 指定字符串MD5加密
 
 @param str 要加密的字符串
 @return 加密后的字符串
 */
+ (NSString *)st_md5:(NSString *)str;

#pragma mark - Char
#pragma mark -

/**
 字符串是否包含另外一个字符串
 
 @param other 另外一个字符串
 @return YES/NO
 */
- (BOOL)st_myContainsString:(NSString *)other;

/**
 字符串是否为空
 
 @return YES/NO
 */
- (BOOL)st_isNotEmptyOrNil;

/**
 字符串是否包含http/https
 
 @return YES/NO
 */
- (BOOL)st_hasHttpSceme;

#pragma mark - Unicode
#pragma mark -

+ (NSString *)st_stringConvertUnicode:(NSString *)str;

+ (NSString *)st_urlencodeString:(NSString *)str;

#pragma mark - Emoji
#pragma mark -

/**
 是否包含Emoji
 
 @return YES/NO
 */
- (BOOL)st_isIncludingEmoji;

/**
 移除Emoji
 
 @return YES/NO
 */
- (instancetype)st_stringByRemovingEmoji;

#pragma mark -
#pragma mark String Function

-(NSString *)st_trimString;

-(NSString *)st_cleanSpace;

#pragma mark - 字符串的比较
/**
 *  是否包含字符串
 *
 *  @param string  查找
 *  @param options options
 *
 *  @return bool
 */
- (BOOL)st_containsString:(NSString *)string options:(NSStringCompareOptions)options;
/**
 *  是否包含字符串
 *
 *  @param string 查找
 *
 *  @return bool
 */
- (BOOL)st_containsString:(NSString *)string;

/**
 *  @brief 根据字数的不同,返回UILabel中的text文字需要占用多少Size
 *  @param size 约束的尺寸
 *  @param font 文本字体
 *  @return 文本的实际尺寸
 */
- (CGSize)st_textSizeWithContentSize:(CGSize)size font:(UIFont *)font;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param width 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际高度
 */
- (CGFloat)st_textHeightWithContentWidth:(CGFloat)width font:(UIFont *)font;

/**
 *  @brief  根据文本字数/文本宽度约束/文本字体 求得text的Size
 *  @param height 宽度约束
 *  @param font  文本字体
 *  @return 文本的实际长度
 */
- (CGFloat)st_textWidthWithContentHeight:(CGFloat)height font:(UIFont *)font;

/**
 *  int转string
 *  @param  i   int
 */
+ (NSString *)zl_intString:(NSInteger)i;

@end
