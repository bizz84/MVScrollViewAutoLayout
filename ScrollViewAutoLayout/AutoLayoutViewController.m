/*
 AutoLayoutViewController.m
 Copyright (c) 2013 Andrea Bizzotto bizz84@gmail.com
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */


#import "AutoLayoutViewController.h"
#import "LayoutUtils.h"

// This is a Masonry port of this tutorial:
// http://www.apeth.com/iOSBook/ch20.html

@interface AutoLayoutViewController ()
@property UIScrollView *scrollView;
@end

@implementation AutoLayoutViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)])
        self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Create scroll view
    self.scrollView = [UIScrollView new];
    self.scrollView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:self.scrollView];
    
    //[self createManually:self.scrollView];
    [self createWithAutoLayout:self.scrollView numLabels:30];
}

- (void)createWithAutoLayout:(UIScrollView *)scrollView numLabels:(int)numLabels {
    
    [scrollView makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    // Add header at beginning
    UILabel *header = [LayoutUtils fixedLabelWithText:@"UIScrollView with Auto-layout example"];
    [scrollView addSubview:header];

    // last one, pin to bottom and right, this dictates content size height
    [header makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollView.top).offset(30);
        make.left.equalTo(scrollView.left).offset(10);
        //make.right.equalTo(self.mainScrollView.right).offset(-10);// Doesn't work
        make.width.equalTo(scrollView.width).offset(-20);
        make.height.equalTo(@50);
    }];

    UILabel* previousLab = nil;
    for (int i = 0; i < numLabels; i++) {
        UILabel *lab = [LayoutUtils createLabelWithIndex:i target:self tapSelector:@selector(labTapped:)];
        [scrollView addSubview:lab];
        
        [lab makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(scrollView.left).offset(10);
            make.width.equalTo(scrollView.width).offset(-20);
            //make.right.equalTo(scrollView.right).offset(-10); // Doesn't work
        }];

        if (!previousLab) { // first one, pin to top
            [lab makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(header.bottom).offset(10);
            }];
        } else { // all others, pin to previous
            [lab makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(previousLab.bottom).offset(10);
            }];
        }
        previousLab = lab;
    }
    
    // Add footer at end
    UILabel *footer = [LayoutUtils fixedLabelWithText:@"This is the end"];
    [scrollView addSubview:footer];

    // last one, pin to bottom and right, this dictates content size height
    [footer makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(previousLab.bottom).offset(10);
        make.left.equalTo(scrollView.left).offset(10);
        //make.right.equalTo(self.mainScrollView.right).offset(-10);
        make.width.equalTo(scrollView.width).offset(-20);
        make.height.equalTo(@50);
        make.bottom.equalTo(scrollView.bottom).offset(-10);
    }];
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [LayoutUtils printClassAndFrameRecursive:self.view level:0];
    DLog(@"scroll view content size: %@", NSStringFromCGSize(self.scrollView.contentSize));
}

#pragma mark - event handlers

- (void)labTapped:(UIGestureRecognizer *)sender {
    
    UILabel *label = (UILabel *)sender.view;
    label.text = @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.";
}



@end
