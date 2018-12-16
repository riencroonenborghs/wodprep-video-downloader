var gulp    = require('gulp');
var coffee  = require("gulp-coffee");
var gutil   = require("gulp-util");
var del     = require("del");
var watch   = require("gulp-watch");

var paths = {
  js_source: "src/**/*.coffee",
  js_build: "app/assets/javascripts/app",
  js_libs_source: [
    "node_modules/jquery/dist/jquery.js",
    "node_modules/angular/angular.js",
    "node_modules/angular-animate/angular-animate.js",
    "node_modules/angular-aria/angular-aria.js",
    "node_modules/angular-material/angular-material.js",
    "node_modules/moment/moment.js"
  ],
  js_libs_build: "app/assets/javascripts/libs",
  css_source: [
    "node_modules/angular-material/angular-material.css",
  ],
  css_build: "app/assets/stylesheets/libs"
};

gulp.task("clean", function() {
  del([paths.js_build]);
  del([paths.js_libs_build]);
  del([paths.css_build]);
});

gulp.task("default", function () {
  console.log("building...");
  // build coffee into js
  gulp.src(paths.js_source)
    .pipe(coffee({bare: true}).on("error", gutil.log))
    .pipe(gulp.dest(paths.js_build));
  // move js libs
  gulp.src(paths.js_libs_source).pipe(gulp.dest(paths.js_libs_build));
  // move css
  gulp.src(paths.css_source).pipe(gulp.dest(paths.css_build));
  console.log("building... done");
});

gulp.task("watch", function() {
  return watch(paths.js_source, function() {
    var date = new Date();
    console.log(date + " :: building...");
    // build coffee into js
    gulp.src(paths.js_source)
      .pipe(coffee({bare: true}).on("error", gutil.log))
      .pipe(gulp.dest(paths.js_build));
    // move js libs
    gulp.src(paths.js_libs_source).pipe(gulp.dest(paths.js_libs_build));
    // move css
    gulp.src(paths.css_source).pipe(gulp.dest(paths.css_build));
    console.log(date + " :: building... done");
  });
});