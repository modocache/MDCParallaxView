//  ImageViewController.m
//
//  Copyright (c) 2012, 2014 to present, Brian Gesiak @modocache
//
//  Permission is hereby granted, free of charge, to any person obtaining
//  a copy of this software and associated documentation files (the
//  "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish,
//  distribute, sublicense, and/or sell copies of the Software, and to
//  permit persons to whom the Software is furnished to do so, subject to
//  the following conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
//  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
//  LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
//  OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
//  WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
//


#import "ImageViewController.h"
#import "MDCParallaxView.h"


@interface ImageViewController () <UIScrollViewDelegate>

@end


@implementation ImageViewController


#pragma mark - UIViewController Overrides

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImage *backgroundImage = [UIImage imageNamed:@"background.png"];
    CGRect backgroundRect = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), backgroundImage.size.height);
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:backgroundRect];
    backgroundImageView.image = backgroundImage;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    UITapGestureRecognizer *tapGesture =
        [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [backgroundImageView addGestureRecognizer:tapGesture];

    CGRect textRect = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 400.0f);
    UITextView *textView = [[UITextView alloc] initWithFrame:textRect];
    textView.text = NSLocalizedString(@"Permission is hereby granted, free of charge, to any "
                                      @"person obtaining a copy of this software and associated "
                                      @"documentation files (the \"Software\"), to deal in the "
                                      @"Software without restriction, including without limitation "
                                      @"the rights to use, copy, modify, merge, publish, "
                                      @"distribute, sublicense, and/or sell copies of the "
                                      @"Software, and to permit persons to whom the Software is "
                                      @"furnished to do so, subject to the following "
                                      @"conditions...\"", nil);
    textView.textAlignment = NSTextAlignmentCenter;
    textView.font = [UIFont systemFontOfSize:14.0f];
    textView.textColor = [UIColor darkTextColor];
    textView.scrollsToTop = NO;
    textView.editable = NO;

    MDCParallaxView *parallaxView = [[MDCParallaxView alloc] initWithBackgroundView:backgroundImageView
                                                                     foregroundView:textView];
    parallaxView.frame = self.view.bounds;
    parallaxView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    parallaxView.backgroundHeight = 250.0f;
    parallaxView.scrollView.scrollsToTop = YES;
    parallaxView.backgroundInteractionEnabled = YES;
    parallaxView.scrollViewDelegate = self;
    [self.view addSubview:parallaxView];
}


#pragma mark - UIScrollViewDelegate Protocol Methods

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"%@:%@", [self class], NSStringFromSelector(_cmd));
}


#pragma mark - Internal Methods

- (void)handleTap:(UIGestureRecognizer *)gesture {
    NSLog(@"%@:%@", [self class], NSStringFromSelector(_cmd));
}

@end
