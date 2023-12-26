<template>
  <v-app>
    <v-main>
      <v-app-bar
        app
        color="indigo"
        dark
        title="GIS Product Validator"
        ></v-app-bar>
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
    </v-main>
  </v-app>
</template>

<script>
import SideBar from './components/SideBar.vue'
import HelloWorld from './components/HelloWorld.vue'
import TreeView from './components/TreeView.vue'
import TreeViewComponent from './components/TreeViewComponent.vue'

export default {
  name: 'App',

  components: {
    HelloWorld,
    SideBar,
    TreeView,
    TreeViewComponent
  },

  data: () => ({
    //
    drawer: true,
    rail: false,
    open: [],
    dirTree: [{"name": "root", "path": "/root", "children": [{"name": "foo", "path":"/root/foo", "children": [{"name": "bar", "path":"/root/foo/bar", "children": []}, {"name": "baz", "path":"/root/foo/baz", "children": []}]}, {"name": "qux", "path":"/root/qux", "children": [{"name": "quux", "path":"/root/qux/quux", "children": []}, {"name": "quuz", "path":"/root/qux/quuz"}]}]}]
  }),
}
</script>
