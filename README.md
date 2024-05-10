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
  
<img src="https://github.com/boulomiel/PokedexIOS/assets/55102143/7c9d6831-a15e-4769-829c-02fe4aa92171" width="300">
<img src="https://github.com/boulomiel/PokedexIOS/assets/55102143/3f330eb7-32a3-409b-a8bc-12a01d64ea0f" width="300">
<img src="https://github.com/boulomiel/PokedexIOS/assets/55102143/382935bb-6df5-4482-b452-860dbe7a5066" width="300">
<img src="https://github.com/boulomiel/PokedexIOS/assets/55102143/3a87f008-efa4-4c07-bd9c-64878052b2f0" width="300">
<img src="https://github.com/boulomiel/PokedexIOS/assets/55102143/a78109b9-0e1f-4b4b-a322-e870c95ce588" width="300">
<img src="https://github.com/boulomiel/PokedexIOS/assets/55102143/62e6fb42-3a74-459c-95f6-10345ab820ab" width="300">
<img src="https://github.com/boulomiel/PokedexIOS/assets/55102143/de0b1d76-141b-4139-bb82-b61ce550cf48" width="300">

<img src="https://github.com/boulomiel/PokedexIOS/assets/55102143/3b58cbea-4b5b-4b59-8a9e-aaba5f548879" width="400">
<img src="https://github.com/boulomiel/PokedexIOS/assets/55102143/1959b926-e23e-42bb-be10-38571ac25c82" width="400">
<img src="https://github.com/boulomiel/PokedexIOS/assets/55102143/aec98e23-c1bc-4dfa-8b09-1b0508ba8adb" width="400">


## Contributing

- Screen shows with [RocketSim](https://www.rocketsim.app)
- Extensive usage of [PokeApi](PokeApi)

## License
MoonDev inc.
