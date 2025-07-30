#!/bin/bash

# Exit on error
set -e

# Project name
PROJECT_NAME="glow-and-grace"

# Create React app
echo "Creating React app..."
npx create-react-app $PROJECT_NAME

# Navigate into project
cd $PROJECT_NAME

# Replace App.js with custom code
echo "Replacing App.js..."
cat > src/App.js << 'EOF'
import React, { useState } from "react";

export default function App() {
  const [cart, setCart] = useState([]);
  const [wishlist, setWishlist] = useState([]);
  const [activeCategory, setActiveCategory] = useState("all");
  const [searchTerm, setSearchTerm] = useState("");
  const [reviews, setReviews] = useState({});
  const [showCheckout, setShowCheckout] = useState(false);
  const [checkoutData, setCheckoutData] = useState({
    name: "",
    address: "",
    card: "",
  });

  const products = [
    {
      id: 1,
      name: "Black Soap",
      description: "For dark spots and skin rash removal",
      price: "R400.00",
      category: "soap",
      image: "https://source.unsplash.com/400x400/?black-soap",
    },
    {
      id: 2,
      name: "Magic Cleanser",
      description: "Removes all skin imperfections",
      price: "R350.00",
      category: "cleanser",
      image: " https://source.unsplash.com/400x400/?face-cleanser",
    },
    {
      id: 3,
      name: "Botanical Radiance Cream",
      description: "Hydrating | Brightening | Makes your skin lighter and glow naturally",
      price: "R200.00",
      category: "cream",
      image: " https://source.unsplash.com/400x400/?face-cream",
    },
    {
      id: 4,
      name: "Dark Spot & Stretch Mark Remover",
      description: "Targets dark spots and stretch marks",
      price: "R350.00",
      category: "remover",
      image: " https://source.unsplash.com/400x400/?skincare-bottle",
    },
    {
      id: 5,
      name: "Radiance Revival Facial Oil",
      description: "Reignite your skin’s natural glow with our luxurious Radiance Revival Facial Oil.",
      price: "R280.00",
      category: "oil",
      image: " https://source.unsplash.com/400x400/?facial-oil",
    },
  ];

  const categories = ["all", "soap", "cleanser", "cream", "remover", "oil"];

  const filteredProducts = products.filter((product) => {
    return (
      (activeCategory === "all" || product.category === activeCategory) &&
      product.name.toLowerCase().includes(searchTerm.toLowerCase())
    );
  });

  const addToCart = (product, quantity) => {
    for (let i = 0; i < quantity; i++) {
      setCart([...cart, product]);
    }
    alert(`${quantity} x ${product.name} added to cart!`);
  };

  const toggleWishlist = (product) => {
    const inWishlist = wishlist.some((item) => item.id === product.id);
    if (inWishlist) {
      setWishlist(wishlist.filter((item) => item.id !== product.id));
      alert(`${product.name} removed from wishlist.`);
    } else {
      setWishlist([...wishlist, product]);
      alert(`${product.name} added to wishlist.`);
    }
  };

  const submitReview = (productId, e) => {
    e.preventDefault();
    const form = e.target;
    const reviewText = form.review.value.trim();
    const rating = form.rating.value;

    if (!reviewText || !rating) return;

    setReviews({
      ...reviews,
      [productId]: [
        ...(reviews[productId] || []),
        {
          id: Date.now(),
          text: reviewText,
          rating: parseInt(rating),
          date: new Date().toLocaleDateString(),
        },
      ],
    });

    form.reset();
    alert("Thank you for your review!");
  };

  const handleCheckoutChange = (e) => {
    setCheckoutData({
      ...checkoutData,
      [e.target.name]: e.target.value,
    });
  };

  const handleCheckoutSubmit = () => {
    if (!checkoutData.name || !checkoutData.address || !checkoutData.card) {
      alert("Please fill in all checkout details.");
      return;
    }

    alert("Payment successful! Thank you for your order.");
    setCart([]);
    setCheckoutData({ name: "", address: "", card: "" });
    setShowCheckout(false);
  };

  return (
    <div className="font-sans text-gray-800">
      {/* UI content omitted for brevity */}
    </div>
  );
}

EOF

# Start the development server
echo "Starting the development server..."
npm start
