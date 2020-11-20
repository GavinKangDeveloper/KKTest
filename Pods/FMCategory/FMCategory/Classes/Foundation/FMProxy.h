//
//  FMProxy.h
//  YiShou
//
//  Created by yaojunren on 2019/11/1.
//  Copyright © 2019 FuMi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMProxy : NSProxy
@property (weak, nonatomic, readonly) id target;
- (instancetype)initWithWeakObject:(id)object;
@end

NS_ASSUME_NONNULL_END
