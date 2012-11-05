//  MDCParallaxView.m
//
//  Copyright (c) 2012 modocache
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


#import "MDCParallaxView.h"


static CGFloat const kMDCParallaxViewDefaultHeight = 150.0f;


@interface MDCParallaxView () <UIScrollViewDelegate>
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *foregroundView;
@property (nonatomic, strong) UIScrollView *backgroundScrollView;
@property (nonatomic, strong) UIScrollView *foregroundScrollView;
- (void)updateBackgroundFrame;
- (void)updateForegroundFrame;
- (void)updateContentOffset;
@end


@implementation MDCParallaxView


#pragma mark - Object Lifecycle

- (id)initWithBackgroundView:(UIView *)backgroundView foregroundView:(UIView *)foregroundView {
    self = [super init];
    if (self) {
        _backgroundHeight = kMDCParallaxViewDefaultHeight;
        _backgroundView = backgroundView;
        _foregroundView = foregroundView;

        _backgroundScrollView = [UIScrollView new];
        _backgroundScrollView.backgroundColor = [UIColor clearColor];
        _backgroundScrollView.showsHorizontalScrollIndicator = NO;
        _backgroundScrollView.showsVerticalScrollIndicator = NO;
        [_backgroundScrollView addSubview:_backgroundView];
        [self addSubview:_backgroundScrollView];

        _foregroundScrollView = [UIScrollView new];
        _foregroundScrollView.backgroundColor = [UIColor clearColor];
        _foregroundScrollView.delegate = self;
        [_foregroundScrollView addSubview:_foregroundView];
        [self addSubview:_foregroundScrollView];
    }
    return self;
}


#pragma mark - UIView Overrides

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    [self updateBackgroundFrame];
    [self updateForegroundFrame];
    [self updateContentOffset];
}

- (void)setAutoresizingMask:(UIViewAutoresizing)autoresizingMask {
    [super setAutoresizingMask:autoresizingMask];
    self.backgroundView.autoresizingMask = autoresizingMask;
    self.backgroundScrollView.autoresizingMask = autoresizingMask;
    self.foregroundView.autoresizingMask = autoresizingMask;
    self.foregroundScrollView.autoresizingMask = autoresizingMask;
}


#pragma mark - UIScrollViewDelegate Protocol Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateContentOffset];
    if ([self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidScroll:scrollView];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidEndDecelerating:scrollView];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidEndScrollingAnimation:scrollView];
    }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView
                       withView:(UIView *)view
                        atScale:(float)scale {
    if ([self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidScrollToTop:scrollView];
    }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewDidZoom:scrollView];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:_cmd]) {
        return [self.scrollViewDelegate scrollViewShouldScrollToTop:scrollView];
    }
    return YES;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewWillBeginDecelerating:scrollView];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view {
    if ([self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewWillBeginZooming:scrollView withView:view];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
    if ([self.scrollViewDelegate respondsToSelector:_cmd]) {
        [self.scrollViewDelegate scrollViewWillEndDragging:scrollView
                                              withVelocity:velocity
                                       targetContentOffset:targetContentOffset];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    if ([self.scrollViewDelegate respondsToSelector:_cmd]) {
        return [self.scrollViewDelegate viewForZoomingInScrollView:scrollView];
    }
    return nil;
}


#pragma mark - Public Interface

- (UIScrollView *)scrollView {
    return self.foregroundScrollView;
}

- (void)setBackgroundHeight:(CGFloat)backgroundHeight {
    _backgroundHeight = backgroundHeight;
    [self updateBackgroundFrame];
    [self updateForegroundFrame];
    [self updateContentOffset];
}


#pragma mark - Internal Methods

- (void)updateBackgroundFrame {
    self.backgroundScrollView.frame = CGRectMake(0.0f,
                                                 0.0f,
                                                 self.frame.size.width,
                                                 self.frame.size.height);
    self.backgroundScrollView.contentSize = CGSizeMake(self.frame.size.width,
                                                       self.frame.size.height);
    self.backgroundScrollView.contentOffset	= CGPointZero;

    self.backgroundView.frame =
        CGRectMake(0.0f,
                   floorf((self.backgroundHeight - self.backgroundView.frame.size.height)/2),
                   self.frame.size.width,
                   self.backgroundView.frame.size.height);
}

- (void)updateForegroundFrame {
    self.foregroundView.frame = CGRectMake(0.0f,
                                           self.backgroundHeight,
                                           self.foregroundView.frame.size.width,
                                           self.foregroundView.frame.size.height);

    self.foregroundScrollView.frame = self.bounds;
    self.foregroundScrollView.contentSize =
        CGSizeMake(self.foregroundView.frame.size.width,
                   self.foregroundView.frame.size.height + self.backgroundHeight);
}

- (void)updateContentOffset {
    CGFloat offsetY   = self.foregroundScrollView.contentOffset.y;
    CGFloat threshold = self.backgroundView.frame.size.height - self.backgroundHeight;

    if (offsetY > -threshold && offsetY < 0.0f) {
        self.backgroundScrollView.contentOffset = CGPointMake(0.0f, floorf(offsetY/2));
    } else if (offsetY < 0.0f) {
        self.backgroundScrollView.contentOffset = CGPointMake(0.0f, offsetY + floorf(threshold/2));
    } else {
        self.backgroundScrollView.contentOffset = CGPointMake(0.0f, offsetY);
    }
}

@end
