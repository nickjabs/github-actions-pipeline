const express = require("express");
const app = express();

app.get("/", (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <title>Giphy Animation</title>
      <style>
        /* Add some styles for the page */
        body {
          display: flex;
          flex-direction: column;
          justify-content: center;
          align-items: center;
          height: 100vh;
          margin: 0;
          font-family: Arial, sans-serif;
        }
        .animation {
          margin-bottom: 20px;
        }
      </style>
    </head>
    <body>
      <!-- Add the Giphy iframe -->
      <div class="animation">
        <iframe src="https://giphy.com/embed/utz68KlKM5LGBVF6HZ" width="480" height="480" frameBorder="0" class="giphy-embed" allowFullScreen></iframe>
        <p><a href="https://giphy.com/gifs/cartoon-planet-xolo-jrny-club-utz68KlKM5LGBVF6HZ">via GIPHY</a></p>
      </div>
      <!-- Your success message -->
      <div class="success-message">
        <h2>Successfully deployed on AWS EC2</h2>
        <p>Congratulations!</p>
      </div>
    </body>
    </html>
  `);
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
