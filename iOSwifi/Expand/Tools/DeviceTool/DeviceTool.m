//
//  DeviceTool.m
//  iOSwifi
//
//  Created by Stone on 2018/11/15.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "DeviceTool.h"
#import <CoreTelephony/CTCarrier.h>
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <sys/sysctl.h>
#import "OpenUDID.h"
#import "Reachability.h"
#import "NetworkManager.h"

#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/sockio.h>
#import <sys/ioctl.h>

#include <sys/socket.h> // Per msqr
#include <sys/sysctl.h>
#include <net/if.h>
#include <net/if_dl.h>


#define IOS_CELLULAR    @"pdp_ip0"
#define IOS_WIFI        @"en0"
//#define IOS_VPN       @"utun0"
#define IP_ADDR_IPv4    @"ipv4"
#define IP_ADDR_IPv6    @"ipv6"

@implementation DeviceTool

///获取设备IDFV
+ (NSString *)deviceIdfv{
    return  [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

//获取设备IDFA
+ (NSString *)deviceIdfa
{
    return [self getUnchangedIdfa];
}

+ (NSString *)getCarrierName
{
    CTTelephonyNetworkInfo *telephonyInfo = [[CTTelephonyNetworkInfo alloc] init];
    
    NSString *str = @"";
    
    if ([telephonyInfo respondsToSelector:@selector(subscriberCellularProvider)]) {
        CTCarrier *carrier = [telephonyInfo subscriberCellularProvider];
        NSString *currentCountry = [carrier carrierName];
        if (currentCountry) {
            str = currentCountry;
        }
    }
    
    return str;
}

+ (NSString *)getTelephonyNetworkType
{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc]init];
    return [self getTelephonyNetworkTypeWithCTRadioAccessTechnology:info.currentRadioAccessTechnology];
}

+ (NSString *)getTelephonyNetworkTypeWithCTRadioAccessTechnology:(NSString *)currentStatus
{
    if ([currentStatus isEqualToString:CTRadioAccessTechnologyGPRS]) {
        //GPRS网络
        return @"GPRS";
    }
    
    if ([currentStatus isEqualToString:CTRadioAccessTechnologyEdge]) {
        //2.75G的EDGE网络
        return @"2G";
    }
    
    if ([currentStatus isEqualToString:CTRadioAccessTechnologyWCDMA]) {
        //3G WCDMA网络
        return @"3G";
    }
    
    if ([currentStatus isEqualToString:CTRadioAccessTechnologyHSDPA]) {
        //3.5G网络
        return @"3G";
    }
    
    if ([currentStatus isEqualToString:CTRadioAccessTechnologyHSUPA]) {
        //3.5G网络
        return @"3G";
    }
    
    if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMA1x]) {
        //CDMA2G网络
        return @"2G";
    }
    
    if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORev0]) {
        //CDMA的EVDORev0(应该算3G吧?)
        return @"3G";
    }
    
    if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevA]) {
        //CDMA的EVDORevA(应该也算3G吧?)
        return @"3G";
    }
    
    if ([currentStatus isEqualToString:CTRadioAccessTechnologyCDMAEVDORevB]) {
        //CDMA的EVDORev0(应该还是算3G吧?)
        return @"3G";
    }
    
    if ([currentStatus isEqualToString:CTRadioAccessTechnologyeHRPD]) {
        //HRPD网络
        return @"HRPD";
    }
    
    if ([currentStatus isEqualToString:CTRadioAccessTechnologyLTE]) {
        //LTE4G网络
        return @"4G";
    }
    return @"4G";
}

//是否设备中有SIM卡
+ (BOOL)hasSIMCard
{
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    
    if (!carrier.isoCountryCode) {
        return NO;
    }
    return YES;
}

+ (NSString *)getDeviceVersion
{
    size_t size;
    
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = (char *)malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}

+ (NSString *)platformString
{
    NSString *platform = [self getDeviceVersion];
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"Verizon iPhone 4";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6+";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6S";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6S+";
    if ([platform isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7+";
    if ([platform isEqualToString:@"iPhone10,1"])    return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
    if ([platform isEqualToString:@"iPhone10,2"])    return @"iPhone 8+";
    if ([platform isEqualToString:@"iPhone10,5"])    return @"iPhone 8+";
    if ([platform isEqualToString:@"iPhone10,3"])    return @"iPhone X";
    if ([platform isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPod7,1"])      return @"iPod Touch 6G";
    
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 (GSM)";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 (CDMA)";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 (WiFi)";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini (WiFi)";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (GSM)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 (WiFi)";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 (GSM)";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 (WiFi)";
    if ([platform isEqualToString:@"iPad3,5"])      return @"iPad 4 (GSM)";
    if ([platform isEqualToString:@"iPad3,6"])      return @"iPad 4 (GSM+CDMA)";
    if ([platform isEqualToString:@"iPad4,1"])      return @"iPad Air (WiFi)";
    if ([platform isEqualToString:@"iPad4,2"])      return @"iPad Air (Cellular)";
    if ([platform isEqualToString:@"iPad4,3"])      return @"iPad Air";
    if ([platform isEqualToString:@"iPad4,4"])      return @"iPad Mini 2G (WiFi)";
    if ([platform isEqualToString:@"iPad4,5"])      return @"iPad Mini 2G (Cellular)";
    if ([platform isEqualToString:@"iPad4,6"])      return @"iPad Mini 2G";
    if ([platform isEqualToString:@"iPad4,7"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,8"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad4,9"])      return @"iPad Mini 3";
    if ([platform isEqualToString:@"iPad5,1"])      return @"iPad Mini 4";
    if ([platform isEqualToString:@"iPad5,2"])      return @"iPad Mini 4";
    if ([platform isEqualToString:@"iPad5,3"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad5,4"])      return @"iPad Air 2";
    if ([platform isEqualToString:@"iPad6,7"])      return @"iPad Pro (12.9 inch)";
    if ([platform isEqualToString:@"iPad6,8"])      return @"iPad Pro (12.9 inch)";
    if ([platform isEqualToString:@"iPad6,3"])      return @"iPad Pro (9.7 inch)";
    if ([platform isEqualToString:@"iPad6,4"])      return @"iPad Pro (9.7 inch)";
    if ([platform isEqualToString:@"iPad6,11"])      return @"iPad(2017)";
    if ([platform isEqualToString:@"iPad6,12"])      return @"iPad(2017)";
    if ([platform isEqualToString:@"iPad7,1"])      return @"iPad Pro 2(12.9-inch)";
    if ([platform isEqualToString:@"iPad7,2"])      return @"iPad Pro 2(12.9-inch)";
    if ([platform isEqualToString:@"iPad7,3"])      return @"iPad Pro (10.5-inch)";
    if ([platform isEqualToString:@"iPad7,4"])      return @"iPad Pro (10.5-inch)";
    
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    return platform;
}

//获取keyChain中的不变设备id
+ (NSString *)getUnchangedIdfa
{
    NSString *deviceIdfa = [UICKeyChainStore keyChainStore][@"ST_DeviceIDFA"];
    
    if (deviceIdfa.length > 0 && ![deviceIdfa hasPrefix:@"000000"]) {
        return deviceIdfa;
    }
    
    deviceIdfa = [self originIdfa];
    deviceIdfa = [deviceIdfa stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if ([deviceIdfa rangeOfString:@"000000"].location != NSNotFound) {
        deviceIdfa = [[OpenUDID value] uppercaseString];
    }
    [UICKeyChainStore keyChainStore][@"ST_DeviceIDFA"] = deviceIdfa;
    
    return deviceIdfa;
}


/**
 *  统一获取IDFA
 *
 */
+ (NSString *)getUnchangedOriginIdfa {
    
    //优先从keychain中获取
    NSString *deviceIdfa = [UICKeyChainStore keyChainStore][@"ST_DeviceOriginIDFA"];
    
    //判断非空及兼容之前iOS10可能保存到000000000的情况
    if (deviceIdfa.length > 0 && ![deviceIdfa hasPrefix:@"000000"]) {
        return deviceIdfa;
    }
    
    //重新获取IDFA, 如果系统有限制跟踪, 则取到的都为0000000
    deviceIdfa = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    //如果为空, 取OPUDID
    if ([deviceIdfa rangeOfString:@"000000"].location != NSNotFound) {
        //格式化, 统一32位
        deviceIdfa = [[[OpenUDID value] uppercaseString] substringWithRange:NSMakeRange(0, 32)];
    }
    
    //保存到Keychain
    [UICKeyChainStore keyChainStore][@"ST_DeviceOriginIDFA"] = deviceIdfa;
    
    return deviceIdfa;
}


+ (NSString *)originIdfa {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}

+ (CTCarrier *)getCurrentCarrier {
    CTTelephonyNetworkInfo *networkInfo = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = [networkInfo subscriberCellularProvider];
    return carrier;
}

+ (NSString *)getDeviceDiskSize {
    NSDirectoryEnumerator *systemEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:NSHomeDirectory()];
    NSDictionary *systemAttributes = [systemEnumerator fileAttributes];
    NSString *diskTotalSize = [systemAttributes objectForKey:NSFileSystemSize];
    return diskTotalSize;
}

+ (NSString *)getCurrentLanguage
{
    if (@available(iOS 10.0, *)) {
        return [[NSLocale currentLocale] languageCode];
    } else {
        NSArray *languages = [NSLocale preferredLanguages];
        return [languages objectAtIndex:0];
    };
}

+ (NSString *)getCurrentRegion {
    if (@available(iOS 10.0, *)) {
        return [[NSLocale currentLocale] countryCode];
    } else {
        return [[NSLocale currentLocale] objectForKey:NSLocaleCountryCode];
    };
}

+ (NSDictionary *)ipInfo {
    NSURL *ipURL = [NSURL URLWithString:@"http://ip.taobao.com/service/getIpInfo.php?ip=myip"];
    NSData *data = [NSData dataWithContentsOfURL:ipURL];
    if (data.length) {
        NSDictionary *ipDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return ipDic;
    }
    return nil;
}

+ (NSString *)deviceWANIPAddress {
    NSDictionary *ipInfo = [self ipInfo];
    NSString *ipStr = nil;
    if (ipInfo && [ipInfo[@"code"] integerValue] == 0) { //获取成功
        ipStr = ipInfo[@"data"][@"ip"];
    }
    return (ipStr ? ipStr : @"");
}

+ (NSDictionary *)ipLocationInfo {
    NSURL *ipURL = [NSURL URLWithString:@"http://restapi.amap.com/v3/ip?key=c0d494c0dd2bcd285aa91cf0dd712783"];
    NSData *data = [NSData dataWithContentsOfURL:ipURL];
    if (data.length) {
        NSDictionary *ipDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        return ipDic;
    }
    return nil;
}

+ (NSString *)ipLocation {
    NSDictionary *ipLocationInfo = [self ipLocationInfo];
    NSString *location = @"";
    if (ipLocationInfo && [ipLocationInfo[@"status"] integerValue] == 1) { //获取成功
        NSString *provice = ipLocationInfo[@"province"];
        NSString *city = ipLocationInfo[@"city"];
        
        if(provice.length > 0 ) {
            location = [location stringByAppendingString:provice];
        }
        
        if (city.length > 0) {
            location = [location stringByAppendingString:city];
        }
    }
    return location;
    
}


+ (NSString *) getMacaddress
{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1/n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!/n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02x:%02x:%02x:%02x:%02x:%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    //    NSString *outstring = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x", *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    
    NSLog(@"outString:%@", outstring);
    
    free(buf);
    
    return [outstring uppercaseString];
}


@end

