# Network service (Combine) Rest, GRUD

Reactive wrapper for **URLSession.shared.dataTaskPublisher** to create different set of network requests like GET, POST, PUT, DELETE

## Features
- [x] Stand alone package without any dependencies using just Apple's **Combine** facilities
- [x] Error handling from forming URLRequest object to gettting data on a subscription
- [x] Customizable for different environments development, production, testing
- [x] Customizable for different requests schemes from classic **GRUD Rest** to what suits to your own requirements



##1. Environment
Define **enum** with interface **IEnvironment**

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

##2. API for endpoint
Define endpoint API **enum** 

enum UserRestAPI {

    case index(page: Int?)
    case read(id: Int)
    case create
    case update
    case delete(id: Int)
}

Extend the enum with interface **IRequest** 

| field | type | requared |
| --- | --- | --- |
| path | String | \* |
| method | RequestMethod | \* |
| parameters | [IRequestParameter] |  |
| parameters | [IRequestParameter]  |  |

            
See the implemetation example is here **UserRestAPI.swift**

## Parameters
All parameters for a request have to conform to the interface **IRequestParameter**

See an example is here to define the pagination params **Pagination.swift**

## Request headers
All headers for a request have to conform to the interface **IRequestHeader**

See an example is here to define the content types **ContentType.swift**

##3. Create network sevice
```swift
    let network = NetworkService(
        environment: Environment.development)
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
and add `https://github.com/The-Igor/d3_network_service`.


## Server instalation
To try it in the real environment. I suggest installing the basic NodeJS Express boilerplate. Take a look on the video snippet how easy it is to get it through Webstorm that is accessible for free for a trial period.

Get **index.js** file from here and replace it with the one in the boilerplate and luanch the server.

## Real SwiftUI example
Create a project, add the package and put NetworkServiceView() in ContentView()
