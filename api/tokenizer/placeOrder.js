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

    // Return the token to the client
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

// API endpoint for notification handling
app.post("/notification", async (req, res) => {
  try {
    const notification = await snap.transaction.notification(req.body);
    const orderId = notification.order_id;
    const transactionStatus = notification.transaction_status;
    const fraudStatus = notification.fraud_status;

    console.log(
      `Transaction notification received. Order ID: ${orderId}. Transaction status: ${transactionStatus}. Fraud status: ${fraudStatus}`
    );

    // Sample for handling the notification based on transaction status
    if (transactionStatus == "capture") {
      if (fraudStatus == "challenge") {
        // TODO: handle transaction challenged by FDS
      } else if (fraudStatus == "accept") {
        // TODO: handle transaction success
      }
    } else if (transactionStatus == "settlement") {
      // TODO: handle transaction settlement
    } else if (
      transactionStatus == "cancel" ||
      transactionStatus == "deny" ||
      transactionStatus == "expire"
    ) {
      // TODO: handle transaction failed
    } else if (transactionStatus == "pending") {
      // TODO: handle transaction pending
    }

    res.status(200).json({ status: "OK" });
  } catch (error) {
    console.error("Error processing notification:", error);
    res.status(500).json({ error: error.message });
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
