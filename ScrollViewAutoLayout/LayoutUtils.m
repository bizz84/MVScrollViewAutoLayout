//
//  LayoutUtils.m
//  ScrollViewAutoLayout
//
//  Created by Andrea Bizzotto on 03/10/2013.
//  Copyright (c) 2013 Snupps. All rights reserved.
//

#import "LayoutUtils.h"

@implementation LayoutUtils

+ (UILabel *)createLabelWithIndex:(int)index target:(id)target tapSelector:(SEL)selector {
    UILabel* lab = [UILabel new];
    lab.translatesAutoresizingMaskIntoConstraints = NO;
    lab.text = [NSString stringWithFormat:@"This is label %i", index+1];
    lab.backgroundColor = [UIColor redColor];
    
    // Configure the label so that it increases it's size when tapped
    lab.numberOfLines = 0;
    lab.lineBreakMode = NSLineBreakByWordWrapping;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [lab addGestureRecognizer:tap];
    lab.userInteractionEnabled = YES;
    
    return lab;
}

+ (UILabel *)fixedLabelWithText:(NSString *)text {
    
    UILabel *label = [UILabel new];
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.backgroundColor = [UIColor greenColor];
    label.text = text;
    return label;
}

#pragma mark - utility methods

+ (void)printClassAndFrameRecursive:(UIView *)view level:(int)level {
    
    NSMutableString *prefix = [NSMutableString new];
    for (int i = 0; i < level; i++)
        [prefix appendString:@"-"];
    
    NSLog(@"%@> Class: %@, frame: %@", prefix, [[view class] description], NSStringFromCGRect(view.frame));
    for (UIView *sv in view.subviews) {
        [self printClassAndFrameRecursive:sv level:level + 1];
    }
}
@end
