<template>
  <v-app>
    <v-main>
      <!-- Header -->
      <v-app-bar
        app
        color="indigo"
        dark
        title="GIS Product Validator"
        ></v-app-bar>
      
      <!-- Left side Menu -->
      <v-navigation-drawer
        app
        dark
        :rail="rail"
        permanent
        @click="rail = false"
        >
        <v-list v-model:opened="open">
          <v-list-item
            title="Datasets"
            nav
          >
            <template v-slot:append>
              <v-btn
                variant="text"
                icon="mdi-chevron-left"
                @click.stop="rail = !rail"
              ></v-btn>
            </template>
          </v-list-item>
          <v-divider></v-divider>
          <TreeViewComponent :treeData="dirTree"/>
        </v-list>
      </v-navigation-drawer>
      
      <!-- Main container-->
      <div id="map"></div>
    </v-main>
  </v-app>
</template>

<script>
import SideBar from './components/SideBar.vue'
import HelloWorld from './components/HelloWorld.vue'
import TreeView from './components/TreeView.vue'
import TreeViewComponent from './components/TreeViewComponent.vue'
import Map from 'ol/Map.js'
import OSM from 'ol/source/OSM.js';
import TileLayer from 'ol/layer/Tile.js';
import View from 'ol/View.js';
import XYZ from 'ol/source/XYZ.js';
import GeoTIFF from 'ol/source/GeoTIFF.js';
import {fromEPSGCode, register} from 'ol/proj/proj4.js';
import proj4 from 'proj4';

export default {
  name: 'App',
  data: () => ({
    //
    map: null,
    drawer: true,
    rail: false,
    open: [],
    dirTree: [{"name": "root", "path": "/root", "children": [{"name": "foo", "path":"/root/foo", "children": [{"name": "bar", "path":"/root/foo/bar", "children": []}, {"name": "baz", "path":"/root/foo/baz", "children": []}]}, {"name": "qux", "path":"/root/qux", "children": [{"name": "quux", "path":"/root/qux/quux", "children": []}, {"name": "quuz", "path":"/root/qux/quuz"}]}]}]
  }),
  mounted() {
    register(proj4);

    const tif = new GeoTIFF({
      sources: [{
        url: "london-cog.tif",
        nodata: 0,
        min:0,
        max:500,
      }]
    });
    const tifLayer = new TileLayer({ source: tif });
    console.log(tif)

    // Create the map
    this.map = new Map({
      target: 'map',
      layers: [
        new TileLayer({
          source: new OSM()
        }),
        // new TileLayer({
        //   source: new XYZ({
        //     url: 'http://mt0.google.com/vt/lyrs=s&hl=en&x={x}&y={y}&z={z}'
        //   })
        // }),
        tifLayer
      ],
      // view: new View({
      //   center: [0, 0],
      //   zoom: 2,
      // }),
      view: tif.getView().then((viewConfig) =>
        fromEPSGCode(viewConfig.projection.getCode()).then(() => {
          return {
            center: viewConfig.center,
            resolution: viewConfig.resolutions[0],
            projection: viewConfig.projection,
          };
        })
      ),
    });
  },
  components: {
    HelloWorld,
    SideBar,
    TreeView,
    TreeViewComponent
  },
  
}
</script>

<style>
#map {
  height: 100%;
  width: 100%;
}
</style>
