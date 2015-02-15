/**
 * Created by Crazy Horse on 15.02.2015.
 */
package com.dch.destroyit.landscape
{
import com.dch.destroyit.landscape.BuildingView;

public class BuildingController
{
    private var buildingModel:BuildingModel;
    private var buildingView:BuildingView;

    public function BuildingController(buildingModel:BuildingModel,buildingView:BuildingView)
    {
        this.buildingModel = buildingModel;
        this.buildingView = buildingView;
    }
}
}
