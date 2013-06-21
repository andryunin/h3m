# H3m

Simple parser for Heroes of Might and Magic III map format. Currently can extract info about map name, description, difficulty, size, subterranean presence and minimal required game version (to be continued, see TODO).

## Usage

Usage example:

    >> require "h3m"
    >> m = H3m::Map.new("path/to/map/file.h3m")

    >> m.name
    => "Map name"

    >> m.description
    => "Map description"
    
    >> # Version can be :SoD, :AB or :RoE
    >> m.version
    => :SoD

    >> # Size can be :S, :M, :L and :XL
    >> m.size
    => :M

    >> m.has_subterranean?
    => false

    >> # Difficulty can be :easy, :normal, :hard, :expert and :impossible
    >> m.difficulty
    => :normal


## TODO

1. players and alliances
2. victory and lose conditions
3. minimap image generation

## License

Copyright (C) 2013 Maxim Andryunin

Released under the [MIT License](http://www.opensource.org/licenses/MIT).