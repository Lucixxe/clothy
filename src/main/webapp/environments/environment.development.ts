export const environment = {
  VERSION: __VERSION__,
  DEBUG_INFO_ENABLED: true,
  production: false,
  apiUrl: 'http://localhost:8080',
  stripePublicKey: 'pk_test_51S7vEeFGOPXjlvLiazDi3wt7979MTWp9CnrKskAaAL9BFrMpUshe755kofZxdl7yqofpdP9gejTYrewCDcH8RDnP002bA39jxT',
  stripeSecretKey: 'sk_test_51S7vEeFGOPXjlvLi0VuI8Y4FqXjQz6drLnaCxXaqpatAeMqzIf0zPtBdRJGPPDYdCVLh0JLuUqtp5p2XltU8P7ZI00MpOgxiy8',
};

console.log('ENV DEV:', environment);
