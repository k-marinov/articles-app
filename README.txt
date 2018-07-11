Telegraph App - Keran Marinov

### Q) What Architecture did you choose and why?

I used MVVM with layered Service architecture. 
It uses routable protocols for navigation and component creator for dependency injection.
The reason for using MVVM is ability to test most of the classes in separation.
It promotes separation of concerns.
It moves the ui logic to view model rather than the views or view controller.

Only downside in a large project sometimes view models tend to do more than one thing,
however with right abstraction the responsibility view models can be reduced.

Main components of MVVM with services architecture are
• Routable - Navigation
• ViewController - Views
• ViewModel - Model for view controller/Views
• ComponentCreator - Dependency injection for view model and services
• Service - Handle business logic, make api request, read write to disk
• Remote  - Makes api request, convert response into different types
• Dao  -  protocol or class for reading, writing from local storage (if needed)
• Request - api request that has the http request,response and resource 
• Response - it holds the success logic for the request
• Resource - equivalent dto of json object

### Q) What libraries did you add to the app? What are they used for?

RxSwift / RxCocoa
• Concurrency 
• Binding ui 
• Functional reactive programming style
• Allows easy testing capabilities 
• It enables developer to write more immutable style of coding. however it is not the case most of the time, 
you will still modify global states or write impure code. The trick is to find a good balance between functional 
reactive programming and oop paradigm.

Kingfisher 
• Images

Quick/Nimble 
• Bdd style testing framewrok
• It allows to write more expressive tests with  / less set up that would require using XCTest framework

SwiftyJSON
• For json mapping


Tools / Xcode / OS Stack
Xcode version: 9.3.1 (9E501)
Swift version: Apple Swift version 4.1 (swiftlang-902.0.48 clang-902.0.37.1)
macOS version: 10.13.4 (17E199)

