const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,haml,html,slim}'
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Inter var', ...defaultTheme.fontFamily.sans],
      },
      colors: {
        'persian-orange': '#d38e66ff',
        'chamoisee': '#957862ff',
        'baby-powder': '#fefefcff',
        'vanilla': '#fef4a3ff',
        'green': '#08473bff',
        'almond': '#eed9c5ff',
        'green-2': '#1d5544ff',
        'straw': '#efe170ff',
        'old-lace': '#fef4e7ff',
      },
      backgroundImage:{
        'yellow-grad': 'radial-gradient(at left center, #FFFFFF, #F7FBC5)',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}
