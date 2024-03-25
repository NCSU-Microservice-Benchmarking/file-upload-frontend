<template>
  <div>
    <uploader
      ref="uploader"
      browse_button="browse_button"
      :url="server_config.url+'/File/'"
      :filters="{prevent_duplicates:true}"
      @inputUploader="inputUploader"
    />
    <el-tag type="warning">"Duplicated Files Not Allowed"</el-tag>
    <br/>
    <br/>
    <el-button type="primary" id="browse_button">"Select Multiple Files"</el-button>
    <br/>
    <el-table
      :data="tableData"
      style="width: 100%; margin: 10px 10px;">
      <el-table-column
        label="File Name">
        <template slot-scope="scope">
          <span>{{scope.row.name}}</span>
        </template>
      </el-table-column>
      <el-table-column
        label="size">
        <template slot-scope="scope">
          <span>{{scope.row.size}}</span>
        </template>
      </el-table-column>
      <el-table-column
        label="Status">
        <template slot-scope="scope">
          <span v-if="scope.row.status === 1">Preparing to Upload</span>
          <span v-if="scope.row.status === 4" style="color: brown">Upload Failed</span>
          <span v-if="scope.row.status === 5" style="color: chartreuse">Uploaded</span>
          <el-progress v-if="scope.row.status === 2" :text-inside="true" :stroke-width="20" :percentage="scope.row.percent"></el-progress>
        </template>
      </el-table-column>
      <el-table-column
        label="Action">
        <template slot-scope="scope">
          <el-button type="danger" @click="deleteFile(scope.row.id)">Delete</el-button>
        </template>
      </el-table-column>
    </el-table>
    <br/>
    <el-button type="danger" @click="up.start()">"Start Upload"</el-button>
  </div>
</template>

<script>
  import Uploader from './Uploader'
  export default {
    name: "MultiFileUpload",
    data() {
      return {
        files: [],
        up: {},
        server_config: this.global.server_config,
        tableData: []
      }
    },
    watch: {
      files: {
        handler() {
          this.tableData = [];
          this.files.forEach((e) => {
            this.tableData.push({
              name: e.name,
              size: e.size,
              status: e.status,
              id: e.id,
              percent: e.percent
            });
          });
        },
        deep: true
      }
    },
    methods: {
      inputUploader(up) {
        this.up = up;
        this.files = up.files;
      },
      deleteFile(id) {
        let file = this.up.getFile(id);
        this.up.removeFile(file);
      }
    },
    components: {
      'uploader': Uploader
    }
  }
</script>

<style scoped>

</style>
