//
// THIS CLASS IS NOT BEING USED
//
//

typedef void (^completionHandler) (id result);


@interface ConnectionHelper : NSObject


- (id)initWithURL:(NSURL*)url;


- (void) start;

/**
 Cancels a running operation at the next cancelation point and returns
 immediately.
 
 `cancel` may be send to the receiver from any thread and multiple times.
 The receiver's completion block will be called once the receiver will
 terminate with an error code indicating the cancellation.
 
 If the receiver is already cancelled or finished the message has no effect.
 */
- (void) cancel;


@property (nonatomic, readonly) BOOL isCancelled;
@property (nonatomic, readonly) BOOL isExecuting;
@property (nonatomic, readonly) BOOL isFinished;

/**
 Set or retrieves the completion handler.
 
 The completion handler will be invoked when the connection terminates. If the
 request was sucessful, the parameter `result` of the block will contain the
 response body of the GET request, otherwise it will contain a NSError object.
 
 The execution context is unspecified.
 
 Note: the completion handler is the only means to retrieve the final result of
 the HTTP request.
 */
@property (nonatomic, copy) completionHandler completionHandler;



@end

