//  MDCParallaxView.h
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


#import <UIKit/UIKit.h>


@interface MDCParallaxView : UIView

/// The scrollView used to display the parallax effect.
@property (nonatomic, readonly) UIScrollView *scrollView;
/// The delegate of scrollView. You must use this property when setting the scrollView delegate--attempting to set the scrollView delegate directly using `scrollView.delegate` will cause the parallax effect to stop updating.
@property (nonatomic, weak) id<UIScrollViewDelegate> scrollViewDelegate;
/// The height of the background view when at rest.
@property (nonatomic, assign) CGFloat backgroundHeight;
/// YES if the backgroundView should handle touch input. 
@property (nonatomic, getter = isBackgroundInteractionEnabled) BOOL backgroundInteractionEnabled;

/// *Designated initializer.* Creates a MDCParallaxView with the given views.
/// @param backgroundView The view to be displayed in the background. This view scrolls slower than the foreground, creating the illusion that it is "further away".
/// @param foregroundView The view to be displayed in the foreground. This view scrolls normally, and should be the one users primarily interact with.
/// @return An initialized view object or nil if the object couldn't be created.
- (id)initWithBackgroundView:(UIView *)backgroundView
              foregroundView:(UIView *)foregroundView;

@end
