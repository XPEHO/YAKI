const request = require('supertest');
const app = 'http://localhost:3000';
describe('post /login', () => {
  test('Should login user', async () => {
    await request(app)
      .post('/login')
      .send({
        login: 'dugrand',
        password: 'dugrand',
      })
      .expect(200);
  });
  test('Should fail login user', async () => {
    await request(app)
      .post('/login')
      .send({
        login: 'dugrand',
        password: 'duGrand',
      })
      .expect(204);
  });
});










