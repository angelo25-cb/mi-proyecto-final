const { Router } = require('express');
const router = Router();

router.get('/', (_req, res) => {
  res.json({ message: 'Bienvenido a la API SmartBreak 🧠' });
});

router.get('/health', (_req, res) => {
  res.json({ ok: true, service: 'SmartBreak API funcionando' });
});

module.exports = router;
