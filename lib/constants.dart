import 'package:ourgame/tile.dart';

const int GRAVITY_PPSS = 2000;
const int WORLD_TO_PIXEL_RATIO = 10;

const List<List<TileType>> TILE_MAP = [
  [TileType.Grass, TileType.Grass, TileType.Grass,TileType.Grass, TileType.Grass, TileType.Grass,TileType.Grass, TileType.Grass, TileType.Grass,],
  [TileType.Surface, TileType.Surface, TileType.Surface,TileType.Surface, TileType.Surface, TileType.Surface,TileType.Surface, TileType.Surface, TileType.Surface,],
  [TileType.Deep,   TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep,],
  [TileType.Deep,   TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep,],
  [TileType.Deep,   TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep,],
  [TileType.Deep,   TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep, TileType.Deep,],
];