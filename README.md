# Network service Combine Rest API GRUD
## Network requests GET, POST, PUT, DELETE

Reactive wrapper for **URLSession.shared.dataTaskPublisher** to create different set of network requests like GET, POST, PUT, DELETE

## Features
- [x] Stand alone package without any dependencies using just Apple's **Combine** facilities
- [x] Error handling from forming URLRequest object to gettting data on a subscription
- [x] Customizable for different environments development, production, testing
- [x] Customizable for different requests schemes from classic **GRUD Rest** to what suits to your own requirements



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
}
```

## 2. API for endpoint
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

| field | type | requared |
| --- | --- | --- |
| path | String | \* |
| method | RequestMethod | \* |
| headers | [IRequestHeader] |  |
| parameters | [IRequestParameter]  |  |

            
See the implemetation example here **UserRestAPI.swift**
[**UserRestAPI.swift**](https://github.com/The-Igor/d3-network-service/blob/main/Sources/d3-network-service/example/config/UserRestAPI.swift)

### Parameters
All parameters for a request have to conform to the interface [**IRequestParameter**](https://github.com/The-Igor/d3-network-service/blob/main/Sources/d3-network-service/protocol/data/IRequestParameter.swift)

See an example is here the defined pagination params [**Pagination.swift**](https://github.com/The-Igor/d3-network-service/blob/main/Sources/d3-network-service/enum/Pagination.swift)

### Request headers
All headers for a request have to conform to the interface [**IRequestHeader**](https://github.com/The-Igor/d3-network-service/blob/main/Sources/d3-network-service/protocol/data/IRequestHeader.swift)

See an example is here the defined content types [**ContentType.swift**](https://github.com/The-Igor/d3-network-service/blob/main/Sources/d3-network-service/enum/ContentType.swift)

## 3. Create network sevice
```swift
    let network = NetworkService(environment: Environment.development)
```
### Read

```swift
   let cfg = UserRestAPI.read(id: 1)
   
   let publisher = network.get(with: cfg)
```

### Create
```swift
    let cfg = UserRestAPI.create
    let data = Model(id: 11, name: "Igor")

    let publisher = network.post(data, with: cfg)
```
### Update
```swift
    let cfg = UserRestAPI.update
    let data = Model(id: 11, name: "Igor")    

    let publisher: Output = network.put(data, with: cfg)
```

### Delete
```swift
    let cfg = UserRestAPI.delete(id: 11)
    
    let publisher: Output = network.delete(with: cfg)
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
