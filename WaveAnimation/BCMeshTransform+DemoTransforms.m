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
 
         vertex.to.z =  0.3+ sin (-0.3*cos((0.4*0.37*0.2*M_PI)*pow((pow(pow(vertex.to.y+1.15-3*np.y,2), 0.8)-3*0.8), 4)));

        return vertex;
    }];
    
    return transform;
}




@end
