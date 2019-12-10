<template>
  <v-content>
    <v-form>
      <v-container>
        <v-row align="center" justify="center">
          <v-col cols="12" sm="6" md="10">
            <v-text-field
              label="Login"
              color="#3d31c5"
              name="Email"
              type="email"
            />
            <v-text-field
              id="password"
              width="90%"
              label="Password"
              color="#3d31c5"
              name="password"
              type="password"
            />
          </v-col>
          <v-col cols="12" sm="6" md="7">
            <v-btn color="#3d31c5" id="inputTransform" block dark>Login</v-btn>
          </v-col>
          <v-col cols="12" sm="6" md="9" class="mt-3 mb-6">
            <span class="text-300">
              Don't have an account ?
              <router-link to="/sessions/signup" class="text-color text-600">Signup</router-link>
            </span>
          </v-col>
        </v-row>
      </v-container>
    </v-form>
  </v-content>
</template>