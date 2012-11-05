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
- (void)updateOffsets;
@end


@implementation MDCParallaxView


#pragma mark - Object Lifecycle

- (id)initWithBackgroundView:(UIView *)backgroundView foregroundView:(UIView *)foregroundView {
    self = [super init];
    if (self) {
        _backgroundHeight = kMDCParallaxViewDefaultHeight;

        _backgroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _backgroundScrollView.backgroundColor = [UIColor clearColor];
        _backgroundScrollView.showsHorizontalScrollIndicator = NO;
        _backgroundScrollView.showsVerticalScrollIndicator = NO;

        _foregroundScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
        _foregroundScrollView.backgroundColor = [UIColor clearColor];
        _foregroundScrollView.delegate = self;

        [self addSubview:_backgroundScrollView];
        _backgroundView = backgroundView;
        _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
                                           UIViewAutoresizingFlexibleBottomMargin;
        [_backgroundScrollView addSubview:_backgroundView];

        [self addSubview:_foregroundScrollView];
        _foregroundView = foregroundView;
        _foregroundView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin |
                                           UIViewAutoresizingFlexibleBottomMargin;
        [_foregroundScrollView addSubview:_foregroundView];
    }
    return self;
}


#pragma mark - UIScrollView Overrides

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];

    self.backgroundScrollView.frame = CGRectMake(0.0, 0.0,
                                                 self.bounds.size.width, self.bounds.size.height);

    CGFloat width   = self.backgroundScrollView.frame.size.width;
    CGFloat yOffset = floorf((self.backgroundHeight - self.backgroundView.frame.size.height) / 2.0);
    CGFloat xOffset = 0.0;

    self.backgroundView.frame = CGRectMake(xOffset, yOffset, width, self.backgroundView.frame.size.height);
    self.backgroundScrollView.contentSize = CGSizeMake(width, self.bounds.size.height);
    self.backgroundScrollView.contentOffset	= CGPointZero;

    self.foregroundScrollView.frame = self.bounds;

    yOffset = self.backgroundHeight;
    xOffset = 0.0;

    CGSize contentSize = self.foregroundView.frame.size;
    contentSize.height += yOffset;

    self.foregroundView.frame = CGRectMake(xOffset,
                                           yOffset,
                                           self.foregroundView.frame.size.width,
                                           self.foregroundView.frame.size.height);
    self.foregroundScrollView.contentSize = contentSize;
    [self updateOffsets];
}


#pragma mark - UIScrollViewDelegate Protocol Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateOffsets];
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


#pragma mark - Internal Methods

- (void)updateOffsets {
    CGFloat yOffset   = self.foregroundScrollView.contentOffset.y;
    CGFloat threshold = self.backgroundView.frame.size.height - self.backgroundHeight;

    if (yOffset > -threshold && yOffset < 0) {
        self.backgroundScrollView.contentOffset = CGPointMake(0.0, floorf(yOffset / 2.0));
    } else if (yOffset < 0) {
        self.backgroundScrollView.contentOffset = CGPointMake(0.0, yOffset + floorf(threshold / 2.0));
    } else {
        self.backgroundScrollView.contentOffset = CGPointMake(0.0, yOffset);
    }
}

@end
