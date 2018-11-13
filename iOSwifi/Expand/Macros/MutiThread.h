//
//  MutiThread.h
//  iOSwifi
//
//  Created by Stone on 2018/11/12.
//  Copyright © 2018 Stone. All rights reserved.
//

#define doInGlobalQueueAfter(deleySeconds,task) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(deleySeconds * NSEC_PER_SEC)), dispatch_get_global_queue(0, 0), ^{\
@try \
task\
@catch (NSException *exception) {\
NSLog(@"doInGlobalQueueAfter:%s:%@",#task,exception);\
}\
@finally {} \
});\

#define doInMainQueueAfter(deleySeconds,task) dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(deleySeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
@try \
task\
@catch (NSException *exception) {\
NSLog(@"doInMainQueueAfter:%s:%@",#task,exception);\
}\
@finally {} \
});\

#define doAsynInMainQueue(task) dispatch_async(dispatch_get_main_queue(), ^{\
@try \
task\
@catch (NSException *exception) {\
NSLog(@"doAsynInMainQueueAfter:%s:%@",#task,exception);\
}\
@finally {} \
});

#define doAsynInGlobalQueue(task) dispatch_async(dispatch_get_global_queue(0, 0), ^{\
@try \
task\
@catch (NSException *exception) {\
NSLog(@"doAsynInGlobalQueue:%s:%@",#task,exception);\
}\
@finally {} \
});
