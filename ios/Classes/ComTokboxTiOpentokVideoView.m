/**
 * Copyright (c) 2012 TokBox, Inc.
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComTokboxTiOpentokVideoView.h"
#import "ComTokboxTiOpentokVideoViewProxy.h"
#import "OTObjectProxy.h"

@implementation ComTokboxTiOpentokVideoView

// need to get a message from the Proxy when it is about to die so that the
// videoView can be invalidated (set to nil).
- (void)_invalidate
{
    _videoView = nil;
}

- (void)dealloc
{
    NSLog(@"[DEBUG] video view being deallocated");
    //RELEASE_TO_NIL(_videoView);
}

- (UIView *)videoView
{
    NSLog(@"[DEBUG] video view being created");
    if (_videoView == nil) {
        ComTokboxTiOpentokVideoViewProxy *proxy = (ComTokboxTiOpentokVideoViewProxy *)self.proxy;
        // TODO: check if there are any memory management issues here with cycles
        _videoView = (UIView *)[[(id<OTObjectProxy>)[proxy _proxy] backingOpentokObject] view];
        [self addSubview:_videoView];
        NSLog(@"[DEBUG] video view instance created: %@", _videoView.description);
    }
    
    return _videoView;
}

- (void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
    if (_videoView == nil) {
        [self videoView];
    }
    NSLog(@"[DEBUG] laying out video view");
    [TiUtils setView:_videoView positionRect:bounds];
}

@end
