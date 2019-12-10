<template>
  <v-content class="authLayout">
    <v-container class="fill-height">
      <v-row align="center" justify="center">
        <v-col cols="12" sm="12" xs="12" md="9">
          <v-card class="elevation-3">
            <v-row>
              <v-col col="12" sm="12" md="6">
                <div class="text-color text-600 text-center mt-4">
                  nudge.
                  <br />
                  <img src="@/assets/images/icons/clip-education.png" width="200px" />
                </div>
                <router-view />
              </v-col>
              <v-col
                col="12"
                sm="12"
                md="6"
                class="background-fill pt-12"
                v-show="$vuetify.breakpoint.mdAndUp"
              >
                <v-row align="center" justify="center" class="mt-4 mb-4">
                  <v-col cols="12" sm="8" md="8">
                    <img src="@/assets/images/icons/clip-uploading.png" width="300px" />
                    <br />
                    <div class="text-white text-center ml-8 text-24">nudge.</div>
                  </v-col>
                </v-row>
              </v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </v-content>
</template>

<style>
.authLayout {
  background: #f5ede2;
  font-family: "GalanoGrotesqueAlt";
  font-weight: 420;
  font-style: normal;
}
#inputTransform {
  text-transform: capitalize;
}
.background-fill {
  background: #3d31c5;
}
.authBtn {
  padding: 5px 10px;
  color: #fff;
  border-radius: 7px;
  width: 130px;
}
.text-24 {
  font-size: 25px;
  font-family: "GalanoGrotesqueAlt";
  font-weight: bold;
  font-style: normal;
}
.text-600 {
  font-weight: 600;
}
.text-300 {
  font-weight: 300;
}
.text-color {
  color: #3d31c5 !important;
}
</style>