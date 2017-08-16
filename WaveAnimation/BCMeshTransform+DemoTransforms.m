//
//  BCMutableMeshTransform+DemoTransforms.m
//  BCMeshTransformView
//
//  Copyright (c) 2014 Bartosz Ciechanowski. All rights reserved.
//

#import "BCMeshTransform+DemoTransforms.h"
#import "BCMutableMeshTransform+Convenience.h"

@implementation BCMeshTransform (DemoTransforms)


+ (instancetype)curtainMeshTransformAtPoint:(CGPoint)point boundsSize:(CGSize)boundsSize
{
  
    
    BCMutableMeshTransform *transform = [BCMutableMeshTransform identityMeshTransformWithNumberOfRows:50 numberOfColumns:20];
    
    CGPoint np = CGPointMake(point.x/boundsSize.width, point.y/boundsSize.height);
    
    [transform mapVerticesUsingBlock:^BCMeshVertex(BCMeshVertex vertex, NSUInteger vertexIndex) {

        
     //   vertex.to.z =  0.8 - 0.6* pow(atan(pow((vertex.to.y+10*np.y), 10)),0.637);
        vertex.to.z =  0.4 - 0.3* pow(atan(pow((vertex.to.y+10*np.y), 10)),0.637);

        return vertex;
    }];
    
    return transform;
}




@end
