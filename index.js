const express = require('express');
const app = express();
const PORT = process.env.PORT || 8080;

app.get('/', (req, res) => {
  res.send('restaurant-management-system
  cd restaurant-management-system
  npm init -y come to Aenzbi Ecommerce!');
});

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
