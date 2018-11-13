//
//  SystemInfoTool.m
//  iOSwifi
//
//  Created by Stone on 2018/11/13.
//  Copyright © 2018 Stone. All rights reserved.
//

#import "SystemInfoTool.h"
#import <mach/mach.h>
#import <sys/param.h>
#import <sys/mount.h>
#import <sys/utsname.h>

@implementation SystemInfoTool

+ (CGFloat)cpuFree
{
    CGFloat cpuUsage = [self cpuUsagePercent] * 100;
    return 100 - cpuUsage;
}

+ (CGFloat)cpuUsagePercent
{
    kern_return_t kern;
    
    thread_array_t threadList;
    mach_msg_type_number_t threadCount;
    
    thread_info_data_t threadInfo;
    mach_msg_type_number_t threadInfoCount;
    
    thread_basic_info_t threadBasicInfo;
    uint32_t threadStatistic = 0;
    
    kern = task_threads(mach_task_self(), &threadList, &threadCount);
    if (kern != KERN_SUCCESS) {
        return -1;
    }
    if (threadCount > 0) {
        threadStatistic += threadCount;
    }
    
    float totalUsageOfCPU = 0;
    
    for (int i = 0; i < threadCount; i++) {
        threadInfoCount = THREAD_INFO_MAX;
        kern = thread_info(threadList[i], THREAD_BASIC_INFO, (thread_info_t)threadInfo, &threadInfoCount);
        if (kern != KERN_SUCCESS) {
            return -1;
        }
        
        threadBasicInfo = (thread_basic_info_t)threadInfo;
        
        if (!(threadBasicInfo -> flags & TH_FLAGS_IDLE)) {
            totalUsageOfCPU = totalUsageOfCPU + threadBasicInfo -> cpu_usage / (float)TH_USAGE_SCALE * 100.0f;
        }
    }
    
    kern = vm_deallocate(mach_task_self(), (vm_offset_t)threadList, threadCount * sizeof(thread_t));
    
    return totalUsageOfCPU / 100;
}

+ (CGFloat)memoryFree
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return 0;
    }
    
    float usageMemory = vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count;
    float totalMemory = [NSProcessInfo processInfo].physicalMemory;
    return (totalMemory - usageMemory) / 1024 / 1024;
}

+ (CGFloat)memoryTotal
{
    return [NSProcessInfo processInfo].physicalMemory / 1024 / 1024;
}

+ (CGFloat)memoryUsagePercent
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return 0;
    }
    
    float usageMemory = vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count;
    float totalMemory = [NSProcessInfo processInfo].physicalMemory;
    
    return usageMemory / totalMemory;
}

+ (CGFloat)diskFree
{
    struct statfs buf;
    CGFloat freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (buf.f_bsize * buf.f_bavail) / 1024 / 1024.0;
    }
    
    return freeSpace;
}

+ (CGFloat)diskTotal
{
    struct statfs buf;
    CGFloat totalSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        totalSpace = (buf.f_bsize * buf.f_blocks) / 1024 / 1024 / 1024.0;
    }
    
    return totalSpace;
}

+ (CGFloat)diskUsagePercent
{
    struct statfs buf;
    CGFloat totalSpace = -1;
    CGFloat freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        totalSpace = (buf.f_bsize * buf.f_blocks) / 1024 / 1024.0;
        freeSpace = (buf.f_bsize * buf.f_bavail) / 1024 / 1024.0;
    }
    
    return (totalSpace - freeSpace) / totalSpace;
}

+ (NSString *)deviceModel
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString * deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    //iPhone
    if ([deviceString isEqualToString:@"iPhone1,1"])    return @"iPhone 1";
    if ([deviceString isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([deviceString isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([deviceString isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"])    return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,3"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone5,4"])    return @"iPhone 5C";
    if ([deviceString isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([deviceString isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"])    return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"])    return @"iPhone SE";
    if ([deviceString isEqualToString:@"iPhone9,1"])    return @"iPhone 7 (CDMA)";
    if ([deviceString isEqualToString:@"iPhone9,3"])    return @"iPhone 7 (GSM)";
    if ([deviceString isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus (CDMA)";
    if ([deviceString isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus (GSM)";
    if ([deviceString isEqualToString:@"iPhone10,1"])   return @"iPhone 8 (CDMA)";
    if ([deviceString isEqualToString:@"iPhone10,4"])   return @"iPhone 8 (GSM)";
    if ([deviceString isEqualToString:@"iPhone10,2"])   return @"iPhone 8 Plus (CDMA)";
    if ([deviceString isEqualToString:@"iPhone10,5"])   return @"iPhone 8 Plus (GSM)";
    if ([deviceString isEqualToString:@"iPhone10,3"])   return @"iPhone X (CDMA)";
    if ([deviceString isEqualToString:@"iPhone10,6"])   return @"iPhone X (GSM)";
    
    //iPad 1
    if ([deviceString isEqualToString:@"iPad1,1"])    return @"iPad 1";
    
    //iPad 2
    if ([deviceString isEqualToString:@"iPad2,1"])    return @"iPad 2 - Wifi";
    if ([deviceString isEqualToString:@"iPad2,2"])    return @"iPad 2 - GSM";
    if ([deviceString isEqualToString:@"iPad2,3"])    return @"iPad 2 - 3G";
    if ([deviceString isEqualToString:@"iPad2,4"])    return @"iPad 2 - Wifi";
    
    //iPad Mini
    if ([deviceString isEqualToString:@"iPad2,5"])    return @"iPad Mini - Wifi";
    if ([deviceString isEqualToString:@"iPad2,6"])    return @"iPad Mini - Wifi + Cellular";
    if ([deviceString isEqualToString:@"iPad2,7"])    return @"iPad Mini - Wifi + Cellular";
    
    //iPad 3
    if ([deviceString isEqualToString:@"iPad3,1"])    return @"iPad 3 - Wifi";
    if ([deviceString isEqualToString:@"iPad3,2"])    return @"iPad 3 - Wifi + Cellular";
    if ([deviceString isEqualToString:@"iPad3,3"])    return @"iPad 3 - Wifi + Cellular";
    
    //iPad 4
    if ([deviceString isEqualToString:@"iPad3,4"])    return @"iPad 4 - Wifi";
    if ([deviceString isEqualToString:@"iPad3,5"])    return @"iPad 4 - Wifi + Cellular";
    if ([deviceString isEqualToString:@"iPad3,6"])    return @"iPad 4 - Wifi + Cellular";
    
    //iPad Air
    if ([deviceString isEqualToString:@"iPad4,1"])    return @"iPad Air - Wifi";
    if ([deviceString isEqualToString:@"iPad4,2"])    return @"iPad Air - Wifi + Cellular";
    if ([deviceString isEqualToString:@"iPad4,3"])    return @"iPad Air - Wifi + Cellular";
    
    //iPad Mini 2
    if ([deviceString isEqualToString:@"iPad4,4"])    return @"iPad Mini 2 - Wifi";
    if ([deviceString isEqualToString:@"iPad4,5"])    return @"iPad Mini 2 - Wifi + Cellular";
    if ([deviceString isEqualToString:@"iPad4,6"])    return @"iPad Mini 2 - Wifi + Cellular";
    
    //iPad Mini 3
    if ([deviceString isEqualToString:@"iPad4,7"])    return @"iPad Mini 3 - Wifi";
    if ([deviceString isEqualToString:@"iPad4,8"])    return @"iPad Mini 3 - Wifi + Cellular";
    if ([deviceString isEqualToString:@"iPad4,9"])    return @"iPad Mini 3 - Wifi + Cellular";
    
    //iPad Mini 4
    if ([deviceString isEqualToString:@"iPad5,1"])    return @"iPad Mini 4 - Wifi";
    if ([deviceString isEqualToString:@"iPad5,2"])    return @"iPad Mini 4 - Wifi + Cellular";
    
    //iPad Air 2
    if ([deviceString isEqualToString:@"iPad5,3"])    return @"iPad Air 2 - Wifi";
    if ([deviceString isEqualToString:@"iPad5,4"])    return @"iPad Air 2 - Wifi + Cellular";
    
    //iPad Pro 12.9 inch
    if ([deviceString isEqualToString:@"iPad6,3"])    return @"iPad Pro - Wifi";
    if ([deviceString isEqualToString:@"iPad6,4"])    return @"iPad Pro - Wifi + Cellular";
    if ([deviceString isEqualToString:@"iPad6,5"])    return @"iPad Pro - Wifi + Cellular";
    
    //iPad Pro 9.7 inch
    if ([deviceString isEqualToString:@"iPad6,7"])    return @"iPad Pro - Wifi";
    if ([deviceString isEqualToString:@"iPad6,8"])    return @"iPad Pro - Wifi + Cellular";
    
    //iPod Touch
    if ([deviceString isEqualToString:@"iPod1,1"])    return @"iPod Touch";
    if ([deviceString isEqualToString:@"iPod2,1"])    return @"iPod Touch 2th Generation";
    if ([deviceString isEqualToString:@"iPod3,1"])    return @"iPod Touch 3th Generation";
    if ([deviceString isEqualToString:@"iPod4,1"])    return @"iPod Touch 4th Generation";
    if ([deviceString isEqualToString:@"iPod7,1"])    return @"iPod Touch 6th Generation";
    
    return deviceString;
}

@end
