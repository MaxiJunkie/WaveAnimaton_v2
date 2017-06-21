//
//  BCMeshTransformAnimation.h
//  BCMeshTransformView
//
//  Copyright (c) 2014 Bartosz Ciechanowski. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BCMeshTransform.h"
#import "BCMeshTransform+Interpolation.h"
//#import "quarzcode"

@class BCMeshTransform;
@interface BCMeshTransformAnimation : NSObject

@property (nonatomic, strong, readonly) BCMeshTransform *currentMeshTransform;
@property (nonatomic, readonly, getter=isCompleted) BOOL completed;

- (instancetype)initWithAnimation:(CAAnimation *)animation
                 currentTransform:(BCMeshTransform *)currentTransform
             destinationTransform:(BCMeshTransform *)destinationTransform;

- (void)tick:(NSTimeInterval)dt;


@end
