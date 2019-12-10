<template>
  <div>
    <!-- main header -->
    <header class="main-header style-two">
      <!-- Header upper -->
      <div class="header-upper">
        <div class="large-container">
          <div class="outer-box clearfix">
            <div class="float-left">
              <figure class="logo-box">
                <router-link to="/">
                  <img src="@/assets/images/logo-2.png" alt title />
                </router-link>
              </figure>
            </div>
            <div class="float-right upper-right clearfix">
              <div class="nav-outer clearfix">
                <nav class="main-menu navbar-expand-lg">
                  <div class="navbar-header">
                    <!-- Toggle Button -->
                    <button
                      type="button"
                      class="navbar-toggle"
                      data-toggle="collapse"
                      data-target="#navbarSupportedContent"
                      aria-controls="navbarSupportedContent"
                      aria-expanded="false"
                      aria-label="Toggle navigation"
                    >
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                      <span class="icon-bar"></span>
                    </button>
                  </div>
                  <div class="navbar-collapse collapse clearfix" id="navbarSupportedContent">
                    <ul class="navigation clearfix">
                      <li class="current dropdown">
                        <router-link to="/">Home</router-link>
                        <div class="megamenu"></div>
                      </li>
                      <li class="dropdown">
                        <router-link to="/register">REGISTER</router-link>
                      </li>
                      <li class="dropdown">
                        <router-link to="/login">LOGIN</router-link>
                      </li>
                    </ul>
                  </div>
                </nav>
                <!-- Main Menu End-->
              </div>
            </div>
          </div>
        </div>
      </div>
      <!--End Header Upper-->

      <!--Sticky Header-->
      <div class="sticky-header">
        <div class="container">
          <div class="clearfix">
            <!--Logo-->
            <div class="logo float-left">
              <a href="index.html" class="img-responsive">
                <img src="@/assets/images/small-logo.png" alt title />
              </a>
            </div>

            <!--Right Col-->
            <div class="right-col float-right">
              <!-- Main Menu -->
              <nav class="main-menu navbar-expand-lg">
                <div class="navbar-collapse collapse clearfix">
                  <ul class="navigation clearfix">
                    <li class="current dropdown">
                      <router-link to="/">Home</router-link>
                    </li>
                    <li class="dropdown">
                      <router-link to="/register">register</router-link>
                    </li>
                    <li class="dropdown">
                      <router-link to="/login">login</router-link>
                    </li>
                  </ul>
                </div>
              </nav>
              <!-- Main Menu End-->
            </div>
          </div>
        </div>
      </div>
      <!--End Sticky Header-->
    </header>
    <!--Form Back Drop-->
    <div class="form-back-drop"></div>
  </div>
</template>

<script>
import '@/assets/css/custom.css'
import '@/assets/css/responsive.css'
export default {
  
}
</script>