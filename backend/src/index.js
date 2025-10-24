const app = require('./app');
const connectDB = require('./database');

async function main() {
  await connectDB();
  await app.listen(4000);
  console.log('✅ Server on port 4000');
}

main();
