const request = require('supertest');
const app = 'http://localhost:3000';

test('Should login user', async () => {
  await request(app)
    .post('/login')
    .send({
      login: 'dugrand',
      password:
        '$5$rounds=10000$abcdefghijklmnop$OA65zl2VDjeMzN.O3S/2pSV4eWCglNv9o4nVabmkQz5',
    })
    .expect(200);
});

test('Should login user', async () => {
  await request(app)
    .post('/login')
    .send({
      login: 'dugrand',
      password: 'duGrand',
    })
    .expect(204);
});
