
# Analysis of proposed architecture: https://medium.com/tiendeo-tech/ios-mvp-clean-architecture-in-tiendeo-app-a8a597c49bb9
- This architecture follows Clean Architecture principles.
- UI layer uses Presenters to handle presentation logic, but we could say that Clean Architecture is UI agnostic. That means we can use MVP, MVVM or anything else on UI layer.
- Domain layer is independent and reusable.
- Data layer abstract the responses from the sources.
- Every layer has its own model that works with, so UI model doesn’t have specific details of lower layers.
- Dependency injection allows us to injecting mock implementations as dependencies and make code much more testable.
- RxSwift makes communication between layers easier than to use callbacks. RxSwift also allows to combine, zip, map, etc. responses.
- Every layer is built in its own target on Xcode project. That has allowed us to export domain and data layers to other projects with no suffering.
- Following this approach is difficult, requires a good analysis skill and it’s hard when you’re a bit pushed for time, but it’s well worth when you need to maintain and scale the code and consider it as favor for future developers.

# RxSwift + clean architecture