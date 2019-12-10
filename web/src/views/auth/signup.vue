<template>
  <v-content>
    <v-form>
      <v-container>
        <v-row align="center" justify="center">
          <v-col cols="12" sm="6" md="10">
            <v-text-field
              label="Firstname"
              color="#3d31c5"
              name="firstname"
              type="text"
            />
            <v-text-field
              label="Lastname"
              color="#3d31c5"
              name="lastname"
              type="text"
            />
            <v-text-field
              label="Email"
              color="#3d31c5"
              name="email"
              type="email"
            />
            <v-text-field
              id="password"
              label="Password"
              color="#3d31c5"
              name="password"
              type="password"
            />
          </v-col>
          <v-col cols="12" sm="6" md="7">
            <v-btn color="#3d31c5" id="inputTransform" block dark>Signup</v-btn>
          </v-col>
          <v-col cols="12" sm="6" md="9" class="mt-3 mb-6">
            <span class="text-300">
              Already have an account ?
              <router-link to="/sessions/signin" class="text-color text-600">Login</router-link>
            </span>
          </v-col>
        </v-row>
      </v-container>
    </v-form>
  </v-content>
</template>