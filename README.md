### Bring Your Own Core Data Stack

#### Author: Bart Jacobs

If you are building an application that makes use of Core Data, I strongly urge you to leave the checkbox **Use Core Data** unchecked when setting up your project. Having Xcode create a Core Data stack for you is fine if you are learning the framework or if you quickly want to try something out. Even though Xcode tries to be helpful by adding a basic Core Data stack in the application delegate, there are several good arguments for setting up your own Core Data stack.

While I appreciate that Apple makes it easy to get started with Core Data, in the end, it doesn't help anyone. There are a number of issues with the Core Data stack Xcode creates for you. The problem is that developers new to Core Data won't spot or bother with these shortcomings. And more experienced developers won't use the Core Data stack Xcode offers them because they know it won't serve them. In the end, it doesn't help anyone.

Not only is Xcode's implementation less than ideal, the application delegate class is not the best place to set up the Core Data stack of your application. I recommend to take a few minutes and create a separate class that manages the Core Data stack of your application. It makes everything related to Core Data easier to manage, more reusable, and, last but certainly not least, more testable. There are no compelling downsides to building your own solution.

The template Xcode provides you with has been updated for Swift and the concurrency API that was introduced several years ago. That said, the template still invokes the `abort()` function if the persistent store coordinator fails to add a persistent store. You would be surprised by the number of projects I have seen that ship with this implementation despite Apple's warning that this should not be used in production.

**Read this article on [Cocoacasts](https://cocoacasts.com/bring-your-own-core-data-stack/)**.
