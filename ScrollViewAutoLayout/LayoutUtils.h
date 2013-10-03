//
//  LayoutUtils.h
//  ScrollViewAutoLayout
//
//  Created by Andrea Bizzotto on 03/10/2013.
//  Copyright (c) 2013 Snupps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LayoutUtils : NSObject

+ (UILabel *)createLabelWithIndex:(int)index target:(id)target tapSelector:(SEL)selector;
+ (UILabel *)fixedLabelWithText:(NSString *)text;
+ (void)printClassAndFrameRecursive:(UIView *)view level:(int)level;

@end
