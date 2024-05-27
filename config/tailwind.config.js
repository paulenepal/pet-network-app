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
        'green-grad': 'linear-gradient(120deg, #fefefcff, #1E5544)',
      },
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
    require('@tailwindcss/typography'),
    require('@tailwindcss/container-queries'),
  ]
}

/*
* Created with https://www.css-gradient.com
* Gradient link: https://www.css-gradient.com/?c1=ffffff&c2=1e5544&gt=l&gd=dcl
*/

/*
* Created with https://www.css-gradient.com
* Gradient link: https://www.css-gradient.com/?c1=ffffff&c2=1e5544&gt=l&gd=dtt
*/
/*
* Created with https://www.css-gradient.com
* Gradient link: https://www.css-gradient.com/?c1=ffffff&c2=1e5544&gt=l&gd=dtl
*/