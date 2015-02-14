/**
 * Created by Crazy Horse on 13.02.2015.
 */
package com.dch.destroyit.landscape
{
import com.dch.destroyit.config.CeilTypes;
import com.dch.destroyit.config.CeilTypesCreatingChance;
import com.dch.destroyit.config.LandscapeConfig;

import flash.events.EventDispatcher;

public class LandscapeModel extends EventDispatcher
{
    private var homes:Vector.<Home> = new Vector.<Home>(LandscapeConfig.HOMES_COUNT, true);

    public function LandscapeModel()
    {
        prepareLandscape(LandscapeConfig.HOMES_COUNT, LandscapeConfig.LANDSCAPE_WIDTH_IN_TILES, LandscapeConfig.LANDSCAPE_LENGTH_IN_TILES, LandscapeConfig.HOME_SIDE_MIN_SIZE_IN_TILES,
                LandscapeConfig.HOME_SIDE_MAX_SIZE_IN_TILES, LandscapeConfig.HOME_SIDE_SIZE_DIFFERENCE_IN_TILES, LandscapeConfig.FREE_DISTANCE_IN_TILES);
    }

    public function prepareLandscape(homesCount:int, landscapeWidth:Number, landscapeLength:Number, minFaceSize:Number, maxFaceSize:Number, maxSideDifference:int, freeDistance:Number):void
    {
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
        for (var i:int = 0; i < CeilTypesCreatingChance.GARBAGE_2X2; i++)
        {
            ceilTypesCache.push(CeilTypes.GARBAGE_2X2);
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

        /*cellTypes:
         *0-normal
         * 1-explode1x1
         * 2-explode2x2
         * 3-garbage2x2
         */
        var widthInTiles:int = 0;
        var lengthInTiles:int = 0;
        var rowLengthInTiles:int = 0;
        var currentHomeX:int = 0;
        var currentHomeZ:int = 0;
        for (var i:int = 0; i < homesCount; i++)
        {
            //generate home width & length
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
            if (currentHomeX + widthInTiles > landscapeWidth)
            {
                currentHomeX = 0;
                currentHomeZ += rowLengthInTiles + freeDistance;
                rowLengthInTiles = 0;
            }

            //create empty home matrix
//            var home:Vector.<Vector.<uint>> = new Vector.<Vector.<uint>>(widthInTiles, true);
            var home:Home = new Home(currentHomeX,currentHomeZ,widthInTiles,lengthInTiles);
//            for (var j = 0; j < widthInTiles; j++)
//            {
//                home[j] = new Vector.<uint>(lengthInTiles, true);
//            }

            //fill home matrix
            for (var row:int = 0; row < widthInTiles; row++)
            {
                for (var column:int = 0; column < lengthInTiles; column++)
                {
                    //cell is empty?
                    if (home.matrix[row][column] != CeilTypes.EMPTY)
                    {
                        continue;
                    }

                    //is border?
                    if (row > 0 && row < widthInTiles - 2 && column > 0 && column < lengthInTiles - 2)
                    {
                        //roll dice 0-99 and take cell from filled chances vector
                        var notEmptyCeilIndex:int = Math.round(Math.random() * 99);
                        var ceilType:uint = ceilTypesCache[notEmptyCeilIndex];
                        home.matrix[row][column]=ceilType;
                        //is 2x2?
                        if(ceilType&CeilTypes.SIZE_2X2_MASC)
                        {
                            home.matrix[row+1][column] = ceilType+CeilTypes.CEIL_AREA_MASC;
                            home.matrix[row][column+1] = ceilType+CeilTypes.CEIL_AREA_MASC;
                            home.matrix[row+1][column+1] = ceilType+CeilTypes.CEIL_AREA_MASC;
                        }
                    }else //not border
                    {
                        //roll dice 0-99 and take cell from filled chances vector
                        var emptyCeilIndex:int = Math.round(Math.random() * 99);
                        var ceilType:uint = borderCeilTypesCache[emptyCeilIndex];
                        home.matrix[row][column]=ceilType;
                    }
                    }
                }
                currentHomeX = home.width + home.x + freeDistance;
                homes[i] = home;
            }


            trace(this, "homes generated");
        }
    }
}
