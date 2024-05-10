# Mobile Pokédex

Mobile Pokédex is an iOS app designed to provide comprehensive information about Pokémon, allowing users to explore the Pokémon world in multiple languages and strategize for battles. Build and share your teams !

## Features

- Explore the Pokémon world in six different languages.
- Access detailed information on Pokémon, including evolutions, varieties, and moves.
- Create and organize teams for strategic battles.
- Intuitive interface for seamless navigation.

## Installation

1. Clone the repository.
2. Open the project in Xcode.
3. In order to use project with Firebase download a Google-Info.plist from a newly created project. ( Or remove firebase dependency from the project )
4. Build and run the app on your iOS device or simulator.

## Usage

- Upon opening the app, users can search for Pokémon by name or browse through the Pokédex.
- Tap on a Pokémon to view its details, including evolutions, varieties, and moves.
- Use the team-building feature to create strategic teams for battles.

## Technical Information

### Libraries

 - [Firebase: Analytics, Crashlytics](https://github.com/firebase/firebase-ios-sdk)
 - [OggDecoder](https://github.com/arkasas/OggDecoder)

### Architecture

- MVVM
- Dependency Injection: through Container.swift and @DIContainer propertie wrapper.
- Api: Each Api endpoints encapsulated within and ApiProtocol and an ApiQueryProtocol
- Cache: NSCache<NSUrl,UIImage>
- Persistence: SwiftData for Team building
- Modules: DI ( PersitentModels, Api, Manager ), Tools, Resources, ShareTeam (MultipeerConnection in order to send a built team)
  
<img src="https://github.com/boulomiel/PokedexIOS/assets/55102143/df4c2ac4-3a7f-4633-bfd5-0eb376cf5ba7" width="300">
<img src="https://github.com/boulomiel/PokedexIOS/assets/55102143/c8ad1944-89d9-4bf1-a4ed-3f7fe06ef2e2" width="300">
<img src="https://github.com/boulomiel/PokedexIOS/assets/55102143/9a9c4fdf-3228-4d32-9bbd-4c9929dc4514" width="300">
<img src="https://github.com/boulomiel/PokedexIOS/assets/55102143/22b299eb-fb3a-4a50-8b0e-fe7cd4db3221" width="300">
<img src="https://github.com/boulomiel/PokedexIOS/assets/55102143/03cc507d-590f-4447-8640-90d7913b74e8" width="400">
<img src="https://github.com/boulomiel/PokedexIOS/assets/55102143/5fd7304a-114d-4e62-b280-3505e4c0d04b" width="400">


## Contributing

- Screen shows with [RocketSim](https://www.rocketsim.app)
- Extensive usage of [PokeApi](PokeApi)

## License
MoonDev inc.
