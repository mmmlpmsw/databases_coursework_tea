/**
 * Common interface for anything that can be placed on in-game area.
 */
export default interface AreaThing {
    inGameSizeX: number;
    inGameSizeY: number;
    inGameX: number;
    inGameY: number;
    deletable: boolean;
    movable: boolean;
}