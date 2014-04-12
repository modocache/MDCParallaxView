## MDCParallaxView

[![Build Status](https://travis-ci.org/modocache/MDCParallaxView.svg?branch=master)](https://travis-ci.org/modocache/MDCParallaxView)

Create a parallax effect using a custom container view,
much like the top view of Path's timeline.

## Sample

![](http://i.imgflip.com/5z5b.gif)

Sample usage is available in the [`SampleApp`](https://github.com/modocache/MDCParallaxView/blob/master/SampleApp/Controllers/ImageViewController.m#L43).
Here's the gist:

```objc
- (void)viewDidLoad {
    [super viewDidLoad];

    // Create backgroud image view.
    UIImage *backgroundImage = [UIImage imageNamed:@"background.png"];
    CGRect backgroundRect = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), backgroundImage.size.height);
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:backgroundRect];
    backgroundImageView.image = backgroundImage;
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;

    // Create foreground view.
    CGRect foregroundRect = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 400.0f);
    UIView *foregroundView = [[UIView alloc] initWithFrame:foregroundRect];

    // Create parallax view with background and foreground views.
    // You can see additional configuration options in the SampleApp.
    MDCParallaxView *parallaxView = [[MDCParallaxView alloc] initWithBackgroundView:backgroundImageView
                                                                     foregroundView:foregroundView];
    parallaxView.frame = self.view.bounds;
    parallaxView.backgroundHeight = 250.0f;
    parallaxView.scrollView.scrollsToTop = YES;
    [self.view addSubview:parallaxView];
}
```

## Acknowledgements

The content offset updates are based on those found in
[PXParallaxViewController](https://github.com/tapi/PXParallaxViewController).
While that project uses a custom `UIViewController`, this
one uses a custom `UIView`, which I believe provides a better API.

