/*
 SpringsAndStroutsViewController.h
 Copyright (c) 2013 Andrea Bizzotto bizz84@gmail.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


#import "SpringsAndStroutsViewController.h"
#import "LayoutUtils.h"

static const int kNumLabels = 30;

@interface SpringsAndStroutsViewController ()
@property UIScrollView *scrollView;
@property int numLabels;
@end

@implementation SpringsAndStroutsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;

    // Create scroll view
    self.scrollView = [UIScrollView new];
    self.scrollView.backgroundColor = [UIColor yellowColor];
    // Set autoresizing mask to account for screen rotation
    self.scrollView.autoresizingMask =(UIViewAutoresizingFlexibleWidth |
                                  UIViewAutoresizingFlexibleHeight);
    [self.view addSubview:self.scrollView];
    
    
    [self createWithSpringsAndStrouts:self.scrollView numLabels:kNumLabels];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [LayoutUtils printClassAndFrameRecursive:self.view level:0];
    DLog(@"scroll view content size: %@", NSStringFromCGSize(self.scrollView.contentSize));
}

- (void)createWithSpringsAndStrouts:(UIScrollView *)scrollView numLabels:(int)numLabels {
    
    for (int i = 0; i < numLabels; i++) {
        UILabel* lab = [LayoutUtils createLabelWithIndex:i target:self tapSelector:@selector(labTapped:)];
        [scrollView addSubview:lab];
    }
    [self updateLayout:self.scrollView numLabels:numLabels];
}

- (void)adjustLabel:(UILabel *)label originY:(float)originY {
    // TODO: Fix this to work in multi-line mode
    [label sizeToFit];
    CGRect f = label.frame;
    f.origin = CGPointMake(10,originY);
    label.frame = f;
}

- (void)labTapped:(UIGestureRecognizer *)sender {
    
    UILabel *label = (UILabel *)sender.view;
    label.text = @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.";
    // content size needs to be recalculated each time
    [self updateLayout:self.scrollView numLabels:kNumLabels];
}

- (void)updateLayout:(UIScrollView *)scrollView numLabels:(int)numLabels {
    
    CGFloat y = 10;
    for (int i = 0; i < numLabels; i++) {
        UILabel* lab = [self.scrollView.subviews objectAtIndex:i];
        [self adjustLabel:lab originY:y];
        y += lab.bounds.size.height + 10;
    }
    CGSize sz = scrollView.bounds.size;
    sz.height = y;
    scrollView.contentSize = sz;
    scrollView.frame = self.view.frame;
}

@end