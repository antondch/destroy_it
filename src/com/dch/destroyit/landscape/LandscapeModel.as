/**
 * Created by Crazy Horse on 13.02.2015.
 */
package com.dch.destroyit.landscape
{
import com.dch.destroyit.config.CeilTypes;
import com.dch.destroyit.config.CeilTypesCreatingChance;

import flash.events.EventDispatcher;

public class LandscapeModel extends EventDispatcher
{
    private var _cells:Array = [];
    private var _buildings:Vector.<BuildingModel>;


    public function generateBuildings(buildingsCount:int, landscapeWidth:Number, landscapeLength:Number, minFaceSize:Number, maxFaceSize:Number, maxSideDifference:int, freeDistance:Number, count:int):void
    {
        _buildings = new Vector.<BuildingModel>(count, true);

        //fill not border types in percent
        var ceilTypesCache:Vector.<uint> = new Vector.<uint>();
        for (var i:int = 0; i < CeilTypesCreatingChance.EMPTY; i++)
        {
            ceilTypesCache.push(CeilTypes.EMPTY);
        }
        for (var i:int = 0; i < CeilTypesCreatingChance.EXPLODE1X1; i++)
        {
            ceilTypesCache.push(CeilTypes.EXPLODE_1X1);
        }
        for (var i:int = 0; i < CeilTypesCreatingChance.EXPLODE_2X2; i++)
        {
            ceilTypesCache.push(CeilTypes.EXPLODE_2X2);
        }

        //fill border types in percent
        var borderCeilTypesCache:Vector.<uint> = new Vector.<uint>();
        for (var i:int = 0; i < CeilTypesCreatingChance.EMPTY_IN_BORDER; i++)
        {
            borderCeilTypesCache.push(CeilTypes.EMPTY);
        }
        for (var i:int = 0; i < CeilTypesCreatingChance.EXPLODE1X1_IN_BORDER; i++)
        {
            borderCeilTypesCache.push(CeilTypes.EXPLODE_1X1);
        }

        var widthInTiles:int = 0;
        var lengthInTiles:int = 0;
        var rowLengthInTiles:int = 0;
        var currentBuildingX:int = 1;
        var currentBuildingZ:int = 1;
        for (var i:int = 0; i < buildingsCount; i++)
        {
            //generate building width & length
            widthInTiles = Math.round(Math.random() * (maxFaceSize - minFaceSize) + minFaceSize);
            lengthInTiles = Math.round(Math.random() * (maxFaceSize - minFaceSize) + minFaceSize);
            while (Math.abs(widthInTiles - lengthInTiles) > maxSideDifference)
            {
                lengthInTiles = Math.round(Math.random() * (maxFaceSize - minFaceSize) + minFaceSize);
            }
            if (lengthInTiles > rowLengthInTiles)
            {
                rowLengthInTiles = lengthInTiles;
            }
            if (currentBuildingX + widthInTiles > landscapeWidth - 1)
            {
                currentBuildingX = 1;
                currentBuildingZ += rowLengthInTiles + freeDistance;
                rowLengthInTiles = 0;
            }


            //create empty building
            var building:BuildingModel = new BuildingModel(currentBuildingX, currentBuildingZ, widthInTiles, lengthInTiles);
            var _isExploded:Boolean = false;
            for (var x:int = building.x; x < building.width + building.x; x++)
            {
                if (!_cells[x])
                {
                    _cells[x] = [];
                }
                for (var z:int = building.z; z < building.length + building.z; z++)
                {
                    _cells[x][z] = building;
                }
            }
            //fill building matrix
            while (!_isExploded)
            {
                for (var row:int = 0; row < widthInTiles; row++)
                {
                    for (var column:int = 0; column < lengthInTiles; column++)
                    {
                        //cell is empty?
                        if (building.matrix[row][column] != CeilTypes.EMPTY)
                        {
                            continue;
                        }

                        //is not border?
                        if (row > 0 && row < widthInTiles - 2 && column > 0 && column < lengthInTiles - 2)
                        {
                            //roll dice 0-99 and take cell from filled chances vector
                            var notEmptyCeilIndex:int = Math.round(Math.random() * 99);
                            var ceilType:uint = ceilTypesCache[notEmptyCeilIndex];

                            if (ceilType == CeilTypes.EXPLODE_1X1)
                            {
                                _isExploded = true;
                                var garbageDice:int = Math.round(Math.random() * 99);
                                if (garbageDice < CeilTypesCreatingChance.GARBAGE_1X1)
                                {
                                    ceilType += CeilTypesCreatingChance.GARBAGE_1X1;
                                }

                            }

                            //is 2x2?
                            if (ceilType == CeilTypes.EXPLODE_2X2)
                            {
                                //not enough space for  2x2?
                                if ((building.matrix[row + 1][column] != CeilTypes.EMPTY) || (building.matrix[row][column + 1] != CeilTypes.EMPTY) || (building.matrix[row + 1][column + 1] != CeilTypes.EMPTY))
                                {
                                    continue;
                                }
                                _isExploded = true;
                                building.matrix[row][column] = ceilType;
                                building.matrix[row + 1][column] = ceilType + CeilTypes.CEIL_AREA_MASC;
                                building.matrix[row][column + 1] = ceilType + CeilTypes.CEIL_AREA_MASC;
                                building.matrix[row + 1][column + 1] = ceilType + CeilTypes.CEIL_AREA_MASC;
                            } else
                            {
                                building.matrix[row][column] = ceilType;
                            }

                        } else //is border
                        {
                            //roll dice 0-99 and take cell from filled chances vector
                            var emptyCeilIndex:int = Math.round(Math.random() * 99);
                            var ceilType:uint = borderCeilTypesCache[emptyCeilIndex];
                            var garbageDice:int = Math.round(Math.random() * 99);
                            if (ceilType == CeilTypes.EXPLODE_1X1)
                            {
                                _isExploded = true;
                                if (row > 0 && column > 0 && garbageDice < CeilTypesCreatingChance.GARBAGE_1X1_BOARD)
                                {
                                    ceilType += CeilTypesCreatingChance.GARBAGE_1X1;
                                }
                            }
                            building.matrix[row][column] = ceilType;
                        }
                    }
                }
            }
            currentBuildingX = building.width + building.x + freeDistance;
            _buildings[i] = building;
            //add building to cells map:

        }
        trace(this, "buildings generated");
    }

    public function getBuildingFromCell(x:int, z:int):BuildingModel
    {
        var result:BuildingModel;
        if (_cells[x] && _cells[x][z])
        {
            result = _cells[x][z];
        }
        return result;
    }

    public function get buildings():Vector.<BuildingModel>
    {
        return _buildings;
    }

}
}
