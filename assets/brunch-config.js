exports.config = {
// See http://brunch.io/#documentation for docs.
  files: {
    javascripts: {
    joinTo: "js/app.js"

  },
  stylesheets: {
    joinTo: "css/app.css"
    },
    templates: {
    joinTo: "js/app.js"
    }
  },

  conventions: {
    assets: /^(static)/
  },

// Phoenix paths configuration
paths: {
// Dependencies and current project directories to watch
watched: ["static", "css", "js", "vendor"],
// Where to compile files to
public: "../priv/static"
},

// Configure your plugins
plugins: {
babel: {
// Do not use ES6 compiler in vendor code
ignore: [/vendor/]
},
sass: {
options: {
includePaths: ["node_modules/bootstrap/scss"], // Tell sass-brunch where to look for files to @import
precision: 8 // Minimum precision required by bootstrap-sass
}
},
},

modules: {
autoRequire: {
"js/app.js": ["js/app"]
}
},

npm: {
enabled: true,
globals: { // Bootstrap's JavaScript requires both '$' and 'jQuery' in global scope
$: 'jquery',
jQuery: 'jquery',
bootstrap: 'bootstrap' // Require Bootstrap's JavaScript globally
}
}
};