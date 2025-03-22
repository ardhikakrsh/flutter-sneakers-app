# Sneakers App Sole City Kicks

Sole City Kicks is a sneaker marketplace mobile app built using Flutter for the frontend and Firebase for the backend. The payment system is integrated with Midtrans as the payment gateway.

# Tech Stack:

- Flutter (Frontend)
- Firebase (Authentication, Firestore, Storage)
- Node.js (Handle payment processing)
- Midtrans (Payment Gateway)

## How to use

Run in your device
- For Android emulator -> `Uri.parse('http://10.0.2.2:3000/create-transaction'),` 
- For iOS simulator -> `Uri.parse('http://localhost:3000/create-transaction'),`
- For Physical device -> `Uri.parse('http://your-ip-computer:3000/create-transaction'),`

Run the backend
- cd path/to/placeOrder.js
- `node placeOrder.js`

Use the Midtrans sandbox environment for payment simulation during development. You can test payment flows and simulate transactions without making real payments by visiting:
- API Keys: Retrieve your Server Key and Client Key from the Midtrans Sandbox Dashboard (if demo)
- https://simulator.sandbox.midtrans.com/

