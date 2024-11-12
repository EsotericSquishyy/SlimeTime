class_name Consts

# Used for classifying tiles
enum TileType {
    Ground,
    Water,
    Rock
}

# Used for raycasting to get hovered tile
const TILEMAP_COLLISION_LAYER = 1 << 7

# Used for offsetting cursor for half tiles
const CURSOR_LOCAL_HALF_TILE_OFFSET = Vector2(0, 8)

# Used for tile overlay
const TILEMAP_LAYER_SLIME = "Slime"
const TILEMAP_LAYER_OVERLAY = "Overlay"
const TILESET_SOURCE_OVERLAY = "Overlay"
const TILESET_SOURCE_OVERLAY_HALF = "Overlay_Half"
const TILESET_OVERLAY_UNCROSSABLE = Vector2i(1, 0)
const TILESET_OVERLAY_CROSSABLE = Vector2i(2, 0)
const TILESET_OVERLAY_SLIMED = Vector2i(3, 0)
const TILESET_OVERLAY_SLIMED_TRANSPARENT = Vector2i(4, 0)
const TILESET_OVERLAY_PATH = Vector2i(5, 0)

# Used for tile data
const TILEDATA_CROSSABLE = "Crossable"
const TILEDATA_SLIMED = "Slimed"
const TILEDATA_IS_HALF_TILE = "Is_Half_Tile"
