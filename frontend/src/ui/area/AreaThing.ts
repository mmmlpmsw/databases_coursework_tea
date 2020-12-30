/**
 * Common interface for anything that can be placed on in-game area.
 */
import Renderable from "$src/ui/Renderable";
import Interactive from "$src/ui/Interactive";

export default interface AreaThing extends Renderable, Interactive {
    inGameSizeX: number;
    inGameSizeY: number;
    inGameX: number;
    inGameY: number;
    deletable: boolean;
    movable: boolean;
}