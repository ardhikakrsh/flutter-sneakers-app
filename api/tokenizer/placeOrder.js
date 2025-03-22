const express = require("express");
const cors = require("cors");
const bodyParser = require("body-parser");
const midtransClient = require("midtrans-client");

const app = express();
const port = 3000;

// Enable CORS for all routes
app.use(cors());

// Parse JSON request bodies
app.use(bodyParser.json());

// Midtrans configuration
const snap = new midtransClient.Snap({
  isProduction: false,
  serverKey: "SB-Mid-server-4b7a_-Q6iiIw2M1U5Dckgr-u",
  clientKey: "SB-Mid-client-2kYFyiPDSMnf0SM6",
});

// API endpoint to create transaction and return token
app.post("/create-transaction", async (req, res) => {
  try {
    const { order_id, total_price, name, email, phone, items } = req.body;

    console.log("Received payment request:", req.body);

    // Format items for Midtrans
    const formattedItems = items.map((item) => ({
      id: item.id,
      price: item.price,
      quantity: item.quantity,
      name: item.name,
    }));

    // Create parameter for transaction
    const parameter = {
      transaction_details: {
        order_id: order_id,
        gross_amount: total_price,
      },
      item_details: formattedItems,
      customer_details: {
        first_name: name,
        email: email,
        phone: phone,
      },
      credit_card: {
        secure: true,
      },
    };

    console.log("Creating transaction with parameters:", parameter);

    // Create transaction
    const transaction = await snap.createTransaction(parameter);

    console.log("Transaction created successfully:", transaction);

    // Return the token and redirect URL to the client
    res.json({
      token: transaction.token,
      redirect_url: transaction.redirect_url,
    });
  } catch (error) {
    console.error("Error creating transaction:", error);
    res.status(500).json({
      error: "Failed to create transaction",
      message: error.message,
      details: error.details || "No additional details",
    });
  }
});

// Health check endpoint
app.get("/", (req, res) => {
  res.send("Midtrans Payment Server is running");
});

// Start the server
app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});
