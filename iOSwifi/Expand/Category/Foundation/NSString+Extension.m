//
//  NSString+Extension.m
//  iOSwifi
//
//  Created by Stone on 2018/11/10.
//  Copyright © 2018 Stone. All rights reserved.
//

//#import "NSString+ZLExtensions.h"

#import <CommonCrypto/CommonDigest.h>

//#import "NSString+ZLRegularExpression.h"

@implementation NSString (Extension)

#pragma mark -
#pragma mark - MD5

- (NSString *)st_stringFromMD5 {
    if (self == nil || [self length] == 0)
        return nil;
    
    const char *value = [self UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++) {
        [outputString appendFormat:@"%02x", outputBuffer[count]];
    }
    
    return outputString;
}

- (NSString *)st_md5HexDigest {
    const char    *original_str = [self UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 16; i++) {
        [hash appendFormat:@"%02X", result[i]];
    }
    return [hash uppercaseString];
}

+ (NSString *)st_md5:(NSString *)str {
    const char    *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark -
#pragma mark - Char

- (BOOL)st_myContainsString:(NSString *)other {
    if (self == nil) {
        return NO;
    }
    if (![other st_isNotEmptyOrNil]) {
        return NO;
    }
    NSRange range = [self rangeOfString:other];
    return range.length != 0;
}

/**
 *  字符串 不 为空字符或者为nil
 *
 *  @return bool
 */
- (BOOL)st_isNotEmptyOrNil {
    if (self == nil) {
        return NO;
    }
    return self.length > 0 ? YES : NO;
}

- (BOOL)st_hasHttpSceme {
    return [self hasPrefix:@"http:"] || [self hasPrefix:@"https:"];
}

#pragma mark -
#pragma mark - Unicode

+ (NSString *)st_stringConvertUnicode:(NSString *)str {
    NSData *data        = [str dataUsingEncoding:NSUnicodeStringEncoding];
    char   *unicodeChar = (char *)[data bytes];
    //1.跳过unicode前面的FF-FE两个字节。
    unicodeChar += 2;
    [self convertToBigEndian:unicodeChar Length:data.length-2];
    return [self httpUrlEncode:unicodeChar Length:data.length-2];
}

+ (void)convertToBigEndian:(char *)src Length:(int)len {
    if (len%2 != 0) {
        return;
    }
    char tmp;
    for (int i = 0; i < len; i += 2) {
        tmp      = src [i];
        src[i]   = src[i+1];
        src[i+1] = tmp;
    }
}

+ (NSString *)httpUrlEncode:(char *)srcUrl Length:(int)len {
    
    if (len == 0) {
        return @"";
    }
    NSString *buf = @"";
    for (int i = 0; i < len; i++) {
        char oneChar = srcUrl[i];
        buf = [buf stringByAppendingString:[self urlEncodeFormat:oneChar]];
        if (i != len-1) {
            buf = [buf stringByAppendingString:@","];
        }
    }
    
    return buf;
}

+ (NSString *)urlEncodeFormat:(u_char)cValue {
    NSString *buf = @"";
    
    uint nDiv = cValue/16;
    uint nMod = cValue%16;
    
    buf = [buf stringByAppendingString:[self decimalToHexString:nDiv]];
    buf = [buf stringByAppendingString:[self decimalToHexString:nMod]];
    return buf;
}

+ (NSString *)decimalToHexString:(u_char)nValue {
    NSString *tmp = @"";
    switch (nValue) {
        case 0: tmp  = @"0"; break;
        case 1: tmp  = @"1"; break;
        case 2: tmp  = @"2"; break;
        case 3: tmp  = @"3"; break;
        case 4: tmp  = @"4"; break;
        case 5: tmp  = @"5"; break;
        case 6: tmp  = @"6"; break;
        case 7: tmp  = @"7"; break;
        case 8: tmp  = @"8"; break;
        case 9: tmp  = @"9"; break;
        case 10: tmp = @"A"; break;
        case 11: tmp = @"B"; break;
        case 12: tmp = @"C"; break;
        case 13: tmp = @"D"; break;
        case 14: tmp = @"E"; break;
        case 15: tmp = @"F"; break;
        default: tmp = @"X";
            break;
    }
    return tmp;
}

+ (NSString *)st_urlencodeString:(NSString *)str {
    NSString       *charactersToEscape = @"?!@#$^&%*~_+-,:.;='\"`<>()[]{}/\\| ";
    NSCharacterSet *allowedCharacters  = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
    return [str stringByAddingPercentEncodingWithAllowedCharacters:allowedCharacters];
}

#pragma mark - Remove Emoji

- (BOOL)isEmoji {
    const unichar high = [self characterAtIndex:0];
    
    // Surrogate pair (U+1D000-1F77F)
    if (0xD800 <= high && high <= 0xDBFF) {
        const unichar low       = [self characterAtIndex:1];
        const int     codepoint = ((high - 0xD800) * 0x400) + (low - 0xDC00) + 0x10000;
        
        return (0x1D000 <= codepoint && codepoint <= 0x1F9FF);
        
        // Not surrogate pair (U+2100-27BF)
    } else {
        return (0x2100 <= high && high <= 0x27BF);
    }
}

- (BOOL)st_isIncludingEmoji {
    BOOL __block result = NO;
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              if ([substring isEmoji]) {
                                  *stop = YES;
                                  result = YES;
                              }
                          }];
    
    return result;
}

- (instancetype)st_stringByRemovingEmoji {
    NSMutableString *__block buffer = [NSMutableString stringWithCapacity:[self length]];
    
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              [buffer appendString:([substring isEmoji]) ? @"" : substring];
                          }];
    
    return buffer;
}

#pragma mark -
#pragma mark String Function
- (NSString *)st_trimString {
    NSString *cleanString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return cleanString;
}

- (NSString *)st_cleanSpace {
    NSString       *result         = @"";
    NSCharacterSet *whitespaces    = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSPredicate    *noEmptyStrings = [NSPredicate predicateWithFormat:@"SELF != ''"];
    
    NSArray *parts         = [self componentsSeparatedByCharactersInSet:whitespaces];
    NSArray *filteredArray = [parts filteredArrayUsingPredicate:noEmptyStrings];
    result = [filteredArray componentsJoinedByString:@""];
    return result;
}

- (BOOL)st_containsString:(NSString *)string
                  options:(NSStringCompareOptions)options {
    NSRange rng = [self rangeOfString:string options:options];
    return rng.location != NSNotFound;
}

- (BOOL)st_containsString:(NSString *)string {
    return [self st_containsString:string options:0];
}

- (CGSize)st_textSizeWithContentSize:(CGSize)size font:(UIFont *)font {
    return [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : font} context:nil].size;
}

- (CGFloat)st_textHeightWithContentWidth:(CGFloat)width font:(UIFont *)font {
    CGSize size = CGSizeMake(width, MAXFLOAT);
    return ceilf([self st_textSizeWithContentSize:size font:font].height);
}

- (CGFloat)st_textWidthWithContentHeight:(CGFloat)height font:(UIFont *)font {
    CGSize size = CGSizeMake(MAXFLOAT, height);
    return ceilf([self st_textSizeWithContentSize:size font:font].width);
}

+ (NSString *)st_intString:(NSInteger)i {
    return [NSString stringWithFormat:@"%ld", (long)i];
}

@end

