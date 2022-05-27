# Network service Combine REST API CRUD
## Network requests GET, POST, PUT, DELETE

Reactive wrapper for **URLSession.shared.dataTaskPublisher** to create different set of network requests like GET, POST, PUT, DELETE

## Features
- [x] Stand alone package without any dependencies using just Apple's **Combine** facilities
- [x] Error handling from forming URLRequest object to gettting data on a subscription
- [x] Customizable for different environments development, production, testing
- [x] Customizable for different requests schemes from classic **CRUD Rest** to what suits to your own requirements



## 1. Environment
Define **enum** with interface [**IEnvironment**](https://github.com/The-Igor/d3-network-service/blob/main/Sources/d3-network-service/protocol/data/IEnvironment.swift)

```swift
enum Environment: IEnvironment {

    case development

    case production

    var baseURL: String {
        switch self {
            case .development: return "http://localhost:3000"
            case .production: return "https://google.com"
        }
    }
    
    var headers: [IRequestHeader]? {
        switch self {
            case .development: return [ContentType.applicationJSON]
            case .production: return [ContentType.textJSON]
        }
    }  
}
```

### Request headers
All headers for a request have to conform to the interface [**IRequestHeader**](https://github.com/The-Igor/d3-network-service/blob/main/Sources/d3-network-service/protocol/data/IRequestHeader.swift)

The example implemetation for content type headers is here [**ContentType.swift**](https://github.com/The-Igor/d3-network-service/blob/main/Sources/d3-network-service/enum/ContentType.swift)

## 2. REST API for endpoint
Define endpoint API **enum** 
```swift
enum UserRestAPI {

    case index(page: Int?)
    case read(id: Int)
    case create
    case update
    case delete(id: Int)
}
```

Extend the enum with interface [**IRequest**](https://github.com/The-Igor/d3-network-service/blob/main/Sources/d3-network-service/protocol/data/IRequest.swift)

| field | type |
| --- | --- |
| route | String |
| method | RequestMethod |

            
The example implemetation is here **UserRestAPI.swift**
[**UserRestAPI.swift**](https://github.com/The-Igor/d3-network-service/blob/main/Sources/d3-network-service/example/config/UserRestAPI.swift)



## 3. Create network sevice
```swift
    let network = NetworkService(environment: Environment.development)
```

`execute` - There's only one API method to do requests that gets what type of request you whant to do from the endpont configuration GET, POST, PUT, DELETE

There are four methods are available currently  GET, POST, PUT, DELETE

### Read

```swift
   let cfg = UserRestAPI.read(id: 1)
   
   let publisher: Output = network.execute(with: cfg, ["token" : 65678])
```

### Create
```swift
    let cfg = UserRestAPI.create
    let data = Model(id: 11, name: "Igor")

    let publisher: Output = network.execute(body: user, with: cfg, ["copy" : true])
```
### Update
```swift
    let cfg = UserRestAPI.update
    let data = Model(id: 11, name: "Igor")    

    let publisher: Output = network.execute(body: user, with: cfg)
```

### Delete
```swift
    let cfg = UserRestAPI.delete(id: 11)
    
    let publisher: Output = network.execute(with: cfg)
```    


## Package installation 
In Xcode - Select `Xcode`>`File`> `Swift Packages`>`Add Package Dependency...`  
and add `https://github.com/The-Igor/d3-network-service`.


## To try it in the real environment
### Server instalation (NodeJS Express)

To try it in the real environment. I suggest installing the basic NodeJS Express boilerplate. Take a look on the video snippet how easy it is to get it through Webstorm that is accessible for free for a trial period.

[![Server instalation (NodeJS Express)](https://github.com/The-Igor/d3-network-service/blob/main/img/server_install.png)](https://youtu.be/9FPOYHzcE7A)

- Get [**WebStorm Early Access**](https://www.jetbrains.com/webstorm/nextversion)
- Get [**index.js**](https://github.com/The-Igor/d3-network-service/blob/main/js/index.js) file from here and replace it with the one in the boilerplate and luanch the server.

### Real SwiftUI example
- Create a project, add the package and put [**NetworkServiceView()**](https://github.com/The-Igor/d3-network-service/blob/main/Sources/d3-network-service/example/NetworkServiceView.swift) in ContentView()
- Run server *NodeJS Express*
- Run SwiftUI project
