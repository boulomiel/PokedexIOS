# Mobile Pokédex

Mobile Pokédex is an iOS app designed to provide comprehensive information about Pokémon, allowing users to explore the Pokémon world in multiple languages and strategize for battles.

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

 - Firebase: Analytics, Crashlytics
 - OggDecoder

### Architecture

- MVVM
- Dependency Injection: through Container.swift and @DIContainer propertie wrapper.
- Api: Each Api endpoints encapsulated within and ApiProtocol and an ApiQueryProtocol
- Cache: NSCache<NSUrl,UIImage>
- Persistence: SwiftData for Team building


## Contributing

- Extensive usage of [PokeApi](PokeApi)

## License

MoonDev inc.
