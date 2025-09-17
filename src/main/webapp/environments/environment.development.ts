export const environment = {
  VERSION: __VERSION__,
  DEBUG_INFO_ENABLED: true,
  production: false,
  apiUrl: 'http://localhost:8080',
  stripePublicKey: '',
  stripeSecretKey: '',
};

console.log('ENV DEV:', environment);
