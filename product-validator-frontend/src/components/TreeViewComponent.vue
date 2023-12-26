<template>
    <template v-for="node in treeData">
        <v-list-group v-if="node.children && node.children.length" :value="node.name">
            <template v-slot:activator="{ props }">
                <v-list-item
                  v-bind="props"
                  :title="node.name"
                ></v-list-item>
              </template>
              <TreeViewComponent :treeData="node.children" />
        </v-list-group>
        <v-list-item v-else :title="node.name" :value="node.path"></v-list-item>
    </template> 
</template>

<script>
export default {
    name: 'TreeViewComponent',
    props: {
        treeData: {
            type: Array,
            required: true
        }
    }
}
</script>
