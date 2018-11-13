//
//  Singleton.h
//  iOSwifi
//
//  Created by Stone on 2018/11/12.
//  Copyright © 2018 Stone. All rights reserved.
//

#undef    AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;

#undef    DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

#undef    DEF_SINGLETON_INIT
#define DEF_SINGLETON_INIT( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] _init]; } ); \
return __singleton__; \
}
