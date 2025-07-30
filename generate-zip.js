const fs = require('fs-extra');
const path = require('path');
const archiver = require('archiver');

// Ensure dist folder exists
fs.ensureDirSync('dist');
fs.emptyDirSync('dist');
fs.copySync('src', 'dist');

// Generate ZIP
const output = fs.createWriteStream('glowandgrace.zip');
const archive = archiver('zip', { zlib: { level: 9 } });
archive.pipe(output);

archive.directory('dist/', false);
archive.finalize();
console.log("✅ ZIP generated: glowandgrace.zip");

// Create Shopify theme
fs.ensureDirSync('shopify/layout');
fs.ensureDirSync('shopify/templates');
fs.ensureDirSync('shopify/sections');
fs.ensureDirSync('shopify/snippets');

fs.writeFileSync(
  'shopify/templates/index.liquid',
  fs.readFileSync('src/index.html', 'utf8')
);

fs.writeFileSync(
  'shopify/layout/theme.liquid',
  `{% comment %} Shopify layout {% endcomment %}
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  {{ content_for_header }}
</head>
<body>
  {{ content_for_layout }}
  {% include 'cart' %}
</body>
</html>`
);

fs.writeFileSync(
  'shopify/sections/product-grid.liquid',
  `{% schema %}
{
  "name": "Product Grid",
  "settings": [
    {
      "type": "text",
      "id": "title",
      "label": "Section Title",
      "default": "Our Products"
    }
  ]
}
{% endschema %}

<div class="product-grid">
  <h2>{{ section.settings.title }}</h2>
  <div class="grid grid-cols-2 gap-4">
    {% for product in collections.frontpage.products limit:5 %}
    <div class="product-card">
      <h3>{{ product.title }}</h3>
      <p>R{{ product.price | money_without_currency }}</p>
      <img src="{{ product.featured_image }}" alt="{{ product.title }}">
    </div>
    {% endfor %}
  </div>
</div>`
);

fs.writeFileSync(
  'shopify/snippets/payjustnow-checkout.liquid',
  `https://api.payjustnow.com/v1/payment`
);

console.log("🛍️ Shopify theme created in /shopify/");
