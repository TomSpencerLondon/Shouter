const { environment } = require('@rails/webpacker')
const webpack = require('webpack')

environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
    jquery: 'jquery',
    autocomplete: "autocomplete"
  })
)

const config = environment.toWebpackConfig()

config.resolve.alias = {
  jquery: "jquery/src/jquery",
  'jquery-ui': 'jquery-ui-dist/jquery-ui.js'
}

module.exports = environment

