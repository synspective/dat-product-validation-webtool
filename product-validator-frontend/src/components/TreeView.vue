<template>
    <v-list>
        <TreeViewComponent :treeData="treeData" />
    </v-list>
</template>

<script>
import TreeViewComponent from './TreeViewComponent.vue';

export default {
    name: 'TreeView',
    components: {
        TreeViewComponent
    },
    props: {
        treeData: {
            type: Array,
            required: true
        }
    },
    data: () => ({
        open: []
    })
}
</script>

