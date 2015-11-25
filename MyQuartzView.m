/*

		7/16/03		1.0	DH	Initial version


#import "MyQuartzView.h"

//#### utility code
#define PI 3.14159265358979323846

static inline double radians(double degrees) { return degrees * PI / 180; }

static void
drawAnX(CGContextRef gc)
{
    CGPoint p;

    p = CGContextGetPathCurrentPoint(gc);
    CGContextMoveToPoint(gc, p.x + 3, p.y + 3);
    CGContextAddLineToPoint(gc, p.x - 3, p.y - 3);
    CGContextMoveToPoint(gc, p.x + 3, p.y - 3);
    CGContextAddLineToPoint(gc, p.x - 3, p.y + 3);
    CGContextStrokePath(gc);
}
//####


@implementation MyQuartzView

- (id)initWithFrame:(NSRect)frameRect
{
	[super initWithFrame:frameRect];
	return self;
}

- (void)drawRect:(NSRect)rect
{
    int k;
    CGRect pageRect;
    CGContextRef context = (CGContextRef)[[NSGraphicsContext currentContext] graphicsPort];
    
    //#################################################################
    //##    Insert sample drawing code here
    //##
    //##    Note that at this point, the current context CTM is set up such that
    //##        that the context size corresponds to the size of the view
    //##        i.e. one unit in the context == one pixel
    //##    Also, the origin is in the bottom left of the view with +y pointing up
    //##
    //#################################################################
    
    pageRect = CGRectMake(0, 0, rect.size.width, rect.size.height);

    CGContextBeginPage(context, &pageRect);

    //  Start with black fill and stroke colors
    CGContextSetRGBFillColor(context, 0, 0, 0, 1);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);

    //  The current path for the context starts out empty
    assert(CGContextIsPathEmpty(context));

    CGContextTranslateCTM(context, 50, 50);

    CGContextAddArc(context, 55, 210, 36, radians(25), radians(65), 0);
    CGContextStrokePath(context);

    CGContextAddArc(context, 45, 200, 36, radians(25), radians(65), 1);
    CGContextStrokePath(context);

    //  Drawing (stroking or filling) a path consumes it
    assert(CGContextIsPathEmpty(context));

    //  Draw some wide, non-antialiased ellipses
    CGContextSaveGState(context);
    CGContextSetLineWidth(context, 2);
    CGContextSetShouldAntialias(context, 0);
    CGContextTranslateCTM(context, 150, 195);
    for (k = 0; k < 4; k++) {
	CGContextAddArc(context, 0, 0, 54, 0, 2*PI, 0);
	CGContextStrokePath(context);
	CGContextTranslateCTM(context, 0, -72);
	CGContextScaleCTM(context, 1, 0.75);
    }

    CGContextRestoreGState(context);

    CGContextAddArc(context, 50, 100, 54, radians(40), radians(140), 0);
    CGContextStrokePath(context);

    CGContextBeginPath(context);
    CGContextMoveToPoint(context, 50, 85);
    CGContextAddArc(context, 50, 65, 54, radians(40), radians(140), 0);
    CGContextStrokePath(context);

    CGContextSaveGState(context);

    CGContextTranslateCTM(context, 200, 0);

    CGContextMoveToPoint(context, 50, 50);
    drawAnX(context);
    CGContextMoveToPoint(context, 50, 150);
    drawAnX(context);
    CGContextMoveToPoint(context, 150, 150);
    drawAnX(context);

    CGContextMoveToPoint(context, 50, 50);
    CGContextAddArcToPoint(context, 50, 150, 150, 150, 36);
    CGContextStrokePath(context);

    CGContextRestoreGState(context);

    CGContextEndPage(context);

    CGContextFlush(context);
}

@end